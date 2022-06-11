// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:h4y_partner/models/user_model.dart';
import 'package:h4y_partner/services/database.dart';

class ProfileStream extends StatelessWidget {
  const ProfileStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserDataProfessional userData = snapshot.data;
        if (snapshot.hasData) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
              children: [
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 20.0,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      height: 75.0,
                      width: 75.0,
                      imageUrl: userData.profilePicture,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.fullName,
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 25.0,
                        color: Color(0xFF1C3857),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      userData.phoneNumber,
                      style: const TextStyle(
                        height: 1.0,
                        fontSize: 18.0,
                        color: Color(0xFF95989A),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Row(
              children: [
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 20.0,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      height: 75.0,
                      width: 75.0,
                      imageUrl:
                          "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Professional Name",
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 25.0,
                        color: Color(0xFF1C3857),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "Professional Phone Number",
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 18.0,
                        color: Color(0xFF95989A),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
