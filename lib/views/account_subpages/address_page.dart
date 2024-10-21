import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'add_edit_address.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../user_session.dart';

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
  void initState() {
    super.initState();
    // Fetch the address when the page loads
    fetchAddressFromFirebase();
  }

  Future<void> fetchAddressFromFirebase() async {
    // Get the userId from UserSession
    String? userId = UserSession().getUserId();

    if (userId != null) {
      // Reference to the user's address in Firebase
      DatabaseReference addressRef = FirebaseDatabase.instance.ref('users/$userId/address');

      // Fetch the address data from Firebase
      DataSnapshot snapshot = await addressRef.get();

      if (snapshot.exists) {
        // Extract the address details from the snapshot
        Map<dynamic, dynamic> addressData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          regionCityDistrict = addressData['region'];
          streetBuilding = addressData['street'];
          unitFloor = addressData['unit'];
        });
      } else {
        // If no address exists, set the values to null
        setState(() {
          regionCityDistrict = null;
          streetBuilding = null;
          unitFloor = null;
        });
      }
    } else {
      // If userId is null, show a message or handle accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
      body: SizedBox.expand( // Ensure the GradientBackground takes the full height of the screen
        child: GradientBackground(
          child: Center( // Centers the entire content
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Centers content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
                children: [
                  if (regionCityDistrict != null) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
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
                                // Get userId from UserSession
                                String? userId = UserSession().getUserId();
                                if (userId != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddEditAddressPage(
                                        userId: userId, // Pass userId to AddEditAddressPage
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
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('User ID not found')),
                                  );
                                }
                              },
                              child: const Text('Edit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    const Text('No address found'),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Get userId from UserSession for adding a new address
                      String? userId = UserSession().getUserId();
                      if (userId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditAddressPage(
                              userId: userId, // Pass userId to AddEditAddressPage
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User ID not found')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: const Color.fromRGBO(255, 182, 193, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('Add Address'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
