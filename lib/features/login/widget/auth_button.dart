import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/init/navigation/navigation_service.dart';
import 'package:peasy/core/init/network/auth_service.dart';
import 'package:peasy/features/navigation/view/navigation_view.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final String imagePath;
  const AuthButton({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (title.contains("Google")) {
            final user = await AuthService().loginWithGoogle();
            if (user != null) {
              NavigationService.instance.navigateTo(
                const NavigationView(),
              );
            }
          } else if (title.contains("Apple")) {
            final user = await AuthService().loginWithApple();
            if (user != null) {
              NavigationService.instance.navigateTo(
                const NavigationView(),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              color: Theme.of(context).colorScheme.onPrimary,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
