import 'package:flutter/material.dart';
import 'package:safi/core/widgets/custom_app_bar.dart';

import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_constants.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: const ProfileViewBody().withAllPadding(
            AppConstants.kHorizontalPadding,
          ),
        ),
      ),
    );
  }
}
