import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo/logo_rect.png', height: 100),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
