import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralTag extends StatelessWidget {
  final String label;
  final Color color;

  const GeneralTag({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}
