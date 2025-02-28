import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/components/divider.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/widgets/auth_button.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forget_password/view/forget_password.dart';
import 'package:peasy/features/sign_up/view/sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                // Wave Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset('assets/images/wave.png'),
                ),
                // Sign In Text
                Text(
                  'Sign In',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // Sign In Description
                Text(
                  'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Sign In with Google and Facebook
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
                GeneralDivider(text: "or"),
                // Text Field
                CustomTextField(hintText: "Email"),
                CustomTextField(hintText: "Password", obscureText: true),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      NavigationService.instance.navigateTo(
                        const ForgetPassword(),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                // Sign In Button
                MainButton(text: "Sign In", onPressed: () {}),
                // Don't have an account?
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Sign In");
                      },
                      child: GestureDetector(
                        onTap: () {
                          NavigationService.instance.navigateTo(
                            const SignUpView(),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
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
