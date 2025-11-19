import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../controller/subscribtion_cubit/subscribtion_cubit.dart';

class CarouselDotsIndicatorWidget extends StatefulWidget {
  const CarouselDotsIndicatorWidget({
    super.key,
  });

  @override
  State<CarouselDotsIndicatorWidget> createState() =>
      _CarouselDotsIndicatorWidgetState();
}

class _CarouselDotsIndicatorWidgetState
    extends State<CarouselDotsIndicatorWidget> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribtionCubit, SubscribtionState>(
      listener: (context, state) {
        if (state is SubscribtionLoaded) {
          _itemCount = state.subscribtions.length;
        }
      },
      buildWhen: (previous, current) =>
          current is SubscribtionLoading ||
          current is SubscribtionLoaded ||
          current is UpdateSubscribtionPage ||
          current is SubscribtionFailure,
      builder: (context, state) {
        if (state is SubscribtionLoading) {
          return Skeletonizer(
            enabled: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is SubscribtionLoaded || state is UpdateSubscribtionPage) {
          final position = state is UpdateSubscribtionPage
              ? state.index.toDouble()
              : 0.0;

          return Center(
            child: DotsIndicator(
              position: position,
              dotsCount: _itemCount,
              decorator: DotsDecorator(
                activeSize: const Size(14, 14),
                size: const Size(14, 14),
                activeColor:
                    ((state is UpdateSubscribtionPage &&
                            state.index % 2 == 0) ||
                        position == 0)
                    ? AppColors.primary
                    : AppColors.secondary,
                color: AppColors.deepGrey,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
