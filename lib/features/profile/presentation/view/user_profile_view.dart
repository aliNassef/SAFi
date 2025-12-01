import 'package:flutter/material.dart';
import 'package:safi/core/utils/app_constants.dart';

import '../../../../core/extensions/padding_extension.dart';
import '../widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});
  static const String routeName = 'user_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: const UserProfileViewBody().withHorizontalPadding(
            AppConstants.kHorizontalPadding,
          ),
        ),
      ),
    );
  }
}
