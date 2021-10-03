import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/home.dart';
import 'package:faya_clinic/utils/trans_util.dart';
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
  static const _actionTitles = [
    'Call',
    'Contact via WhatsApp',
  ];

  var _selectedIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // search app bar container
            top: 0,
            right: 0,
            left: 0,
            height: size.height * 0.2,
            child: AppBarSearch(),
          ),
          Positioned(
            // sections container
            top: size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: _screens[_selectedIndex],
            // child: Center(
            //   child: Text("Center"),
            // ),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.call),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: colorGreyDark,
        selectedIconTheme: IconThemeData(color: primaryColor),
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
