import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/components/divider.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/widgets/auth_button.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forgot_password_flow/view/forgot_password_flow_view.dart';
import 'package:peasy/features/main/view/main_view.dart';
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
                _waveImage(context),

                // Sign In Text
                _signInText(context),

                // Sign In Description
                _signInDescription(context),

                // Sign In with Google and Facebook
                _signInWith(),

                // Divider
                GeneralDivider(text: "or"),

                // Text Field
                CustomTextField(hintText: "Email"),
                CustomTextField(hintText: "Password", isPassword: true),

                // Forgot Password
                _forgotPassword(context),

                // Sign In Button
                MainButton(
                  text: "Sign In",
                  onPressed: () {
                    NavigationService.instance.navigateTo(
                      const MainView(),
                    );
                  },
                ),

                // Don't have an account?
                _haveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _haveAccount(BuildContext context) {
    return Row(
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
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          NavigationService.instance.navigateTo(
            const ForgotPasswordFlowView(),
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
    );
  }

  Widget _signInWith() {
    return Padding(
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
    );
  }

  Widget _signInDescription(BuildContext context) {
    return Text(
      'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Text(
      'Sign In',
      style: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _waveImage(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset('assets/images/wave.png'),
    );
  }
}
