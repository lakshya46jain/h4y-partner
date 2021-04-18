// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/screens/services_screen/services_screen.dart';
import 'package:h4y_partner/screens/settings_screen/settings_screen.dart';
import 'package:h4y_partner/screens/dashboard_screen/dashboard_screen.dart';
import 'package:h4y_partner/screens/message_list_screen/message_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Selected Index
  int selectedIndex = 0;

  // Tab Bar Tabs
  final tabs = [
    DashboardScreen(),
    ServicesScreen(),
    MessageListScreen(),
    SettingsScreens(),
  ];

  // Current Index Tap
  void onTap(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  // Google Nav Bar Variables
  double gap = 10.0;
  double iconSize = 24.0;
  Color inactiveColor = Colors.black;
  Color mainColor = Colors.deepOrangeAccent;
  Color backgroundColor = Colors.deepOrangeAccent.withOpacity(0.15);
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
              child: GNav(
                onTabChange: onTap,
                tabs: [
                  GButton(
                    icon: FluentIcons.home_24_regular,
                    text: 'Dashboard',
                    gap: gap,
                    iconActiveColor: mainColor,
                    iconColor: inactiveColor,
                    textColor: mainColor,
                    backgroundColor: backgroundColor,
                    iconSize: iconSize,
                    padding: padding,
                  ),
                  GButton(
                    icon: FluentIcons.toolbox_24_regular,
                    text: 'Services',
                    gap: gap,
                    iconActiveColor: mainColor,
                    iconColor: inactiveColor,
                    textColor: mainColor,
                    backgroundColor: backgroundColor,
                    iconSize: iconSize,
                    padding: padding,
                  ),
                  GButton(
                    icon: FluentIcons.chat_24_regular,
                    text: 'Messages',
                    gap: gap,
                    iconActiveColor: mainColor,
                    iconColor: inactiveColor,
                    textColor: mainColor,
                    backgroundColor: backgroundColor,
                    iconSize: iconSize,
                    padding: padding,
                  ),
                  GButton(
                    icon: FluentIcons.settings_24_regular,
                    text: 'Settings',
                    gap: gap,
                    iconActiveColor: mainColor,
                    iconColor: inactiveColor,
                    textColor: mainColor,
                    backgroundColor: backgroundColor,
                    iconSize: iconSize,
                    padding: padding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
