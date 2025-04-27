import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/components/general_divider.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/core/widgets/auth_button.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forgot_password_flow/view/forgot_password_flow_view.dart';
import 'package:peasy/features/navigation/view/navigation_view.dart';
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
                _buildWaveImage(context),

                // Sign In Text
                _buildSignInText(context),

                // Sign In Description
                _buildSignInDescription(context),

                // Sign In with Google and Apple
                _buildSignInWith(),

                // Divider
                GeneralDivider(text: "or"),

                // Text Field
                CustomTextField(hintText: "Email"),
                CustomTextField(hintText: "Password", isPassword: true),

                // Forgot Password
                _buildForgotPassword(context),

                // Sign In Button
                MainButton(
                  text: "Sign In",
                  onPressed: () {
                    NavigationService.instance.navigateTo(
                      const NavigationView(),
                    );
                  },
                ),

                // Don't have an account?
                _buildHaveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHaveAccount(BuildContext context) {
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
              color: context.primary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
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
            color: context.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWith() {
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
            title: "Apple",
            imagePath: "assets/images/apple.png",
          ),
        ],
      ),
    );
  }

  Widget _buildSignInDescription(BuildContext context) {
    return Text(
      'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: context.secondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return Text(
      'Sign In',
      style: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: context.primary,
      ),
    );
  }

  Widget _buildWaveImage(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: context.tertiary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset('assets/images/wave.png'),
    );
  }
}
