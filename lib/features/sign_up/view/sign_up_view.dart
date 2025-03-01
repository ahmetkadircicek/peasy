import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/components/divider.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/widgets/auth_button.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/sign_in/view/sign_in_view.dart';

import '../../../core/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isChecked = false;

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
                _clapsImage(context),
                // Sign Up Text
                _signUpText(context),
                // Sign Up Description
                _signUpDescription(context),
                // Sign up with Google and Facebook
                _signUpWith(),
                // Divider
                GeneralDivider(text: "or"),
                // Text Field
                CustomTextField(hintText: "Name"),
                CustomTextField(hintText: "Email"),
                CustomTextField(hintText: "Password", isPassword: true),

                // Terms and Conditions
                _termsAndConditions(context),
                // Create an account button
                MainButton(
                  text: "Create an account",
                  onPressed: () {},
                ),
                // Already have an account?
                _alreadyHaveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _alreadyHaveAccount(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text(
          "Do you have an account?",
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
                const SignInView(),
              );
            },
            child: Text(
              "Sign ",
              style: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _termsAndConditions(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(color: Colors.grey),
            activeColor: Theme.of(context).colorScheme.primary,
            checkColor: Colors.white,
          ),
        ),
        Text(
          "I agree to the Terms of Service and Privacy Policy",
          style: GoogleFonts.montserrat(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _signUpWith() {
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

  Widget _signUpDescription(BuildContext context) {
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

  Widget _signUpText(BuildContext context) {
    return Text(
      'Sign Up',
      style: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _clapsImage(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset('assets/images/claps.png'),
    );
  }
}
