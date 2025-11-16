import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../controller/get_services_cubit/get_services_cubit.dart';

class CheckNoxServiceBlocBuilder extends StatelessWidget {
  const CheckNoxServiceBlocBuilder({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServicesCubit, GetServicesState>(
      buildWhen: (previous, current) =>
          current is SelectedService ||
          current is GetServicesSuccess ||
          current is GetServicesLoading,
      builder: (context, state) {
        if (state is SelectedService) {
          final isActive = (state).isSelected && state.serviceId == id;
          return SizedBox(
            height: 32,
            width: 32,
            child: Checkbox(
              value: isActive,
              onChanged: (val) {
                context.read<GetServicesCubit>().selectService(
                  id,
                  val!,
                );
              },
              shape: const CircleBorder(
                side: BorderSide(color: Color(0xffA89D9D)),
              ),

              side: const BorderSide(color: Color(0xffA89D9D)),
              fillColor: WidgetStateColor.resolveWith(
                (states) =>
                    isActive ? AppColors.primary : const Color(0xffFDF4F4),
              ),
            ),
          );
        }
        return SizedBox(
          height: 32,
          width: 32,
          child: IgnorePointer(
            ignoring: state is GetServicesLoading,
            child: Checkbox(
              value: false,
              onChanged: (val) {
                context.read<GetServicesCubit>().selectService(
                  id,
                  val!,
                );
              },
              shape: const CircleBorder(
                side: BorderSide(color: Color(0xffA89D9D)),
              ),

              side: const BorderSide(color: Color(0xffA89D9D)),
              fillColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffFDF4F4),
              ),
            ),
          ),
        );
      },
    );
  }
}
