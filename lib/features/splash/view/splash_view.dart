import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/splash/viewmodel/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().init();
    });
  }

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
