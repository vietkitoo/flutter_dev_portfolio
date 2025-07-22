import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    Center(
      child: Text('List'),
    ),
    Center(
      child: Text('About Me'),
    ),
  ];
  PageController pageController = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(// Nút quay lại
        title: const Text('Portfolio'),
        centerTitle: true,
      ),
      body: PageView(
        onPageChanged: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        selectedFontSize: 16,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Danh sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About me',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
          pageController.jumpToPage(value);
        },
      ),
    );
  }
}
