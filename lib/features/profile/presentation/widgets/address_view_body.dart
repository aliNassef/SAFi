import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:safi/core/utils/app_color.dart';
import 'package:safi/env/env.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../core/translations/locale_keys.g.dart';

class AddressViewBody extends StatelessWidget {
  const AddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: Env.mapKey,
      enableNearbyPlaces: false,
      onPlacePicked: (LocationResult result) {
        AppLogger.info("Place picked: ${result.formattedAddress}");
      },
      initialLocation: const LatLng(
        29.378586,
        47.990341,
      ),
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

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primary,
      ),
    );
  }
}
