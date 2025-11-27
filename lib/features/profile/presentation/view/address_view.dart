import 'package:flutter/material.dart';

import '../widgets/address_view_body.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});
  static const String routeName = 'address_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AddressViewBody(),
      ),
    );
  }
}
