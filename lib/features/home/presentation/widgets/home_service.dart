import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/model/service_model.dart';
import 'check_box_service_bloc_builder.dart';

class HomeService extends StatelessWidget {
  const HomeService({
    super.key,
    required this.serviceModel,
    required this.onExpansionChanged,
    required this.onTap,
  });
  final ServiceModel serviceModel;
  final void Function()? onTap;
  final void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: onExpansionChanged,
          title: Row(
            children: [
              CheckBoxServiceBlocBuilder(id: serviceModel.id),
              Text(
                serviceModel.name,
                style: context.appTheme.medium20.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  serviceModel.desc,
                  style: context.appTheme.medium24.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ).withHorizontalPadding(16),
            const Gap(5),
            CustomNetworkImage(
              img: serviceModel.img,
              height: 200,
              width: context.width * 0.9,
              radius: 12,
            ),
            const Gap(10),

            DefaultAppButton(
              onPressed: onTap,
              text: LocaleKeys.select_wanted.tr(),
              padding: context.width * 0.05,
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
