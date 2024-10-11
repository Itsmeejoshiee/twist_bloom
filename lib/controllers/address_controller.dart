import 'package:flutter/material.dart';
import '../models/address_model.dart';

class AddressController {
  final List<AddressModel> _addresses = [];

  final TextEditingController regionCityDistrictController = TextEditingController();
  final TextEditingController streetBuildingController = TextEditingController();
  final TextEditingController unitFloorController = TextEditingController();

  void initializeControllers({
    String? initialRegionCityDistrict,
    String? initialStreetBuilding,
    String? initialUnitFloor,
    bool isEdit = false,
  }) {
    regionCityDistrictController.text = initialRegionCityDistrict ?? '';
    streetBuildingController.text = initialStreetBuilding ?? '';
    unitFloorController.text = initialUnitFloor ?? '';
  }

  void disposeControllers() {
    regionCityDistrictController.dispose();
    streetBuildingController.dispose();
    unitFloorController.dispose();
  }

  List<AddressModel> get addresses => _addresses;

  void saveAddress(Function(String, String, String) onSave) {
    final newAddress = AddressModel(
      regionCityDistrict: regionCityDistrictController.text,
      streetBuilding: streetBuildingController.text,
      unitFloor: unitFloorController.text,
    );
    _addresses.add(newAddress);
    onSave(
      regionCityDistrictController.text,
      streetBuildingController.text,
      unitFloorController.text,
    );
  }

  void editAddress(int index, AddressModel updatedAddress) {
    _addresses[index] = updatedAddress;
  }

  void deleteAddress(int index) {
    _addresses.removeAt(index);
  }
}
