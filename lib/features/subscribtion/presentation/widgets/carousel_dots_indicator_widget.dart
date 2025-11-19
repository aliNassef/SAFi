import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../data/models/subscribtion_model.dart';
import '../controller/subscribtion_cubit/subscribtion_cubit.dart';

class CarouselDotsIndicatorWidget extends StatelessWidget {
  const CarouselDotsIndicatorWidget({
    super.key,
    required List<SubscribtionModel> subscribtions,
  }) : _subscribtions = subscribtions;

  final List<SubscribtionModel> _subscribtions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribtionCubit, SubscribtionState>(
      buildWhen: (previous, current) =>
          current is SubscribtionLoading ||
          current is SubscribtionLoaded ||
          current is UpdateSubscribtionPage,
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
          final itemCount = state is SubscribtionLoaded
              ? state.subscribtions.length
              : _subscribtions.length;

          return Center(
            child: DotsIndicator(
              position: position,
              dotsCount: itemCount,
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
