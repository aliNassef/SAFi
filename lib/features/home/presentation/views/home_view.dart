import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../controller/get_services_cubit/get_services_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => injector<GetServicesCubit>()..getServices(),
          ),
        ],
        child: const SafeArea(
          child: HomeViewBody(),
        ),
      ),
    );
  }
}
