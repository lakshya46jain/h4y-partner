// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/screens/dashboard_screen/components/body.dart';
import 'package:h4y_partner/screens/dashboard_screen/components/header.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 1;
  String bookingStatus = "Booking Pending";
  FixedExtentScrollController scrollController;

  final items = [
    "Show All Bookings",
    "Booking Pending",
    "Job Completed",
    "Accepted",
    "Rejected",
    "Customer Cancelled",
  ];

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
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
            SizedBox(
              height: 50.0,
            ),
            Header(
              onPressed: () {
                scrollController.dispose();
                scrollController =
                    FixedExtentScrollController(initialItem: index);
                final pickerOptions = Container(
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
                          bookingStatus = "Job Completed";
                        });
                      } else if (index == 3) {
                        setState(() {
                          bookingStatus = "Accepted";
                        });
                      } else if (index == 4) {
                        setState(() {
                          bookingStatus = "Rejected";
                        });
                      } else if (index == 5) {
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
                              style: TextStyle(fontSize: 22.0),
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
