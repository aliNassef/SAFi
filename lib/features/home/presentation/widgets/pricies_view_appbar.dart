import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/price_args_model.dart';
import '../controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
 
class PriciesViewAppBar extends StatelessWidget {
  const PriciesViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          final state =
              context.read<GetPriciesServiceCubit>().state
                  as GetPriciesServiceSuccess;
          var priceArgs = PriceArgsModel(
            serviceId: state.serviceId,
            data: state.data,
            total: state.totalPrice,
          );
          AppNavigation.pop(context, result: priceArgs);
        },
        child: const Padding(
          padding: EdgeInsetsDirectional.only(start: 15),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      leadingWidth: 30,
      centerTitle: true,
      title: Text(
        LocaleKeys.prices.tr(),
        style: context.appTheme.semiBold16.copyWith(
          color: const Color(0xff3B3838).withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
