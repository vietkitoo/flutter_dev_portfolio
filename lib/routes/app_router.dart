import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_portfolio/home/home.dart';
import 'package:flutter_dev_portfolio/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../home/bloc/home_cubit.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteList.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: RouteList.home,
      path: '/home',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => HomeScreenCubit(),
          child: const HomeScreenView(),
        );
      },
    ),
  ],
);

class RouteList {
  static const splash = 'splash';
  static const home = 'home';
}