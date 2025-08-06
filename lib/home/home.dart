import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_portfolio/home/bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenView();
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    Center(child: Text('List')),
    Center(child: Text('About Me')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Portfolio'), centerTitle: true),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<HomeScreenCubit>().onPageChanged(index);
            },
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomeScreenCubit>().onTapBottomNav(index);
              _pageController.jumpToPage(index);
            },
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
          ),
        );
      },
    );
  }
}
