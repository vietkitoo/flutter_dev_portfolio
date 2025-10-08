import 'package:flutter/material.dart';
import 'package:flutter_dev_portfolio/src/routes/app_router.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuState();
}

class _MenuState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: screenHeight * 0.06),
              ItemListMenu(
                title: 'Todo-List',
                onPress: () {
                  context.pushNamed(RouteList.todoList);
                },
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                borderColor: Colors.blueAccent,
              ),
              SizedBox(height: screenHeight * 0.02),
              ItemListMenu(
                title: '',
                onPress: () {},
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                borderColor: Colors.red,
              ),
              SizedBox(height: screenHeight * 0.02),
              ItemListMenu(
                title: '',
                onPress: () {},
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                borderColor: Colors.yellowAccent,
              ),
              SizedBox(height: screenHeight * 0.02),
            ]),
          ),
        ],
      ),
    );
  }
}

class ItemListMenu extends StatefulWidget {
  final String title;
  final Function() onPress;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;

  const ItemListMenu({
    super.key,
    required this.title,
    required this.onPress,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  State<ItemListMenu> createState() => _ItemListMenuState();
}

class _ItemListMenuState extends State<ItemListMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.borderColor),
      ),
      child: ButtonTheme(
        child: ElevatedButton(
          onPressed: widget.onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
