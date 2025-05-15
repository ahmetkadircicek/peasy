import 'package:flutter/material.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class GeneralSkeleton extends StatelessWidget {
  const GeneralSkeleton({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  final double height;
  final double width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.primary.withValues(alpha: 0.1),
      highlightColor: context.primary.withValues(alpha: 0.01),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.surfaceContainer,
          borderRadius: BorderRadius.circular(
            borderRadius ??
                GeneralConstants.instance.borderRadiusMedium.topLeft.x,
          ),
          border: Border.all(
            color: context.surfaceContainer,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
