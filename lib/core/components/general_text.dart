import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _GeneralText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isBold;
  final bool isCentred;
  final double fontSize;
  final bool overflow;

  const _GeneralText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.isBold = false,
    this.isCentred = false,
    this.fontSize = 16,
    this.overflow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCentred ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
      overflow: overflow ? TextOverflow.ellipsis : null,
    );
  }
}

class Headline extends _GeneralText {
  const Headline({
    super.key,
    required super.text,
    super.color = null,
    super.isBold = true,
    super.isCentred,
    super.fontSize = 28,
  });
}

class SubHeadline extends _GeneralText {
  const SubHeadline({
    super.key,
    required super.text,
    super.color = null,
    super.isBold,
    super.isCentred,
    super.fontSize = 20,
  });
}

class Highlight extends _GeneralText {
  const Highlight({
    super.key,
    required super.text,
    super.color = null,
    super.isBold = true,
    super.isCentred,
    super.fontSize = 18,
  });
}

class Content extends _GeneralText {
  const Content({
    super.key,
    required super.text,
    super.color = null,
    super.isBold,
    super.isCentred,
    super.fontSize = 16,
  });
}

class Helper extends _GeneralText {
  const Helper({
    super.key,
    required super.text,
    super.color = null,
    super.isBold,
    super.isCentred,
    super.fontSize = 12,
    super.overflow,
  });
}

class Label extends _GeneralText {
  const Label({
    super.key,
    required super.text,
    super.color = null,
    super.isBold,
    super.isCentred,
    super.fontSize = 10,
  });
}
