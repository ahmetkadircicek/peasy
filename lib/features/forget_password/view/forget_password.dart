import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/widgets/custom_text_field.dart';
import 'package:peasy/core/widgets/main_button.dart';
import 'package:peasy/features/enter_otp/view/enter_otp_view.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final int _currentStep = 0;
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
                // Back Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
                // 3 Step Horizontal Stepper
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Row(
                        children: [
                          Container(
                            width: 32,
                            height: 4,
                            decoration: BoxDecoration(
                              color: _currentStep >= index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          if (index != 2) SizedBox(width: 16),
                        ],
                      );
                    }),
                  ),
                ),

                // Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset('assets/images/brief.png'),
                ),
                // Forget Password Text
                Text(
                  'Forget Password',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // Forget Password Description
                Text(
                  'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Email TextField
                Padding(
                  padding: PaddingConstants.symmetricVerticalSmall,
                  child: CustomTextField(
                    hintText: 'Email',
                  ),
                ),
                // Continue Button
                MainButton(
                    text: 'Continue',
                    onPressed: () {
                      NavigationService.instance.navigateTo(
                        const EnterOtpView(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
