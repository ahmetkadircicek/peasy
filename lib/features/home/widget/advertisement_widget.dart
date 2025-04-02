import 'package:flutter/material.dart';
import 'package:peasy/core/constants/constants/general_constants.dart';
import 'package:peasy/core/extensions/context_extension.dart';
import 'package:peasy/features/home/viewmodel/advertisement_view_model.dart';
import 'package:provider/provider.dart';

class AdvertisementWidget extends StatelessWidget {
  const AdvertisementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvertisementViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.imagePaths.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildAdvertisementCarousel(context, viewModel);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 240,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          color: context.secondary,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildAdvertisementCarousel(BuildContext context, AdvertisementViewModel viewModel) {
    return Container(
      height: 240,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: GeneralConstants.instance.borderRadiusMedium,
      ),
      child: Stack(
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: viewModel.pageController,
            itemCount: viewModel.imagePaths.length,
            onPageChanged: viewModel.onPageChanged,
            itemBuilder: (context, index) {
              return Image.asset(
                viewModel.imagePaths[index],
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: context.secondary,
                  );
                },
              );
            },
          ),
          _buildPageIndicator(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context, AdvertisementViewModel viewModel) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          viewModel.imagePaths.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.currentIndex == index ? context.surface : context.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
