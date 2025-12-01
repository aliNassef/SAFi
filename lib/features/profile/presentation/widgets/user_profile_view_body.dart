import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/utils/app_bottom_sheet.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';
import 'profile_update_button_bloc_listener.dart';

class UserProfileViewBody extends StatefulWidget {
  const UserProfileViewBody({
    super.key,
  });

  @override
  State<UserProfileViewBody> createState() => _UserProfileViewBodyState();
}

class _UserProfileViewBodyState extends State<UserProfileViewBody> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  File? image;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: context.read<ProfileCubit>().state is UploadProfileDataSuccess
          ? (context.read<ProfileCubit>().state as UploadProfileDataSuccess)
                .profile
                .name
          : null,
    );
    emailController = TextEditingController(
      text: context.read<ProfileCubit>().state is UploadProfileDataSuccess
          ? (context.read<ProfileCubit>().state as UploadProfileDataSuccess)
                .profile
                .email
          : null,
    );
    phoneController = TextEditingController(
      text: context.read<AuthCubit>().getCurrentUser()!.phoneNumber,
    );
    image = context.read<ProfileCubit>().state is UploadProfileDataSuccess
        ? (context.read<ProfileCubit>().state as UploadProfileDataSuccess)
              .profile
              .image
        : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(50),
        Align(
          alignment: Alignment.center,
          child: BlocConsumer<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) => current is PickImageSuccess,
            listener: (context, state) {
              if (state is PickImageSuccess) {
                image = File(state.image.path);
              }
            },
            builder: (context, state) {
              var circleAvatar = CircleAvatar(
                radius: 60,
                backgroundImage:
                    state is UploadProfileDataSuccess &&
                        state.profile.image != null
                    ? FileImage(state.profile.image!)
                    : image != null
                    ? FileImage(image!)
                    : null,
                backgroundColor: Colors.grey.shade300,
                child:
                    state is UploadProfileDataSuccess &&
                        state.profile.image != null
                    ? null
                    : image != null
                    ? null
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.white,
                      ),
              );
              return GestureDetector(
                onTap: () async {
                  final cubit = context.read<ProfileCubit>();
                  final source = await AppBottomSheet.showImageSourceDialog(
                    context,
                  );

                  if (source != null) {
                    cubit.pickImage(source);
                  }
                },
                child: circleAvatar,
              );
            },
          ),
        ),
        const Gap(30),
        Text(
          LocaleKeys.name.tr(),
          style: context.appTheme.medium16,
        ),
        const Gap(5),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: CustomTextFormField(
            hintText: LocaleKeys.name.tr(),
            controller: nameController,
          ),
        ),
        const Gap(20),
        Text(
          LocaleKeys.email.tr(),
          style: context.appTheme.medium16,
        ),
        const Gap(5),
        FadeInUp(
          duration: const Duration(milliseconds: 600),
          child: CustomTextFormField(
            hintText: LocaleKeys.email.tr(),
            controller: emailController,
          ),
        ),
        const Gap(20),
        Text(
          LocaleKeys.phone.tr(),
          style: context.appTheme.medium16,
        ),
        const Gap(5),
        FadeInUp(
          duration: const Duration(milliseconds: 700),
          child: CustomTextFormField(
            hintText: LocaleKeys.phone.tr(),
            controller: phoneController,
          ),
        ),
        const Gap(30),
        ProfileUpdateButtonBlocListener(
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
        ),
      ],
    );
  }
}
