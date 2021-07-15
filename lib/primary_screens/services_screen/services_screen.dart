// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:h4y_partner/primary_screens/services_screen/body.dart';
import 'package:h4y_partner/secondary_screens/create_service_screen/create_service.dart';

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
              setState(
                () {
                  isVisible = false;
                },
              );
            }
          }
        } else {
          if (!isVisible) {
            setState(
              () {
                isVisible = true;
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Body(
          controller: controller,
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
