import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/extensions/context_extension.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPop;
  final String title;

  const GeneralAppBar({
    super.key,
    this.onPop,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: context.surface,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          size: 30,
          color: context.primary,
        ),
        onPressed: () {
          if (onPop != null) {
            onPop!();
          }
          Navigator.of(context).pop();
        },
      ),
      title: Content(text: title, color: context.primary),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info,
            size: 30,
            color: context.primary,
          ),
          onPressed: () {
            // Add your info button action here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
