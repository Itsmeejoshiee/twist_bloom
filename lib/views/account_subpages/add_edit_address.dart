import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../controllers/account_settings_controllers/address_controller.dart';

class AddEditAddressPage extends StatefulWidget {
  final String userId;
  final String? initialRegionCityDistrict;
  final String? initialStreetBuilding;
  final String? initialUnitFloor;
  final bool isEdit;
  final Function(String, String, String) onSave;

  const AddEditAddressPage({
    Key? key,
    required this.userId,
    this.initialRegionCityDistrict,
    this.initialStreetBuilding,
    this.initialUnitFloor,
    required this.isEdit,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditAddressPageState createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  final AddressController _controller = AddressController();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _controller.initializeControllers(
      initialRegionCityDistrict: widget.initialRegionCityDistrict,
      initialStreetBuilding: widget.initialStreetBuilding,
      initialUnitFloor: widget.initialUnitFloor,
      isEdit: widget.isEdit,
    );
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  void _validateAndSave() {
    setState(() {
      _isValid = _controller.regionCityDistrictController.text.isNotEmpty &&
          _controller.streetBuildingController.text.isNotEmpty &&
          _controller.unitFloorController.text.isNotEmpty;
    });

    if (_isValid) {
      widget.onSave(
        _controller.regionCityDistrictController.text,
        _controller.streetBuildingController.text,
        _controller.unitFloorController.text,
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Address' : 'Add New Address',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('Region/City/District', _controller.regionCityDistrictController),
              const SizedBox(height: 16),
              _buildTextField('Street/Building Name', _controller.streetBuildingController),
              const SizedBox(height: 16),
              _buildTextField('Unit/Floor', _controller.unitFloorController),
              const Spacer(),
              ElevatedButton(
                onPressed: _validateAndSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color.fromRGBO(255, 182, 193, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Save'),
              ),
              const SizedBox(height: 20), // Space between button and bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: !_isValid && controller.text.isEmpty ? 'This field is required' : null,
      ),
    );
  }
}
