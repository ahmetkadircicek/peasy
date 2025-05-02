import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildCircle(context, 3, -1.5),
            _buildCircle(context, -4, -0.4),
            _buildCircle(context, 3, 1),
            _buildBackdropFilter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdropFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
      child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.transparent,
          )),
    );
  }

  Widget _buildCircle(BuildContext context, double x, double y) {
    return Align(
      alignment: AlignmentDirectional(x, y),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
