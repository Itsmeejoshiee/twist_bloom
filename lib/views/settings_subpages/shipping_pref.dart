import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class ShippingPrefPage extends StatefulWidget {
  const ShippingPrefPage({super.key});

  @override
  _ShippingPrefPageState createState() => _ShippingPrefPageState();
}

class _ShippingPrefPageState extends State<ShippingPrefPage> {
  TextEditingController _regionCityDistrictController = TextEditingController();
  TextEditingController _streetBuildingController = TextEditingController();

  late Box<String> _addressBox; // Box to store addresses

  @override
  void initState() {
    super.initState();
    _openBox(); // Open Hive box when the page is initialized
  }

  // Open the Hive box
  Future<void> _openBox() async {
    _addressBox = await Hive.openBox<String>('addressBox');
    _loadSavedAddress(); // Load saved addresses
  }

  // Load the saved address from Hive
  Future<void> _loadSavedAddress() async {
    setState(() {
      _regionCityDistrictController.text = _addressBox.get('regionCityDistrict', defaultValue: '') ?? '';
      _streetBuildingController.text = _addressBox.get('streetBuilding', defaultValue: '') ?? '';
    });
  }

  // Save the address when the user changes it
  Future<void> _saveAddress() async {
    _addressBox.put('regionCityDistrict', _regionCityDistrictController.text);
    _addressBox.put('streetBuilding', _streetBuildingController.text);
  }

  @override
  void dispose() {
    _regionCityDistrictController.dispose();
    _streetBuildingController.dispose();
    _addressBox.close(); // Close the box when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Shipping Address'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      title: Text('Shipping Address'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _regionCityDistrictController,
                        decoration: const InputDecoration(
                          labelText: 'Region/City/District',
                        ),
                        onChanged: (value) {
                          _saveAddress(); // Save address when text changes
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _streetBuildingController,
                        decoration: const InputDecoration(
                          labelText: 'Street/Building Name',
                        ),
                        onChanged: (value) {
                          _saveAddress(); // Save address when text changes
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
