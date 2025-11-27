import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../controller/address_cubit/address_cubit.dart';
import '../widgets/address_view_body.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});
  static const String routeName = 'address_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => injector<AddressCubit>(),
          child: const AddressViewBody(),
        ),
      ),
    );
  }
}
