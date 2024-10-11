import 'package:flutter/material.dart';
import '../account_page.dart';
import 'add_edit_address.dart';

class AddressPage extends StatefulWidget {
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
        title: Text('Address'),
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (regionCityDistrict != null) ...[
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
                    padding: EdgeInsets.all(16),
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
                            child: Text('Edit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Spacer(),
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
                  child: Text('Add Address'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor: Color.fromRGBO(255, 182, 193, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ), // Button color
                  ),
                ),
                SizedBox(height: 20), // Space between button and bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}