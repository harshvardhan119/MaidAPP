//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'registration_page.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   void _login() async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       if (userCredential.user != null) {
//         Navigator.of(context).pushReplacementNamed('/main');
//       }
//     } catch (e) {
//       print('Failed to sign in with email and password: $e');
//       // Handle error appropriately
//     }
//   }
//
//   void _navigateToRegistration() {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => RegistrationPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Add the background color to the entire page
//       body: Container(
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
//
//                 SizedBox(height: 20),
//
//                 // Centered Login Text
//                 Text(
//                   'Login',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black, // Adjust text color to contrast with background
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Email Input Field
//             SizedBox(
//               width: 300,
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     labelStyle: TextStyle(color: Colors.black), // Label text color
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),),
//                 SizedBox(height: 20),
//
//                 // Password Input Field
//             SizedBox(
//               width: 300,
//                 child: TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.black), // Label text color
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   obscureText: true,
//                 ),),
//                 SizedBox(height: 20),
//
//                 // Login Button
//                 ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue, // Button color
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Login',
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Navigate to Registration
//                 TextButton(
//                   onPressed: _navigateToRegistration,
//                   child: Text(
//                     'Don\'t have an account? Register here.',
//                     style: TextStyle(color: Colors.black87),
//                   ),
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
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() async {
    setState(() {
      _errorMessage = ''; // Reset error message before login attempt
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() {
          _errorMessage = 'Password is incorrect. Please try again.';
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = 'No user found with this email.';
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to sign in: ${e.message}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    }
  }

  void _navigateToRegistration() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/maid_service_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
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
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20),

                // Display error message if any
                if (_errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _navigateToRegistration,
                  child: Text(
                    'Don\'t have an account? Register here.',
                    style: TextStyle(color: Colors.black87),
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
