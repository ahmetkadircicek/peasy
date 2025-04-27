import 'package:flutter/material.dart';
import 'package:peasy/core/extensions/context_extension.dart';

class GeneralSliverAppBar extends StatelessWidget {
  final bool pinned;
  final bool floating;
  final bool snap;
  final double toolbarHeight;
  final Color? backgroundColor;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final Widget? flexibleSpace;
  final ShapeBorder? shape;

  const GeneralSliverAppBar({
    super.key,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.toolbarHeight = kToolbarHeight,
    this.backgroundColor,
    this.leading,
    this.actions,
    this.title,
    this.flexibleSpace,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      snap: snap,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor ?? context.primary,
      automaticallyImplyLeading: false,
      leading: leading,
      actions: actions,
      title: flexibleSpace == null ? title : null,
      flexibleSpace: flexibleSpace,
      shape: shape,
    );
  }
}
