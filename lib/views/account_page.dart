// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'landing_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountPage(),
  ));
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, 1),
          end: Alignment(0.4, -1),
          colors: [
            Color.fromRGBO(224, 209, 158, 0.14),
            Color.fromRGBO(255, 252, 237, 1.0)
          ],
        ),
      ),
      child: child,
    );
  }
}

class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Account'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GradientBackground(
          child: Center(
              child: Column(
                  children: [ // First box
                    Container(
                      margin: EdgeInsets.only(
                          top: 100, left: 32, right: 32, bottom: 12),
                      padding: EdgeInsets.all(32),
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
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'assets/profile_picture.png'),
                            // Profile Picture
                            child: RawMaterialButton(
                                onPressed: () {
                                  _showPhotoOptions(context);
                                },
                                shape: CircleBorder(),
                                child: Icon(Icons.camera_alt_outlined)
                            ),
                          ),
                          SizedBox(height: 5, width: 318),
                          Text(
                            'John Doe',
                            style: TextStyle(fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),

                    Container( // Second box
                      margin: EdgeInsets.only(
                          top: 12, left: 32, right: 32, bottom: 12),
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
                        children: <Widget>[
                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.person, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                                    );
                                  },
                                  label: const Text('Personal Information',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),

                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(
                                      Icons.security, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LoginAndSecurity()),
                                    );
                                  },
                                  label: const Text('Login and Security',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),
                        ],
                      ),
                    ),

                    Container( // Third box
                      margin: EdgeInsets.only(
                          top: 12, left: 32, right: 32, bottom: 12),
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
                        children: <Widget>[
                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {},
                                  label: const Text('Delete Account',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),

                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.logout, color: Colors.black),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()),
                                    );
                                  },
                                  label: const Text('Log Out',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),
                        ],
                      ),
                    ),
                  ]
              )
          ),
        )
    );
  }

  void _showPhotoOptions(BuildContext context) {
    // Profile Picture Editing
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take new photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose existing photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Account Info'),
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
          child: Column(
            children: [
              // First box with 4 buttons
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
                  children: [
                    _buildInfoButton(context, 'Name', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditNamePage()));
                    }),
                    _buildInfoButton(context, 'Bio', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditBioPage()));
                    }),
                    _buildInfoButton(context, 'Gender', () {
                      _showGenderSelect(context);
                    }),
                    _buildInfoButton(context, 'Birthday', () {
                      _showBirthdayPicker(context);
                    }),
                  ],
                ),
              ),

              // Second box with 3 buttons
              Container(
                margin: EdgeInsets.only(top: 12, left: 32, right: 32, bottom: 12),
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
                  children: [
                    _buildInfoButton(context, 'Phone', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPhonePage()));
                    }),
                    _buildInfoButton(context, 'Address', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddressPage()));
                    }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins')),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }

  void _showGenderSelect(BuildContext context) { // Gender pop up
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Gender')),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          alignment: Alignment.centerLeft
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Male', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    )),

                SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          alignment: Alignment.centerLeft
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Female', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    )),

                SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          alignment: Alignment.centerLeft
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Others', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    )),
              ],
            ),
          );
        }
    );
  }
}

void _showBirthdayPicker(BuildContext context) async { // Birthday pop up
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light(), // You can change to ThemeData.dark() for a dark mode picker
        child: child!,
      );
    },
  );
}

// Name Edit Page
class EditNamePage extends StatefulWidget {

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Name'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.black)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none, hintText: "John Doe"),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bio Edit Page
class EditBioPage extends StatefulWidget {

  @override
  _EditBioPageState createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Bio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.black)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(border: InputBorder.none, hintText: "Set bio here"),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Phone Edit Page
class EditPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Phone Number'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save phone number functionality here
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Phone Number'),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  final _regionCityDistrictController = TextEditingController();
  final _streetBuildingController = TextEditingController();
  final _unitFloorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _regionCityDistrictController.text = widget.initialRegionCityDistrict ?? '';
      _streetBuildingController.text = widget.initialStreetBuilding ?? '';
      _unitFloorController.text = widget.initialUnitFloor ?? '';
    }
  }

  @override
  void dispose() {
    _regionCityDistrictController.dispose();
    _streetBuildingController.dispose();
    _unitFloorController.dispose();
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
              _buildTextField('Region/City/District', _regionCityDistrictController),
              SizedBox(height: 16),
              _buildTextField('Street/Building name', _streetBuildingController),
              SizedBox(height: 16),
              _buildTextField('Unit/Floor', _unitFloorController),
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
                  widget.onSave(
                    _regionCityDistrictController.text,
                    _streetBuildingController.text,
                    _unitFloorController.text,
                  );
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

//Login And Security Account option
class LoginAndSecurity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Account Info'),
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
          child: Column(
            children: [
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
                  children: [
                    _buildInfoButton(context, 'Email', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditEmailPage()));
                    }),
                    _buildInfoButton(context, 'Password', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPasswordPage()));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins')),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

// Email Edit Page
class EditEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Email'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save email functionality here
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Email'),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Edit Login password
class EditPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save email functionality here
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Password'),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





