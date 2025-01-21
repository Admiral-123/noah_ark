import 'package:flutter/material.dart';
import 'package:noah_ark/upload_post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePage();
}

class _HomePage extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UploadPost(),
    Center(
        child: Text('Home Page',
            style: TextStyle(fontSize: 24))), // Home page placeholder
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
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
