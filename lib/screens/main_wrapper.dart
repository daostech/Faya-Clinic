import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/providers/notifications_controller.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/auth_required.dart';
import 'package:faya_clinic/screens/chat/chat_screen.dart';
import 'package:faya_clinic/screens/user_account/user_account_screen.dart';
import 'package:faya_clinic/screens/cart/cart.dart';
import 'package:faya_clinic/screens/clinic/clinic_screen.dart';
import 'package:faya_clinic/screens/dates/dates_screen.dart';
import 'package:faya_clinic/screens/home/home.dart';
import 'package:faya_clinic/screens/notifications/notifications_screen.dart';
import 'package:faya_clinic/screens/store/store.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/utils/url_launcher_util.dart';
import 'package:faya_clinic/widgets/app_bar_search.dart';
import 'package:faya_clinic/widgets/button_action.dart';
import 'package:faya_clinic/widgets/fab_expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMainWrapper extends StatefulWidget {
  final NotificationsController? controller;
  const HomeMainWrapper({Key? key, this.controller}) : super(key: key);

  @override
  _HomeMainWrapperState createState() => _HomeMainWrapperState();
}

class _HomeMainWrapperState extends State<HomeMainWrapper> {
  static final _actionTitles = [
    TransUtil.trans("btn_expandable_call"),
    TransUtil.trans("btn_expandable_whatsapp"),
  ];

  final _launcher = UrlLauncherUtil();
  late NotificationsController notificationsController;
  late AuthController authController;

  var _bottomNavSelectedIndex = 0;
  var _currentScreenIndex = 0;

  Widget _buildTab(BuildContext context) {
    switch (_currentScreenIndex) {
      case 0:
        return HomeScreen.create(context);
      case 1:
        return ClinicScreen.create(context);
      case 2:
        return StoreScreen.create(context);
      case 3:
        return DatesScreen.create(context);
      case 4:
        return MyAccountScreen.create(context, () {
          Provider.of<AuthController>(context, listen: false).logout();
          Provider.of<CartController>(context, listen: false).clearCart();
          _onItemTapped(0);
        });
      case 5:
        return CartScreen();
      case 6:
        return NotificationsScreen();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    // if the user is not logged in redirect them to the logging screen
    // for the screens that need authentication
    final isLoggedIn = authController.authState!.value == AuthState.LOGGED_IN.value;

    if (!isLoggedIn) {
      switch (index) {
        case 3:
        case 4:
        case 5:
        case 6:
          AuthRequiredScreen.show(context);
          return;
      }
    }

    setState(() {
      // the bottom navigation bar only have 5 sections
      // the other sections belong to the app bar
      // the main index that control the screens is _currentScreenIndex
      if (index < 5) _bottomNavSelectedIndex = index;
      _currentScreenIndex = index;
      if (index == 6) notificationsController.onNotificationsScreenOpened();
    });
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // context.read<AuthRepositoryBase>().updateDeviceToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notificationsController = context.watch<NotificationsController>();
    authController = context.watch<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRTL = TransUtil.isArLocale(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // search app bar container
            top: 0,
            right: 0,
            left: 0,
            height: size.height * 0.2,
            child: AppBarSearch(
              onCartTap: () => _onItemTapped(5),
              onNotificationTap: () => _onItemTapped(6),
            ),
          ),
          Positioned(
            // sections container
            top: size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildTab(context),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        isRTL: isRTL,
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () async => _launcher.openDialNumber().catchError((error) {
              if (error != null) {
                DialogUtil.showToastMessage(context, TransUtil.trans(error));
              }
            }),
            // onPressed: () => ChatScreen.create(context),
            icon: const Icon(Icons.call),
          ),
          ActionButton(
            // onPressed: () async => _launcher.openWhatsApp().catchError((error) {
            //   if (error != null) {
            //     DialogUtil.showToastMessage(context, TransUtil.trans(error));
            //   }
            // }),
            onPressed: () {
              final loggedIn = authController.authState!.value == AuthState.LOGGED_IN.value;
              if (!loggedIn) {
                AuthRequiredScreen.show(context);
                return;
              }
              ChatScreen.create(context);
            },

            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavSelectedIndex,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorGreyDark,
        selectedIconTheme: IconThemeData(color: colorPrimary),
        showUnselectedLabels: true,
        enableFeedback: false,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: (index) => _onItemTapped(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: TransUtil.trans("nav_label_home"),
            tooltip: TransUtil.trans("nav_label_home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps_outlined,
            ),
            label: TransUtil.trans("nav_label_clinic"),
            tooltip: TransUtil.trans("nav_label_clinic"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: TransUtil.trans("nav_label_store"),
            tooltip: TransUtil.trans("nav_label_store"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: TransUtil.trans("nav_label_dates"),
            tooltip: TransUtil.trans("nav_label_dates"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: TransUtil.trans("nav_label_my_account"),
            tooltip: TransUtil.trans("nav_label_my_account"),
          ),
        ],
      ),
    );
  }
}
