import 'package:flutter/material.dart';
import 'package:peasy/core/components/general_skeleton.dart';
import 'package:peasy/core/constants/constants/padding_constants.dart';

/// A skeleton widget that mimics the loading state of a category section.
class CategorySectionSkeletonWidget extends StatelessWidget {
  const CategorySectionSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            GeneralSkeleton(height: 30, width: 200),
            GeneralSkeleton(height: 30, width: 60),
          ],
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            clipBehavior: Clip.none,
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (context, index) => Padding(
              padding: PaddingConstants.onlyRightSmall,
            ),
            itemBuilder: (BuildContext context, int index) {
              return const GeneralSkeleton(height: 240, width: 180);
            },
          ),
        ),
      ],
    );
  }
}
