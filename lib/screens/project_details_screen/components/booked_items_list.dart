// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/models/booked_services_model.dart';
import 'package:h4y_partner/screens/project_details_screen/components/dashed_line.dart';

class BookedItemsList extends StatelessWidget {
  final List<BookedServices> bookedItemsList;

  BookedItemsList({
    @required this.bookedItemsList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookedItemsList.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(0.0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (index == 0)
                ? Container(
                    height: 0.0,
                    width: 0.0,
                  )
                : DashedLine(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#$index",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Qty ${bookedItemsList[index].quantity}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${bookedItemsList[index].serviceTitle}",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${bookedItemsList[index].servicePrice}",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    bookedItemsList[index].serviceDescription,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
