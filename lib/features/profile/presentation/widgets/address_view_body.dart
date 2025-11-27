import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/utils/app_color.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/env/env.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../controller/address_cubit/address_cubit.dart';
import 'user_address_widget.dart';

class AddressViewBody extends StatelessWidget {
  const AddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is AddressSuccess) {
          final position = state.position;
          return PlacePicker(
            apiKey: Env.mapKey,
            enableNearbyPlaces: false,
            onPlacePicked: (LocationResult result) {
              context.read<AddressCubit>().updateAddress(
                result.formattedAddress!,
              );
            },
            initialLocation: LatLng(position.latitude, position.longitude),
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              autofocus: false,
            ),
            searchInputDecorationConfig: SearchInputDecorationConfig(
              hintText: LocaleKeys.search_for_a_building_street_or.tr(),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(),
            ),
          );
        }
        if (state is AddressFailure) {
          return CustomFailureWidget(meesage: state.errorMessage);
        }
        if (state is AddressLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is GetUserAddress) {
          final address = state.address;
          return UserAddressWidget(
            address: address,
          ).withAllPadding(AppConstants.kHorizontalPadding);
        }
        return const SizedBox.shrink();
      },
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
      ),
    );
  }
}
