import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../data/model/price_args_model.dart';
import '../controller/get_services_cubit/get_services_cubit.dart';
import '../../../orders/presentation/views/orders_view.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import 'home_content_section.dart';
import 'services_list_bloc_builder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  PriceArgsModel? pricies;
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
        BlocConsumer<GetServicesCubit, GetServicesState>(
          listenWhen: (previous, current) =>
              current is GetPriciesServiceSuccess,
          buildWhen: (previous, current) => current is! SelectedService,
          listener: (context, state) {
            if (state is GetPriciesServiceSuccess) {
              pricies = state.data;
              AppLogger.info('data of args $pricies');
            }
          },
          builder: (context, state) => SliverToBoxAdapter(
            child: IgnorePointer(
              ignoring: pricies == null,
              child: DefaultAppButton(
                onPressed: () => _goToOrderScreent(context, pricies!),
                text: LocaleKeys.order_now.tr(),
              ).withHorizontalPadding(16),
            ),
          ),
        ),
        const SliverGap(30),
      ],
    );
  }

  void _goToOrderScreent(BuildContext context, PriceArgsModel pricies) {
    AppNavigation.pushNamed(
      context,
      OrdersView.routeName,
      arguments: NavArgs(
        animation: NavAnimation.fade,
        data: pricies,
      ),
    );
  }
}
