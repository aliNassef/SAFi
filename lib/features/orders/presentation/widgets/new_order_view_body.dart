import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/enums/payment_method_enum.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';

import '../../data/model/orders_model.dart';
import '../../../../core/widgets/custom_drop_down_menu.dart';
import '../../../home/data/model/price_args_model.dart';
import '../controller/order_cubit/order_cubit.dart';
import 'my_order_card_item.dart';
import 'total_price_card.dart';

class NewOrderViewBody extends StatefulWidget {
  const NewOrderViewBody({super.key, required this.instance});
  final PriceArgsModel instance;

  @override
  State<NewOrderViewBody> createState() => _NewOrderViewBodyState();
}

class _NewOrderViewBodyState extends State<NewOrderViewBody> {
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late TextEditingController _paymentMethod;
  late GlobalKey<FormState> _formkey;
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().getCurrentUser();
    _phoneNumber = TextEditingController(text: user?.phoneNumber);
    _address = TextEditingController();
    _paymentMethod = TextEditingController();
    _formkey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _paymentMethod.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          Text(
            LocaleKeys.address.tr(),
            style: context.appTheme.semiBold20.copyWith(
              color: AppColors.black,
            ),
          ),
          const Gap(8),
          CustomTextFormField(
            hintText: LocaleKeys.address.tr(),
            controller: _address,
          ),
          const Gap(16),
          Text(
            LocaleKeys.payment_options.tr(),
            style: context.appTheme.semiBold20.copyWith(
              color: AppColors.black,
            ),
          ),
          const Gap(8),

          CustomDropDownMenu(
            controller: _paymentMethod,
            hint: LocaleKeys.payment_options.tr(),
            itemns: [
              PaymentMethodEnum.cash.value,
              PaymentMethodEnum.wallet.value,
              PaymentMethodEnum.package.value,
            ],
          ),
          const Gap(16),
          Text(
            LocaleKeys.phone_number.tr(),
            style: context.appTheme.semiBold20.copyWith(
              color: AppColors.black,
            ),
          ),
          const Gap(8),
          CustomTextFormField(
            hintText: LocaleKeys.phone_number.tr(),
            controller: _phoneNumber,
          ),
          const Gap(16),
          Text(
            LocaleKeys.my_orders.tr(),
            style: context.appTheme.semiBold20.copyWith(
              color: AppColors.black,
            ),
          ),
          const Gap(8),
          ...widget.instance.data!.map(
            (order) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MyOrderCardItem(
                order: order,
              ),
            ),
          ),
          const Gap(16),
          TotalPriceCard(instance: widget.instance),
          const Gap(16),
          _orderNowButtonBlocListener(context),
          const Gap(24),
        ],
      ),
    );
  }

  BlocListener<OrderCubit, OrderState> _orderNowButtonBlocListener(
    BuildContext context,
  ) {
    return BlocListener<OrderCubit, OrderState>(
      listenWhen: (previous, current) =>
          current is OrderLoading ||
          current is OrderFailure ||
          current is OrderSuccess,
      listener: (context, state) {
        switch (state) {
          case OrderLoading():
            AppDilagos.showLoadingBox(context);
            break;
          case OrderSuccess():
            AppNavigation.pop(context, useAppRoute: true);
            AppDilagos.showToast(text: 'Order Add Successfully');
            
            break;
          case OrderFailure(:final errMessage):
            AppNavigation.pop(context, useAppRoute: true);
            AppDilagos.showErrorMessage(context, errMessage: errMessage);
            break;
          default:
            break;
        }
      },
      child: DefaultAppButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            var order = OrdersModel(
              phoneNumberId: _phoneNumber.text.trim(),
              serviceId: widget.instance.serviceId,
              orders: widget.instance.data!,
              total: widget.instance.total!.toInt(),
              paymentMethod: _paymentMethod.text,
              address: _address.text.trim(),
            );

            AppLogger.debug(order.toString());
            context.read<OrderCubit>().createOrder(order);
          } else {}
        },
        text: LocaleKeys.send.tr(),
      ),
    );
  }
}
