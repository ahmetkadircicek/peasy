import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/widgets/auth_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: PaddingConstants.allLarge,
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Claps Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset('assets/images/claps.png'),
                ),
                // Sign Up Text
                Text(
                  'Sign Up',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // Sign Up Description
                Text(
                  'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Sign up with Google and Facebook
                Padding(
                  padding: PaddingConstants.symmetricVerticalSmall,
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthButton(
                        title: "Google",
                        imagePath: "assets/images/google.png",
                      ),
                      AuthButton(
                        title: "Facebook",
                        imagePath: "assets/images/facebook.png",
                      ),
                    ],
                  ),
                ),
                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'or',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
