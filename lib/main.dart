// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:firebase_core/firebase_core.dart';
// File Imports
import 'package:h4y_partner/services/auth.dart';
import 'package:h4y_partner/screens/wrapper.dart';
import 'package:h4y_partner/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  RateMyApp rateMyApp = RateMyApp(
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: '',
    appStoreIdentifier: '',
  );

  // Navigator Key
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Rate My App Feature
    rateMyApp.init().then(
      (_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showStarRateDialog(
            context,
            title: 'Rate H4Y Partner',
            message:
                'Did you like your experience with H4Y Partner? Then take a little bit of your time to leave a rating:',
            actionsBuilder: (context, stars) {
              return [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    await rateMyApp
                        .callEvent(RateMyAppEventType.rateButtonPressed)
                        .then(
                          (value) => Navigator.pop<RateMyAppDialogButton>(
                            context,
                            RateMyAppDialogButton.rate,
                          ),
                        );
                  },
                ),
              ];
            },
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: const StarRatingOptions(),
            onDismissed: () => rateMyApp.callEvent(
              RateMyAppEventType.laterButtonPressed,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Help4YouUser>.value(
      initialData: Help4YouUser(),
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}
