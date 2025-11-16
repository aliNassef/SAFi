import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import '../widgets/price_view_body.dart';
import '../widgets/price_view_bottom_sheet.dart';
import '../widgets/pricies_view_appbar.dart';

class PriciesView extends StatefulWidget {
  const PriciesView({super.key, required this.serviceId});
  static const routeName = 'PriciesListView';
  final String serviceId;

  @override
  State<PriciesView> createState() => _PriciesViewState();
}

class _PriciesViewState extends State<PriciesView> {
  @override
  void initState() {
    super.initState();
    context.read<GetPriciesServiceCubit>().getPrices(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: PriciesViewAppBar(),
      ),
      body: PriceViewBody(),
      bottomNavigationBar: PriceViewBottomSheet(),
    );
  }
}
