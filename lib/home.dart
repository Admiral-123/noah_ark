import 'package:flutter/material.dart';
import 'package:noah_ark/feed_page.dart';
import 'package:noah_ark/my_account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePage();
}

class _HomePage extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const FeedPage(),
    const MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Switches the page dynamically
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'MyAccount',
          ),
        ],
      ),
    );
  }
}
