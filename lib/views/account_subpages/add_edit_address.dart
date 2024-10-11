import 'package:flutter/material.dart';
import '../../controllers/address_controller.dart';

class AddEditAddressPage extends StatefulWidget {
  final String? initialRegionCityDistrict;
  final String? initialStreetBuilding;
  final String? initialUnitFloor;
  final bool isEdit;
  final Function(String, String, String) onSave;

  const AddEditAddressPage({
    Key? key,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Address' : 'Add New Address'),
      ),
      body: Padding(
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
              onPressed: () {
                widget.onSave(
                  _controller.regionCityDistrictController.text,
                  _controller.streetBuildingController.text,
                  _controller.unitFloorController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
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
      ),
    );
  }
}
