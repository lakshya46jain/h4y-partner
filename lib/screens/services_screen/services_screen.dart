// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/constants/custom_tab_bar.dart';
import 'package:h4y_partner/screens/create_service_screen.dart';
import 'package:h4y_partner/screens/services_screen/components/widget_1_body.dart';
import 'package:h4y_partner/screens/services_screen/components/widget_2_body.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
          padding: EdgeInsets.only(top: 50.0),
          child: CustomTabBar(
            text1: "Services",
            text2: "Rate Card",
            widget1: Widget1Body(
              user: user,
              controller: controller,
            ),
            widget2: Widget2Body(),
          ),
        ),
        floatingActionButton: Visibility(
          visible: isVisible,
          child: FloatingActionButton(
            child: Icon(
              FluentIcons.add_28_filled,
              color: Colors.white,
              size: 28.0,
            ),
            backgroundColor: Color(0xFF1C3857),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateServiceScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
