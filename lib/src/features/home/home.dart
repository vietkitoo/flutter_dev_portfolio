import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_portfolio/src/features/about_me/about_me_screen.dart';
import 'package:flutter_dev_portfolio/src/features/home/bloc/home_cubit.dart';
import 'package:flutter_dev_portfolio/src/features/menu/menu_screen.dart';

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

  final List<Widget> _pages = [
    MenuScreen(),
    AboutMeScreen(),
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
            onTap: (index) async {
              context.read<HomeScreenCubit>().onTapBottomNav(index);
              _pageController.jumpToPage(index);
              FirebaseAnalytics.instance.logEvent(
                name: 'portfolio_app_open',
              );
              await FirebaseAnalytics.instance
                  .logBeginCheckout(
                  value: 10.0,
                  currency: 'USD',
                  items: [
                    AnalyticsEventItem(
                        itemName: 'Socks',
                        itemId: 'xjw73ndnw',
                        price: 10.0,
                    ),
                  ],
                  coupon: '10PERCENTOFF',
              );
            },
            selectedItemColor: Colors.blueAccent,
            selectedFontSize: 16,
            unselectedItemColor: Colors.black54,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'About Me',
              ),
            ],
          ),
        );
      },
    );
  }
}