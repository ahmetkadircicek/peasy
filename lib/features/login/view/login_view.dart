import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/login/widget/auth_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          _buildBackground(context),
          // White Gradient Overlay
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(1),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: PaddingConstants.allLarge,
              child: Column(
                spacing: 16,
                children: [
                  // Logo at the top
                  _buildLogo(),
                  Spacer(),
                  // Welcome text
                  _buildWelcome(),

                  // Login buttons
                  _buildLoginWith(),

                  // Privacy text
                  _buildPrivacy(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Image.asset(
        'assets/images/logo.png',
        width: 160,
      ),
    );
  }

  Widget _buildLoginWith() {
    return Padding(
      padding: PaddingConstants.symmetricVerticalSmall,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthButton(
            title: "Google ile devam et",
            imagePath: "assets/images/google.png",
          ),
          const SizedBox(height: 16),
          AuthButton(
            title: "Apple ile devam et",
            imagePath: "assets/images/apple.png",
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Image.asset(
      'assets/images/singin_background.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  Widget _buildPrivacy() {
    return Builder(
      builder: (context) {
        return Text(
          'Devam ederek, Kullanım Koşulları ve Gizlilik Politikasını kabul etmiş olursunuz',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: context.onSurface,
          ),
        );
      },
    );
  }

  Widget _buildWelcome() {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Text(
              'Hoşgeldiniz',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.primary,
              ),
            ),

            // App description
            Text(
              'Peasy ile alışverişlerinizi kolayca yönetin ve takip edin',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: context.onSurface,
              ),
            ),
          ],
        );
      },
    );
  }
}
