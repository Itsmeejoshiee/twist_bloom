import 'package:flutter/material.dart';
import '/controllers/address_controller.dart';
import '../account_page.dart'; // For the GradientBackground

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Address' : 'Add New Address'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Container(
          margin: EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTextField('Region/City/District', _controller.regionCityDistrictController),
              SizedBox(height: 16),
              _buildTextField('Street/Building name', _controller.streetBuildingController),
              SizedBox(height: 16),
              _buildTextField('Unit/Floor', _controller.unitFloorController),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 182, 193, 1),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  _controller.saveAddress(widget.onSave);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
