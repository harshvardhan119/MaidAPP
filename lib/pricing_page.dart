// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class MaidRegistrationPage extends StatefulWidget {
//   @override
//   _MaidRegistrationPageState createState() => _MaidRegistrationPageState();
// }
//
// class _MaidRegistrationPageState extends State<MaidRegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _genderController = TextEditingController();
//   final _foodPreferenceController = TextEditingController();
//   final _casteController = TextEditingController();
//
//   final List<String> _genders = ['Male', 'Female', 'Other'];
//   final List<String> _foodPreferences = ['Vegetarian', 'Non-Vegetarian'];
//   final List<String> _castes = ['Hindu', 'Muslim', 'Sikh', 'Christian'];
//
//   String? _selectedGender;
//   String? _selectedFoodPreference;
//   String? _selectedCaste;
//
//   bool _isRegistered = false;
//
//   void _registerMaid() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         // Handle the case where the user is not authenticated
//         return;
//       }
//       try {
//         await FirebaseFirestore.instance.collection('maids').doc(user.uid).set({
//           'name': _nameController.text.trim(),
//           'gender': _selectedGender,
//           'foodPreference': _selectedFoodPreference,
//           'age': int.tryParse(_ageController.text.trim()) ?? 0,
//           'location': _locationController.text.trim(),
//           'caste': _selectedCaste,
//         });
//
//         // Show a success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Successfully registered!')),
//         );
//
//         // Disable form fields
//         setState(() {
//           _isRegistered = true;
//         });
//       } catch (e) {
//         print('Failed to register maid: $e');
//         // Handle error appropriately
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Maid Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 enabled: !_isRegistered,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _ageController,
//                 decoration: InputDecoration(labelText: 'Age'),
//                 keyboardType: TextInputType.number,
//                 enabled: !_isRegistered,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your age';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _locationController,
//                 decoration: InputDecoration(labelText: 'Location'),
//                 enabled: !_isRegistered,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your location';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 hint: Text('Select Gender'),
//                 items: _genders.map((gender) {
//                   return DropdownMenuItem<String>(
//                     value: gender,
//                     child: Text(gender),
//                   );
//                 }).toList(),
//                 onChanged: !_isRegistered ? (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 } : null,
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select your gender';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedFoodPreference,
//                 hint: Text('Select Food Preference'),
//                 items: _foodPreferences.map((preference) {
//                   return DropdownMenuItem<String>(
//                     value: preference,
//                     child: Text(preference),
//                   );
//                 }).toList(),
//                 onChanged: !_isRegistered ? (value) {
//                   setState(() {
//                     _selectedFoodPreference = value;
//                   });
//                 } : null,
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select your food preference';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedCaste,
//                 hint: Text('Select Caste'),
//                 items: _castes.map((caste) {
//                   return DropdownMenuItem<String>(
//                     value: caste,
//                     child: Text(caste),
//                   );
//                 }).toList(),
//                 onChanged: !_isRegistered ? (value) {
//                   setState(() {
//                     _selectedCaste = value;
//                   });
//                 } : null,
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select your caste';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isRegistered ? null : _registerMaid,
//                 child: Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class MaidRegistrationPage extends StatefulWidget {
  @override
  _MaidRegistrationPageState createState() => _MaidRegistrationPageState();
}

class _MaidRegistrationPageState extends State<MaidRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _foodPreferences = ['Vegetarian', 'Non-Vegetarian'];
  final List<String> _castes = ['Hindu', 'Muslim', 'Sikh', 'Christian'];

  String? _selectedGender;
  String? _selectedFoodPreference;
  String? _selectedCaste;

  bool _isRegistered = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await FirebaseFirestore.instance.collection('maids').doc(user.uid).get();
        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          if (data != null) {
            setState(() {
              _isRegistered = data['isRegistered'] ?? false;
              _nameController.text = data['name'] ?? '';
              _ageController.text = data['age']?.toString() ?? '';
              _locationController.text = data['location'] ?? '';
              _phoneController.text = data['phone'] ?? '';
              _selectedGender = data['gender'];
              _selectedFoodPreference = data['foodPreference'];
              _selectedCaste = data['caste'];
              _photoUrl = data['photoUrl'];
              _imageFile = _photoUrl != null ? File(_photoUrl!) : null;
            });
          }
        }
      } catch (e) {
        print('Failed to check registration status: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load registration status')),
        );
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('maid_photos').child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerMaid() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User is not authenticated')),
        );
        return;
      }

      String? imageUrl;

      if (_imageFile != null) {
        imageUrl = await uploadImage(_imageFile!);
      }

      try {
        await FirebaseFirestore.instance.collection('maids').doc(user.uid).set({
          'name': _nameController.text.trim(),
          'gender': _selectedGender,
          'foodPreference': _selectedFoodPreference,
          'age': int.tryParse(_ageController.text.trim()) ?? 0,
          'location': _locationController.text.trim(),
          'caste': _selectedCaste,
          'phone': _phoneController.text.trim(),
          'photoUrl': imageUrl,
          'isRegistered': true,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully registered!')),
        );

        setState(() {
          _isRegistered = true;
          _photoUrl = imageUrl;
        });
      } catch (e) {
        print('Failed to register maid: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register maid')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFFD9D9D9).withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.withOpacity(0.4),
        // backgroundColor: Color(0xFFD9D9D9).withOpacity(0.4),
        centerTitle: true,
        title: Text(
          'Maid Registration',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Form(

          key: _formKey,
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                // Profile Photo Upload Section
                if (!_isRegistered) ...[
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        )
                            : null,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Photo',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Please upload a profile photo for identification.',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
                if (_isRegistered && _photoUrl != null) ...[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFEDEDED),
                    backgroundImage: NetworkImage(_photoUrl!),
                  ),
                  SizedBox(height: 20),
                ],
                // Form Fields
                _buildTextField(_nameController, 'Name'),
                SizedBox(height: 10),
                _buildTextField(_ageController, 'Age', keyboardType: TextInputType.number),
                SizedBox(height: 10),
                _buildTextField(_locationController, 'Location'),
                SizedBox(height: 10),
                _buildTextField(_phoneController, 'Phone Number', keyboardType: TextInputType.phone),
                SizedBox(height: 10),
                _buildDropdownField('Select Gender', _genders, _selectedGender, (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdownField('Select Food Preference', _foodPreferences, _selectedFoodPreference, (value) {
                  setState(() {
                    _selectedFoodPreference = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdownField('Select Caste', _castes, _selectedCaste, (value) {
                  setState(() {
                    _selectedCaste = value;
                  });
                }),
                SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: _isRegistered ? null : _registerMaid,
                  child: Text(_isRegistered ? 'Already Registered' : 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Color(0xFFEDEDED),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      enabled: !_isRegistered,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String hint, List<String> items, String? value, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: !_isRegistered ? onChanged : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDEDED),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select your $hint';
        }
        return null;
      },
    );
  }
}


