// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/screens/profile_screen/profile_screen.dart';
import 'package:h4y_partner/screens/services_screen/services_screen.dart';
import 'package:h4y_partner/screens/dashboard_screen/dashboard_screen.dart';
import 'package:h4y_partner/screens/message_list_screen/message_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  // Selected Index
  int selectedIndex = 0;

  // Tab Bar Tabs
  final tabs = [
    const DashboardScreen(),
    const ServicesScreen(),
    const MessageListScreen(),
    const ProfileScreen(),
  ];

  // Current Index Tap
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void setStatus(String status) {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          tabs[selectedIndex],
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
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
                selectedItemColor: const Color(0xFF1C3857),
                unselectedItemColor: const Color(0xFF1C3857),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(FluentIcons.home_24_regular),
                    activeIcon: Icon(FluentIcons.home_24_filled),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.briefcase),
                    activeIcon: Icon(CupertinoIcons.briefcase_fill),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    activeIcon: Icon(CupertinoIcons.chat_bubble_fill),
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
        ],
      ),
    );
  }
}
