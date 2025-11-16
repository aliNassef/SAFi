import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;
  final String desc;

  const OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.desc,
  });

  static const data = [
    OnBoardingModel(
      image: AppAssets.on_boarding1,
      title: LocaleKeys.onboarding_quote_1,
      subTitle: LocaleKeys.onboarding_title_1,
      desc: LocaleKeys.onboarding_subtitle_1,
    ),
    OnBoardingModel(
      image: AppAssets.on_boarding2,
      title: LocaleKeys.onboarding_quote_2,
      subTitle: LocaleKeys.onboarding_title_2,
      desc: LocaleKeys.onboarding_subtitle_2,
    ),
    OnBoardingModel(
      image: AppAssets.on_boarding3,
      title: LocaleKeys.onboarding_quote_3,
      subTitle: LocaleKeys.onboarding_title_3,
      desc: LocaleKeys.onboarding_subtitle_3,
    ),
  ];
}
