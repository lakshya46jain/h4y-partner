// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:h4y_partner/models/booked_services_model.dart';
import 'package:h4y_partner/screens/project_details_screen/components/dashed_line.dart';

class BookedItemsList extends StatelessWidget {
  final List<BookedServices>? bookedItemsList;

  const BookedItemsList({
    Key? key,
    required this.bookedItemsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookedItemsList!.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (index == 0) ? Container() : const DashedLine(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#$index",
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Qty ${bookedItemsList![index].quantity}",
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookedItemsList![index].serviceTitle!,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${bookedItemsList![index].servicePrice}",
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    bookedItemsList![index].serviceDescription!,
                    style: const TextStyle(
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
