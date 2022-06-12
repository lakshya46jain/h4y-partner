// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:pinput/pinput.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
// File Imports
import 'package:h4y_partner/services/database.dart';
import 'package:h4y_partner/constants/custom_snackbar.dart';
import 'package:h4y_partner/services/onesignal_configuration.dart';

class FinishJobButton extends StatelessWidget {
  final String otp;
  final String bookingId;
  final String customerUID;

  const FinishJobButton({
    Key key,
    @required this.otp,
    @required this.bookingId,
    @required this.customerUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pin Put Declarations
    Color borderColor = const Color.fromRGBO(114, 178, 238, 1);

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 231, 240, .57),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return MaterialButton(
      padding: const EdgeInsets.symmetric(
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
              const SizedBox(height: 5.0),
              const Text(
                "COMPLETION CODE",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              Pinput(
                length: 6,
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  width: 48,
                  height: 58,
                  decoration: defaultPinTheme.decoration.copyWith(
                    border: Border.all(color: borderColor),
                  ),
                ),
                onCompleted: (pin) async {
                  if (pin.trim().toString() == otp) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await DatabaseService(bookingId: bookingId)
                        .updateBookingStatus("Job Completed");
                    sendNotification(
                      customerUID,
                      "Congratulations!",
                      "The project booked by you has been completed by the professional you have booked!",
                    );
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
              const SizedBox(height: 25.0),
            ],
          ),
        ).show();
      },
      color: Colors.green,
      child: const Text(
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
