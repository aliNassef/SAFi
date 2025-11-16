import 'package:flutter/material.dart';

import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/utils/utils.dart';

class OnBoardingImageBox extends StatelessWidget {
  const OnBoardingImageBox({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .45,
      width: context.width,
      child: Stack(
        children: [
          Image.asset(
            AppAssets.on_boarding_background,
            height: context.height * 0.15,
            width: context.width,
          ),
          Positioned(
            top: context.height * 0.15,
            left: 30,
            right: 30,
            child: Image.asset(
              image,
              width: context.width,
              height: context.height * 0.3,
              // fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
