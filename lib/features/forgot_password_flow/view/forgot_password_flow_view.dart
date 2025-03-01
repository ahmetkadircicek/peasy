import 'package:flutter/material.dart';
import 'package:peasy/features/forgot_password_flow/view/enter_otp_view.dart';
import 'package:peasy/features/forgot_password_flow/view/forgot_password_view.dart';
import 'package:peasy/features/forgot_password_flow/view/reset_password_view.dart';
import 'package:peasy/features/forgot_password_flow/viewmodel/forgot_password_viewmodel.dart';
import 'package:provider/provider.dart';

class ForgotPasswordFlowView extends StatelessWidget {
  const ForgotPasswordFlowView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ForgotPasswordProvider>(context);
    int currentStep = provider.step;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _backButton(provider, context),
            _stepper(currentStep, context),
            Expanded(
              child: IndexedStack(
                index: provider.step,
                children: [
                  ForgotPasswordView(),
                  EnterOtpView(),
                  ResetPasswordView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepper(int currentStep, BuildContext context) {
    return Padding(
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
                  color: currentStep >= index
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
    );
  }

  Widget _backButton(ForgotPasswordProvider provider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              if (provider.step == 0) {
                Navigator.pop(context);
              } else {
                provider.previousStep();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            )),
      ],
    );
  }
}
