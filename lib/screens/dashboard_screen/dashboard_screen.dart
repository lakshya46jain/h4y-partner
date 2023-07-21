// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:permission_handler/permission_handler.dart';
// File Imports
import 'package:h4y_partner/screens/dashboard_screen/components/body.dart';
import 'package:h4y_partner/screens/dashboard_screen/components/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int index = 0;
  String? bookingStatus;
  FixedExtentScrollController? scrollController;

  final items = [
    "Show All Bookings",
    "Booking Pending",
    "Accepted",
    "Completed Projects",
    "Completed Payments",
    "Rejected",
    "Customer Cancelled",
  ];

  void getPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      Permission.notification.request();
    } else if (notificationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            Header(
              onPressed: () {
                scrollController!.dispose();
                scrollController = FixedExtentScrollController(
                  initialItem: index,
                );
                final pickerOptions = SizedBox(
                  height: 225.0,
                  child: CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: 54,
                    onSelectedItemChanged: (index) {
                      HapticFeedback.lightImpact();
                      setState(() => this.index = index);
                      if (index == 0) {
                        setState(() {
                          bookingStatus = null;
                        });
                      } else if (index == 1) {
                        setState(() {
                          bookingStatus = "Booking Pending";
                        });
                      } else if (index == 2) {
                        setState(() {
                          bookingStatus = "Accepted";
                        });
                      } else if (index == 3) {
                        setState(() {
                          bookingStatus = "Job Completed";
                        });
                      } else if (index == 4) {
                        setState(() {
                          bookingStatus = "Payment Completed";
                        });
                      } else if (index == 5) {
                        setState(() {
                          bookingStatus = "Rejected";
                        });
                      } else if (index == 6) {
                        setState(() {
                          bookingStatus = "Customer Cancelled";
                        });
                      }
                    },
                    children: items
                        .map(
                          (item) => Center(
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => pickerOptions,
                );
              },
            ),
            Expanded(
              child: DashboardScreenBody(
                bookingStatus: bookingStatus,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
