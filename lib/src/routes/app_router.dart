import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_portfolio/src/features/home/bloc/home_cubit.dart';
import 'package:flutter_dev_portfolio/src/features/home/home.dart';
import 'package:flutter_dev_portfolio/src/features/about_me/about_me_screen.dart';
import 'package:flutter_dev_portfolio/src/features/splash/splash_screen.dart';
import 'package:flutter_dev_portfolio/src/features/todo-list/presentation/screen/todo_list.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dev_portfolio/src/features/menu/menu_screen.dart';

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
    GoRoute(
      path: '/about-me',
      name: RouteList.aboutMe,
      builder: (context, state) => const AboutMeScreen(),
    ),
    GoRoute(
      path: '/menu', 
      name: RouteList.menu, 
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: '/todo-list',
      name: RouteList.todoList,
      builder: (context, state) => const TodoListScreen(),
    ),
  ],
);

class RouteList {
  static const splash = 'splash';
  static const home = 'home';
  static const aboutMe = 'about-me';
  static const menu = 'menu';
  static const todoList = 'todo-list';
}