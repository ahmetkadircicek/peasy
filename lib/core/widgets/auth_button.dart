import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/services/auth/auth_service.dart';
import 'package:peasy/features/navigation/view/navigation_view.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final String imagePath;
  const AuthButton({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (title == "Google") {
          final user = await AuthService().signInWithGoogle();
          if (user != null) {
            NavigationService.instance.navigateTo(
              const NavigationView(),
            );
          }
        } else if (title == "Apple") {}
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(162, 56),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Image.asset(imagePath),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
