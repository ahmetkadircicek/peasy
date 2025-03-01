import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forgot_password_flow/viewmodel/forgot_password_viewmodel.dart';
import 'package:provider/provider.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: PaddingConstants.allLarge,
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image
                _lockedImage(context),
                // Reset Password Text
                _resetPasswordText(context),
                // Forget Password Description
                _forgetPasswordDescription(context),
                // Password TextField
                CustomTextField(
                  hintText: 'Password',
                  isPassword: true,
                ),
                // Confirm Password TextField
                CustomTextField(
                  hintText: 'Confirm Password',
                  isPassword: true,
                ),
                // Submit Button
                MainButton(
                    icon: Icons.lock_outline,
                    text: 'Submitting...',
                    onPressed: () {
                      context.read<ForgotPasswordProvider>().resetStep();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgetPasswordDescription(BuildContext context) {
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

  Widget _resetPasswordText(BuildContext context) {
    return Text(
      'Reset Password',
      style: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _lockedImage(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset('assets/images/locked.png'),
    );
  }
}
