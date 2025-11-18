import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/utils/utils.dart';
import 'package:safi/core/widgets/custom_failure_widget.dart';
import 'package:safi/features/subscribtion/presentation/controller/subscribtion_cubit/subscribtion_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../data/models/subscribtion_model.dart';
import 'carousel_slider_widget.dart';

class SubscribtionViewBody extends StatefulWidget {
  const SubscribtionViewBody({
    super.key,
  });

  @override
  State<SubscribtionViewBody> createState() => _SubscribtionViewBodyState();
}

class _SubscribtionViewBodyState extends State<SubscribtionViewBody> {
  final int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(30),
        Text(
          LocaleKeys.available_packages.tr(),
          style: context.appTheme.semiBold20.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
        const Gap(30),
        BlocBuilder<SubscribtionCubit, SubscribtionState>(
          buildWhen: (previous, current) =>
              current is SubscribtionFailure ||
              current is SubscribtionLoaded ||
              current is SubscribtionLoading,
          builder: (context, state) {
            if (state is SubscribtionLoaded) {
              return CarouselSliderWidget(
                instance: state.subscribtions[_currentPage],
                onPageChanged: (index, _) {
                  context.read<SubscribtionCubit>().updateSubscribtionPage(
                    index,
                  );
                },
              );
            }
            if (state is SubscribtionFailure) {
              return CustomFailureWidget(meesage: state.errMessage);
            }

            if (state is SubscribtionLoading) {
              return Skeletonizer(
                enabled: true,
                child: CarouselSliderWidget(
                  instance: dummySubscriptions[_currentPage],
                  onPageChanged: (index, _) {
                    context.read<SubscribtionCubit>().updateSubscribtionPage(
                      index,
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        const Gap(30),
        BlocBuilder<SubscribtionCubit, SubscribtionState>(
          buildWhen: (previous, current) => current is UpdateSubscribtionPage,
          builder: (context, state) {
            if (state is UpdateSubscribtionPage) {
              final position = state.index.toDouble();
              return Center(
                child: DotsIndicator(
                  position: position,
                  dotsCount: 4,
                  decorator: DotsDecorator(
                    size: const Size(14, 14),
                    activeSize: const Size(14, 14),
                    activeColor: position % 2 == 0
                        ? AppColors.primary
                        : AppColors.secondary,
                    color: AppColors.deepGrey,
                  ),
                ),
              );
            }
            return Center(
              child: DotsIndicator(
                position: 0.0,
                dotsCount: 4,
                decorator: const DotsDecorator(
                  activeSize: Size(14, 14),
                  size: Size(14, 14),
                  activeColor: AppColors.primary,
                  color: AppColors.deepGrey,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
