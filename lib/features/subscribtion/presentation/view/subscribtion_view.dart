import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_constants.dart';
import '../controller/subscribtion_cubit/subscribtion_cubit.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/subscribtion_view_body.dart';

class SubscribtionView extends StatelessWidget {
  const SubscribtionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),

      body:
          BlocProvider(
            create: (context) =>
                injector<SubscribtionCubit>()..getSubscribtions(),
            child: const SubscribtionViewBody(),
          ).withHorizontalPadding(
            AppConstants.kHorizontalPadding,
          ),
    );
  }
}
