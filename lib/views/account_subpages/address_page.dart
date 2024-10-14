import 'package:flutter/material.dart';
import 'add_edit_address.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? regionCityDistrict;
  String? streetBuilding;
  String? unitFloor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,
          ),
        ),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (regionCityDistrict != null) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Region/City/District: $regionCityDistrict'),
                        Text('Street/Building: $streetBuilding'),
                        Text('Unit/Floor: $unitFloor'),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditAddressPage(
                                    initialRegionCityDistrict: regionCityDistrict,
                                    initialStreetBuilding: streetBuilding,
                                    initialUnitFloor: unitFloor,
                                    isEdit: true,
                                    onSave: (newRegionCityDistrict, newStreetBuilding, newUnitFloor) {
                                      setState(() {
                                        regionCityDistrict = newRegionCityDistrict;
                                        streetBuilding = newStreetBuilding;
                                        unitFloor = newUnitFloor;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditAddressPage(
                          isEdit: false,
                          onSave: (newRegionCityDistrict, newStreetBuilding, newUnitFloor) {
                            setState(() {
                              regionCityDistrict = newRegionCityDistrict;
                              streetBuilding = newStreetBuilding;
                              unitFloor = newUnitFloor;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor: const Color.fromRGBO(255, 182, 193, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ), // Button color
                  ),
                  child: const Text('Add Address'),
                ),
                const SizedBox(height: 20), // Space between button and bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}