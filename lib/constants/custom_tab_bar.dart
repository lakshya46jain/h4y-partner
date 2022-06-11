// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class CustomTabBar extends StatefulWidget {
  final String text1;
  final String text2;
  final Widget widget1;
  final Widget widget2;

  const CustomTabBar({
    Key key,
    this.text1,
    this.text2,
    this.widget1,
    this.widget2,
  }) : super(key: key);

  @override
  CustomTabBarState createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  int _selectedPage = 0;
  PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTabBarButton(
                text: widget.text1,
                pageNumber: 0,
                selectedPage: _selectedPage,
                onPressed: () {
                  _changePage(0);
                },
              ),
              CustomTabBarButton(
                text: widget.text2,
                pageNumber: 1,
                selectedPage: _selectedPage,
                onPressed: () {
                  _changePage(1);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _selectedPage = page;
              });
            },
            controller: _pageController,
            children: [
              widget.widget1,
              widget.widget2,
            ],
          ),
        )
      ],
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final Function onPressed;

  const CustomTabBarButton({
    Key key,
    this.text,
    this.selectedPage,
    this.pageNumber,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: 125.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? const Color(0xFFFEA700)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 2.5 : 0,
          horizontal: selectedPage == pageNumber ? 10.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 2.5,
          horizontal: selectedPage == pageNumber ? 0 : 10.0,
        ),
        child: Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23.0,
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
            color: selectedPage == pageNumber
                ? Colors.white
                : const Color(0xFF1C3857),
          ),
        ),
      ),
    );
  }
}
