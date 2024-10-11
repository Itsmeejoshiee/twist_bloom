import 'package:flutter/material.dart';

class AddressController {
  final TextEditingController regionCityDistrictController = TextEditingController();
  final TextEditingController streetBuildingController = TextEditingController();
  final TextEditingController unitFloorController = TextEditingController();

  void initializeControllers({String? initialRegionCityDistrict, String? initialStreetBuilding, String? initialUnitFloor, bool isEdit = false}) {
    if (isEdit) {
      regionCityDistrictController.text = initialRegionCityDistrict ?? '';
      streetBuildingController.text = initialStreetBuilding ?? '';
      unitFloorController.text = initialUnitFloor ?? '';
    }
  }

  void disposeControllers() {
    regionCityDistrictController.dispose();
    streetBuildingController.dispose();
    unitFloorController.dispose();
  }

  void saveAddress(Function(String, String, String) onSave) {
    onSave(
      regionCityDistrictController.text,
      streetBuildingController.text,
      unitFloorController.text,
    );
  }
}
