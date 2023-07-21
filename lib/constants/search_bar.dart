// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports

class SearchBar extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final String? hintText;

  const SearchBar({
    Key? key,
    required this.width,
    this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: width,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20.0,
              color: Color(0xFFDADADA),
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Color(0xFFFEA700),
                size: 25.0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
