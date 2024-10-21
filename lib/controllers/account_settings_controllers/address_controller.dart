import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/address_model.dart';
import '../../user_session.dart';

class AddressController {
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

  Future<void> saveAddress(String userId, Function(String, String, String) onSave) async {
    Map<String, dynamic> addressData = {
      'region': regionCityDistrictController.text,
      'street': streetBuildingController.text,
      'unit': unitFloorController.text,
    };

    await _databaseReference
        .child('users/$userId/address')
        .set(addressData)
        .then((_) {
      onSave(
        regionCityDistrictController.text,
        streetBuildingController.text,
        unitFloorController.text,
      );
    }).catchError((error) {
      print('Failed to save address: $error');
    });
  }

  Future<Map<String, String?>> fetchAddress(String userId) async {
    DatabaseReference addressRef = _databaseReference.child('users/$userId/address');
    DataSnapshot snapshot = await addressRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> addressData = snapshot.value as Map<dynamic, dynamic>;
      return {
        'region': addressData['region'],
        'street': addressData['street'],
        'unit': addressData['unit']
      };
    } else {
      return {
        'region': null,
        'street': null,
        'unit': null
      };
    }
  }

  Future<void> editAddress(String userId, Map<String, String?> updatedAddress) async {
    await _databaseReference.child('users/$userId/address').update(updatedAddress).then((_) {
      print('Address updated successfully!');
    }).catchError((error) {
      print('Failed to update address: $error');
    });
  }

  Future<void> deleteAddress(String userId) async {
    await _databaseReference.child('users/$userId/address').remove().then((_) {
      print('Address deleted successfully!');
    }).catchError((error) {
      print('Failed to delete address: $error');
    });
  }
}
