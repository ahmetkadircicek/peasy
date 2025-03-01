import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
import 'package:peasy/features/forgot_password_flow/viewmodel/obscure_text_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObscureTextProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            obscureText: isPassword ? provider.isObscured : false,
            decoration: InputDecoration(
              contentPadding: PaddingConstants.allMedium,
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onTertiary,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        provider.isObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      onPressed: provider.toggleVisibility,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
