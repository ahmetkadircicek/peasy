import 'package:flutter/material.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:peasy/core/extensions/context_extension.dart';

import 'general_text.dart';

class GeneralDivider extends StatelessWidget {
  final String? text;

  const GeneralDivider({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDivider(context, 1),
        if (text != null) _buildText(context),
        _buildDivider(context, 1),
      ],
    );
  }

  /// Dikey ayırıcı çizgiyi oluşturan widget.
  Widget _buildDivider(BuildContext context, int flex) {
    return Expanded(
      flex: flex,
      child: Divider(color: context.tertiary.withValues(alpha: 0.5)),
    );
  }

  /// Ortadaki metni oluşturan widget.
  Widget _buildText(BuildContext context) {
    return Padding(
      padding: PaddingConstants.allSmall,
      child: Label(
        text: text!,
        color: context.secondary,
        isCentred: true,
      ),
    );
  }
}
