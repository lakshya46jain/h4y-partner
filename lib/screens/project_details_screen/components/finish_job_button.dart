// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:pinput/pin_put/pin_put.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';

class FinishJobButton extends StatelessWidget {
  final String otp;
  final String bookingId;

  FinishJobButton({
    @required this.otp,
    @required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      onPressed: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          body: Column(
            children: [
              SizedBox(height: 5.0),
              Text(
                "COMPLETION CODE",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.0),
              PinPut(
                autofocus: true,
                fieldsCount: 6,
                textStyle: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                separator: const SizedBox(width: 2.5),
                eachFieldWidth: 40,
                eachFieldHeight: 50,
                focusNode: FocusNode(),
                controller: TextEditingController(),
                submittedFieldDecoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF95989A),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                followingFieldDecoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF95989A),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                selectedFieldDecoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF1C3857),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async {
                  if (pin.trim().toString() == otp) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await DatabaseService(bookingId: bookingId)
                        .updateBookingStatus("Job Completed");
                  } else {
                    Navigator.pop(context);
                    showCustomSnackBar(
                      context,
                      CupertinoIcons.exclamationmark_circle,
                      Colors.red,
                      "Error!",
                      "The completion code entered is incorrect. Please try again",
                    );
                  }
                },
              ),
              SizedBox(height: 25.0),
            ],
          ),
        ).show();
      },
      color: Colors.green,
      child: Text(
        "Finish Job",
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
