import 'package:flutter/material.dart';
import 'package:safi/features/layout/presentation/controller/cubit/nav_controller_cubit.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/utils/utils.dart';

class PackageAppBar extends StatelessWidget {
  const PackageAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      elevation: 3,
      leading: GestureDetector(
        onTap: () => context.read<NavControllerCubit>().controller.jumpToTab(1),
        child: const Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 16,
          ),
        ),
      ),
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: context.appTheme.semiBold16.copyWith(
          color: const Color(0xff3B3838).withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
