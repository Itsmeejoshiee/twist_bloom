import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'edit_bio.dart';
import 'edit_name.dart';
import 'edit_phone_num.dart';
import 'address_page.dart';

void _showBirthdayPicker(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light(),
        child: child!,
      );
    },
  );
}

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Account Info',
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
          child: Column(
            children: [
              const SizedBox(height: 30),
              // First box with 4 buttons
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
                  children: [
                    _buildInfoButton(context, 'Name', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditNamePage()));
                    }),
                    _buildInfoButton(context, 'Bio', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditBioPage()));
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
                margin: const EdgeInsets.only(top: 12, left: 32, right: 32, bottom: 12),
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
                  children: [
                    _buildInfoButton(context, 'Phone', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditPhonePage()));
                    }),
                    _buildInfoButton(context, 'Address', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddressPage()));
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
            Text(text, style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins')),
            const Icon(Icons.arrow_forward_ios, color: Colors.black),
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
            title: const Center(child: Text('Gender')),
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
                      child: const Text('Male', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
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
                      child: const Text('Female', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
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
                      child: const Text('Others', style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                    )),
              ],
            ),
          );
        }
    );
  }
}
