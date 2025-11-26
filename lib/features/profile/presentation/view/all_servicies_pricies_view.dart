import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/navigation/app_navigation.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/utils.dart';
import '../controller/profile_cubit/profile_cubit.dart';
import '../widgets/all_servicies_pricies_view_body.dart';

class AllServiciesPriciesView extends StatelessWidget {
  const AllServiciesPriciesView({super.key, required this.cubit});
  static const String routeName = 'all_servicies_pricies_view';
  final ProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        elevation: 3,
        leading: GestureDetector(
          onTap: () => AppNavigation.pop(context),
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
          LocaleKeys.prices.tr(),
          style: context.appTheme.semiBold16.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider.value(
          value: cubit,
          child: const AllServiciesPriciesViewBody(),
        ),
      ),
    );
  }
}
