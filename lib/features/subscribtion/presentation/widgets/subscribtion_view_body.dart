import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../controller/subscribtion_cubit/subscribtion_cubit.dart';
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
  int _currentPage = 0;
  List<SubscribtionModel> _subscribtions = [];

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
        BlocConsumer<SubscribtionCubit, SubscribtionState>(
          listener: (_, state) {
            if (state is SubscribtionLoaded) {
              _subscribtions = state.subscribtions;
            }
            if (state is UpdateSubscribtionPage) {
              _currentPage = state.index;
            }
          },
          buildWhen: (previous, current) =>
              current is SubscribtionFailure ||
              current is SubscribtionLoaded ||
              current is SubscribtionLoading ||
              current is UpdateSubscribtionPage,
          builder: (context, state) {
            if (state is SubscribtionLoaded ||
                state is UpdateSubscribtionPage) {
              return CarouselSliderWidget(
                backgroundColor:
                    ((state is UpdateSubscribtionPage &&
                            state.index % 2 == 0) ||
                        _currentPage == 0)
                    ? AppColors.primary
                    : AppColors.secondary,
                itemCount: _subscribtions.length,
                instance: _subscribtions[_currentPage],
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
                containersColor: Colors.grey.shade300,
                child: CarouselSliderWidget(
                  itemCount: dummySubscriptions.length,
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

            if (state is SubscribtionLoaded ||
                state is UpdateSubscribtionPage) {
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
        ),
        const Gap(30),
      ],
    );
  }
}
