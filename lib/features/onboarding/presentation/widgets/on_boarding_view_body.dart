import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/views/login_view.dart';
import '../../data/models/on_boarding_model.dart';
import 'on_boarding_image_box.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({
    super.key,
  });

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController _controller;
  int currentpage = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _controller.addListener(() {
      currentpage = _controller.page?.toInt() ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: OnBoardingModel.data.length,
          itemBuilder: (_, index) => SizedBox(
            height: context.height * 0.55,
            child: Stack(
              children: [
                OnBoardingImageBox(
                  image: OnBoardingModel.data[index].image,
                ),
                Positioned(
                  top: context.height * 0.5,
                  left: 0,
                  right: 0,
                  child: Text(
                    "\"${OnBoardingModel.data[index].title.tr()}\"",
                    style: context.appTheme.bold24.copyWith(
                      color: AppColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: context.height * 0.6,
          left: 16,
          right: 16,
          child: Card(
            elevation: 2,
            shadowColor: AppColors.primary,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  OnBoardingModel.data[currentpage].subTitle.tr(),
                  style: context.appTheme.extraBold24.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  OnBoardingModel.data[currentpage].desc.tr(),
                  style: context.appTheme.regular16.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ).withHorizontalPadding(10).withVerticalPadding(20),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: DefaultAppButton(
            onPressed: () {
              if (currentpage != 2) {
                _controller.animateToPage(
                  duration: const Duration(milliseconds: 300),
                  currentpage + 1,
                  curve: Curves.linear,
                );
              } else {
                _navToLogin();
              }
            },
            text: LocaleKeys.next.tr(),
            padding: context.width * 0.05,
          ),
        ),
      ],
    );
  }

  void _navToLogin() {
    AppNavigation.pushNamed(
      context,
      LoginView.routeName,
      arguments: const NavArgs(
        animation: NavAnimation.fade,
      ),
    );
  }
}
