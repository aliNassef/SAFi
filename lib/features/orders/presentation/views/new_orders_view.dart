import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/utils/utils.dart';
import 'package:safi/features/orders/presentation/controller/order_cubit/order_cubit.dart';
import '../../../home/data/model/price_args_model.dart';
import '../widgets/new_order_view_body.dart';

class NewOrdersView extends StatelessWidget {
  const NewOrdersView({super.key, required this.priceArgs});
  static const routeName = 'OrdersView';
  final PriceArgsModel priceArgs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.order_now.tr(),
          style: context.appTheme.medium20.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => injector<OrderCubit>(),
          child: SingleChildScrollView(
            child:
                NewOrderViewBody(
                  instance: priceArgs,
                ).withHorizontalPadding(
                  AppConstants.kHorizontalPadding,
                ),
          ),
        ),
      ),
    );
  }
}
