import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  const CustomTextField(
      {super.key, required this.hintText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: PaddingConstants.allMedium,
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onTertiary,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
