import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/navigation/app_navigation.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import '../controller/address_cubit/address_cubit.dart';

class UserAddressWidget extends StatelessWidget {
  const UserAddressWidget({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
                const Gap(8),
                Text(
                  LocaleKeys.your_current_address.tr(),
                  style: context.appTheme.bold20.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Gap(16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                address,
                style: context.appTheme.medium20.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ).withAllPadding(AppConstants.kHorizontalPadding),
            ),
            const Gap(32),
            DefaultAppButton(
              text: LocaleKeys.update_address.tr(),
              onPressed: () {
                context.read<AddressCubit>().getAddress();
              },
            ),
          ],
        ),
        Positioned(
          child: GestureDetector(
            onTap: () {
              AppNavigation.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
