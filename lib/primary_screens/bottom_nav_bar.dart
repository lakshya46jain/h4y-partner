// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/primary_screens/profile_screen/profile_screen.dart';
import 'package:h4y_partner/primary_screens/services_screen/services_screen.dart';
import 'package:h4y_partner/primary_screens/dashboard_screen/dashboard_screen.dart';
import 'package:h4y_partner/primary_screens/message_list_screen/message_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  // Selected Index
  int selectedIndex = 0;

  // Tab Bar Tabs
  final tabs = [
    DashboardScreen(),
    ServicesScreen(),
    MessageListScreen(),
    ProfileScreen(),
  ];

  // Current Index Tap
  void onTap(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void setStatus(String status) {
    DatabaseService(uid: FirebaseAuth.instance.currentUser.uid)
        .updateUserStatus(status);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            onTap: onTap,
            elevation: 0.0,
            iconSize: 27.0,
            selectedFontSize: 1.0,
            unselectedFontSize: 1.0,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF1C3857),
            unselectedItemColor: Color(0xFF1C3857),
            items: [
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.home_24_regular),
                activeIcon: Icon(FluentIcons.home_24_filled),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.toolbox_24_regular),
                activeIcon: Icon(FluentIcons.toolbox_24_filled),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.chat_24_regular),
                activeIcon: Icon(FluentIcons.chat_24_filled),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.person_24_regular),
                activeIcon: Icon(FluentIcons.person_24_filled),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
