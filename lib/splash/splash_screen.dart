import 'package:flutter/material.dart';
import 'package:flutter_dev_portfolio/routes/app_router.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _goToHome();
  }

  void _goToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    context.goNamed(RouteList.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation,
              child: Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.yellowAccent,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Chờ xíu, đang chạy nè...',
              style: TextStyle(fontSize: 20, color: Colors.yellowAccent),
            ),
          ],
        ),
      ),
    );
  }
}
