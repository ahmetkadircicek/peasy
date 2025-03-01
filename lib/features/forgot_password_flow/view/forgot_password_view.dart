import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forgot_password_flow/viewmodel/forgot_password_viewmodel.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
                _briefImage(context),
                // Forget Password Text
                _forgetPasswordText(context),
                // Forget Password Description
                _forgetPasswordDescription(context),
                // Email TextField
                _emailTextfield(),
                // Continue Button
                MainButton(
                    text: 'Continue',
                    onPressed: () {
                      context.read<ForgotPasswordProvider>().nextStep();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextfield() {
    return Padding(
      padding: PaddingConstants.symmetricVerticalSmall,
      child: CustomTextField(
        hintText: 'Email',
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

  Widget _forgetPasswordText(BuildContext context) {
    return Text(
      'Forget Password',
      style: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _briefImage(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset('assets/images/brief.png'),
    );
  }
}
