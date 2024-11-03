import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/home/home_screen.dart';
import 'package:shope_ease/ui/news_feeds/news_feeds_screen.dart';
import 'package:shope_ease/ui/profile/profile_screen.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AppBase extends StatefulWidget {
  const AppBase({
    super.key,
  });

  @override
  MyHomePageState createState() => MyHomePageState();
  static GlobalKey<MyHomePageState> homePageKey = GlobalKey<MyHomePageState>();
}

class MyHomePageState extends State<AppBase> {
  int _selectedIndex = 0; // Index of the selected tab

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(navigateTo: onItemTapped),
      NewsFeedsScreen(navigateTo: onItemTapped),
      ProfileScreen(navigateTo: onItemTapped),
    ];
  }

  onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 24,
              width: 24,
              color: _selectedIndex == 0 ? redColor : blackColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/news.svg',
              color: _selectedIndex == 1 ? redColor : blackColor,
              height: 24,
              width: 24,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg',
                color: _selectedIndex == 2 ? redColor : blackColor,
                height: 24,
                width: 24),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: onItemTapped,
        showSelectedLabels: true,
        //
        showUnselectedLabels: true,
      ),
    );
  }
}
