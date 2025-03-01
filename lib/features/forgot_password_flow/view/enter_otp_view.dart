import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/forgot_password_flow/viewmodel/forgot_password_viewmodel.dart';
import 'package:provider/provider.dart';

class EnterOtpView extends StatelessWidget {
  const EnterOtpView({super.key});

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
                // Enter OTP Text
                _enterOTP(context),
                // Enter OTP Description
                _description(context),
                // 6 Digit OTP TextField
                _OTPTextfield(context),

                // Reset Password Button
                MainButton(
                    text: 'Reset Password',
                    onPressed: () {
                      context.read<ForgotPasswordProvider>().nextStep();
                    }),
                // Didn't receive OTP?
                _resendOTP(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resendOTP(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text(
          'Didn\'t get OTP?',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          'Resend OTP',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _OTPTextfield(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmetricVerticalSmall,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: List.generate(5, (index) {
          return Container(
            width: 56,
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
              ),
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Text(
      'Enter the OTP code we just sent you on your registered email address',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _enterOTP(BuildContext context) {
    return Text(
      'Enter OTP',
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
