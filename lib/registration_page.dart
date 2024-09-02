//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }
//
// class _RegistrationPageState extends State<RegistrationPage> {
//   final _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   void _register() async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       if (userCredential.user != null) {
//         Navigator.of(context).pushReplacementNamed('/main');
//       }
//     } catch (e) {
//       print('Failed to register: $e');
//       // Handle error appropriately
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)], // Light gradient colors
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ), // Set your desired background color here
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // Logo at the top center
//                 Container(
//                   height: 200,
//                   width: 200,
//                   child: Image.asset(
//                     'assets/maid_service_logo.png', // Replace with your logo asset
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Text(
//                   'Register',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//             SizedBox(
//               width: 300,// Add some space below the heading
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     labelStyle: TextStyle(color: Colors.black), // Label text color
//                     filled: true,
//                     fillColor: Colors.grey[200], // Light grey background color
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0), // Rounded corners
//                       borderSide: BorderSide.none, // Remove border line
//                     ),
//                   ),
//                 ),),
//                 SizedBox(height: 20),
//               SizedBox(
//               width: 300,
//                 child: TextField(
//
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.grey[200], // Light grey background color
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   obscureText: true,
//                 ),),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//
//                   onPressed: _register,
//                   style: ElevatedButton.styleFrom(
//
//                     backgroundColor: Colors.blueAccent, // Button color
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//
//
//                     child: Text(
//                       'Register',
//                       style: TextStyle(fontSize: 16,color: Colors.white),
//
//                   ),
//
//
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = ''; // Variable to hold the error message

  void _register() async {
    setState(() {
      _errorMessage = ''; // Clear any previous error messages
    });

    if (_passwordController.text.length < 6) {
      setState(() {
        _errorMessage = 'Password should be at least 6 characters long.';
      });
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to register: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true, // Ensures the app bar is transparent and extends behind it
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Removes shadow below the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)], // Light gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo at the top center
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/maid_service_logo.png', // Replace with your logo asset
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 300, // Set the width for the input fields
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 10),
                if (_errorMessage.isNotEmpty) // Show the error message if it's not empty
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center, // Center the error message
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


