import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_text.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/navigation/viewmodel/navigation_view_model.dart';
import 'package:provider/provider.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const GeneralAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Highlight(text: title ?? 'Peasy'),
      leading: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: Consumer<NavigationViewModel>(
          builder: (context, viewModel, child) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.primary,
              ),
              onPressed: () {
                viewModel.onItemTapped(0);
              },
            );
          },
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
