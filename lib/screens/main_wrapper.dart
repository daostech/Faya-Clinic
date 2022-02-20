import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/user_account/user_account_screen.dart';
import 'package:faya_clinic/screens/cart/cart.dart';
import 'package:faya_clinic/screens/clinic/clinic_screen.dart';
import 'package:faya_clinic/screens/dates/dates_screen.dart';
import 'package:faya_clinic/screens/home/home.dart';
import 'package:faya_clinic/screens/notifications.dart';
import 'package:faya_clinic/screens/store/store.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/utils/url_launcher_util.dart';
import 'package:faya_clinic/widgets/app_bar_search.dart';
import 'package:faya_clinic/widgets/button_action.dart';
import 'package:faya_clinic/widgets/fab_expandable.dart';
import 'package:flutter/material.dart';

class HomeMainWrapper extends StatefulWidget {
  const HomeMainWrapper({Key key}) : super(key: key);

  @override
  _HomeMainWrapperState createState() => _HomeMainWrapperState();
}

class _HomeMainWrapperState extends State<HomeMainWrapper> {
  static final _actionTitles = [
    TransUtil.trans("btn_expandable_call"),
    TransUtil.trans("btn_expandable_whatsapp"),
  ];

  final _launcher = UrlLauncherUtil();

  var _bottomNavSelectedIndex = 0;
  var _currentScreenIndex = 0;

  // List<Widget> _screens = [
  //   // HomeScreen(),
  //   ClinicScreen(),
  //   StoreScreen(),
  //   DatesScreen(),
  //   MyAccountScreen(),
  //   CartScreen(),
  //   NotificationsScreen(),
  // ];

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
        return MyAccountScreen.create(context);
      case 5:
        return CartScreen();
      case 6:
        return NotificationsScreen();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      // the bottom navigation bar only have 5 sections
      // the other sections belong to the app bar
      // the main index that control the screens is _currentScreenIndex
      if (index < 5) _bottomNavSelectedIndex = index;
      _currentScreenIndex = index;
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
            // child: _screens[_currentScreenIndex],
            child: _buildTab(context),
            // child: Center(
            //   child: Text("Center"),
            // ),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        isRTL: isRTL,
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.call),
          ),
          ActionButton(
            onPressed: () => _launcher.openWhatsApp(),
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
