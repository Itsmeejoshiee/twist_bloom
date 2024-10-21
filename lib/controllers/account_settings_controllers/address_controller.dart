import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/address_model.dart';
import '../../user_session.dart';

class AddressController {
  final List<AddressModel> _addresses = [];
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

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

  void saveAddress(Function(String, String, String) onSave) async {
    final newAddress = AddressModel(
      regionCityDistrict: regionCityDistrictController.text,
      streetBuilding: streetBuildingController.text,
      unitFloor: unitFloorController.text,
    );

    _addresses.add(newAddress);

    String? userId = UserSession().getUserId();

    if (userId != null) {
      Map<String, dynamic> addressData = {
        'region': newAddress.regionCityDistrict,
        'street': newAddress.streetBuilding,
        'unit': newAddress.unitFloor,
      };

      await _databaseReference.child('users/$userId/address').set(addressData).then((_) {
        print('Address saved successfully!');
      }).catchError((error) {
        print('Failed to save address: $error');
      });
    }

    // Execute the callback function
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
