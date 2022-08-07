// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports

class SignatureButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  final bool withIcon;
  final String type;

  const SignatureButton({
    Key key,
    this.onTap,
    this.text,
    this.icon,
    this.withIcon,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (type == "Expanded")
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F7),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 30.0,
                        color: const Color(0xFF1C3857),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Text(
                      text,
                      style: GoogleFonts.balooPaaji2(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1C3857),
                      ),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.right_chevron,
                    color: Color(0xFFFEA700),
                    size: 25.0,
                  ),
                ],
              ),
            ),
          )
        : (type == "Back Button")
            ? IconButton(
                icon: const Icon(
                  CupertinoIcons.left_chevron,
                  size: 25.0,
                  color: Color(0xFFFEA700),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: (type == "Yellow")
                        ? const Color(0xFFFEA700)
                        : const Color(0xFF1C3857),
                  ),
                  width: double.infinity,
                  height: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: (withIcon == true)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: (type == "Yellow")
                                        ? FontWeight.w600
                                        : FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  icon,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: (type == "Yellow")
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
              );
  }
}
