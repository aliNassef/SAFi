import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../data/model/price_args_model.dart';
import '../controller/get_services_cubit/get_services_cubit.dart';
import '../../../orders/presentation/views/new_orders_view.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import 'home_content_section.dart';
import 'services_list_bloc_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: Image.asset(
                  AppAssets.home_banner_image,
                  width: context.width,
                  height: context.height * .3,
                  fit: BoxFit.fill,
                ),
              ),
              const Gap(20),
              const HomeContentSection(),
            ],
          ),
        ),
        const ServicesListBlocBuilder(),
        const SliverGap(30),
        BlocSelector<GetServicesCubit, GetServicesState, PriceArgsModel?>(
          selector: (state) {
            if (state is GetPriciesServiceSuccess) {
              return state.data;
            }
            return null;
          },
          builder: (context, prices) {
            return SliverToBoxAdapter(
              child: DefaultAppButton(
                onPressed: () {
                  if (prices == null) {
                    AppDilagos.showErrorMessage(
                      context,
                      errMessage: LocaleKeys.please_select_service.tr(),
                    );
                    return;
                  }
                  _goToOrderScreen(context, prices);
                },
                text: LocaleKeys.order_now.tr(),
              ).withHorizontalPadding(16),
            );
          },
        ),
        const SliverGap(30),
      ],
    );
  }

  void _goToOrderScreen(BuildContext context, PriceArgsModel pricies) {
    AppNavigation.pushNamed(
      context,
      NewOrdersView.routeName,
      arguments: NavArgs(
        animation: NavAnimation.fade,
        data: pricies,
      ),
    );
  }
}
