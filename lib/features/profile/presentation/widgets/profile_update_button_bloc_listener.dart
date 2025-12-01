import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/model/profile_request._model.dart';

class ProfileUpdateButtonBlocListener extends StatelessWidget {
  const ProfileUpdateButtonBlocListener({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UploadProfileDataLoading) {
          AppDilagos.showLoadingBox(context);
        }

        if (state is UploadProfileDataSuccess) {
          AppNavigation.pop(context, useAppRoute: true);
          AppDilagos.showToast(text: 'Profile updated successfully');
        }

        if (state is UploadProfileDataError) {
          AppNavigation.pop(context, useAppRoute: true);
          AppDilagos.showErrorMessage(
            context,
            errMessage: state.errMessage,
          );
        }
      },
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: DefaultAppButton(
          text: LocaleKeys.update.tr(),
          onPressed: () {
            var userId = context.read<AuthCubit>().getCurrentUser()!.uid;
            var profile = ProfileRequestModel(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneController.text.trim(),
              image: (context.read<ProfileCubit>().state is PickImageSuccess)
                  ? (File(
                      (context.read<ProfileCubit>().state as PickImageSuccess)
                          .image
                          .path,
                    ))
                  : null,
              userId: userId,
            );
            context.read<ProfileCubit>().uploadProfileData(profile);
          },
        ),
      ),
    );
  }
}
