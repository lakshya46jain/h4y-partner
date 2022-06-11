// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/custom_tab_bar.dart';
import 'package:h4y_partner/screens/service_screens/create_service_screen.dart';
import 'package:h4y_partner/screens/services_screen/components/widget_1_body.dart';
import 'package:h4y_partner/screens/services_screen/components/widget_2_body.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key key}) : super(key: key);

  @override
  ServicesScreenState createState() => ServicesScreenState();
}

class ServicesScreenState extends State<ServicesScreen> {
  var controller = ScrollController();
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(
      () {
        if (controller.position.atEdge) {
          if (controller.position.pixels > 0) {
            if (isVisible) {
              setState(() {
                isVisible = false;
              });
            }
          }
        } else {
          if (!isVisible) {
            setState(() {
              isVisible = true;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: CustomTabBar(
            text1: "Services",
            text2: "Rate Card",
            widget1: Widget1Body(
              user: user,
              controller: controller,
            ),
            widget2: const Widget2Body(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Visibility(
            visible: isVisible,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF1C3857),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateServiceScreen(),
                  ),
                );
              },
              child: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
                size: 28.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
