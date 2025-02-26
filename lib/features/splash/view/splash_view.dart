import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:peasy/core/extensions/context_extension.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: Image.asset('assets/images/logo.png')),
            Positioned(
              width: context.width,
              bottom: 0,
              child: SpinKitThreeBounce(
                color: context.primary,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
