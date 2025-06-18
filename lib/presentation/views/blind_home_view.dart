import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class BlindHomeView extends StatelessWidget {
  const BlindHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.40),
                    Colors.blue.withOpacity(0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: GlassContainer(
                height: 200,
                width: 350,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.40),
                    Colors.blue.withOpacity(0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.60),
                    Colors.white.withOpacity(0.10),
                    Colors.purpleAccent.withOpacity(0.05),
                    Colors.purpleAccent.withOpacity(0.60),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.39, 0.40, 1.0],
                ),
                // blur: 20,
                borderRadius: BorderRadius.circular(24.0),
                borderWidth: 1.0,
                elevation: 3.0,
                // isFrostedGlass: true,
                shadowColor: Colors.purple.withOpacity(0.20),
              ),
            ),
            const SizedBox(height: 20),
            GlassContainer.clearGlass(
              height: 200,
              width: 350,
              color: Colors.red,
              borderRadius: BorderRadius.circular(24.0),
              child: Text('')),
            const SizedBox(height: 20),
            GlassContainer.frostedGlass(
                height: 200,
                width: 350,
                borderRadius: BorderRadius.circular(24.0),
                child: Text(''))
          ],
        ),
      ),
    );
  }
}
