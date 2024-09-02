// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Maid Service'),
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset(
//                   'assets/maid_service_logo.png', // Add your logo image here
//                   height: 150,
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Welcome to Our Maid Service',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'We provide top-notch cleaning and cooking services on a monthly basis. Our experienced staff ensures that your home is spotless and meals are prepared with care.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Add navigation to booking page or service details here
//                   },
//                   icon: Icon(Icons.book_online),
//                   label: Text(
//                     'Book a Service',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal, // Set the background color
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Add navigation to service details or contact page here
//                   },
//                   icon: Icon(Icons.info_outline),
//                   label: Text(
//                     'Learn More',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.tealAccent, // Set the background color
//                     foregroundColor: Colors.teal, // Set the text color
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
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
import 'services_page.dart';
import 'contact_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFEFEFEF),
          child: Padding(
            padding: const EdgeInsets.only(right: 0, left: 0, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Custom Header Section (replacing AppBar)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 30.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/maid_service_logo.png', height: 70),
                      IconButton(
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal.withOpacity(0.2),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.person, color: Colors.teal, size: 30),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"Your time is valuable. Let us help you make the most of it."',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => FirestoreCardPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.tealAccent,
                                  foregroundColor: Colors.black,
                                ),
                                child: Text('Search Maid'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Expanded(
                            flex: 1,
                            child: Image.asset(
                              'assets/abcd.png',
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Our Features Section
                Container(
                  padding: const EdgeInsets.only(left: 130),
                  child: Text(
                    'Our Features',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Features Layout
                Column(
                  children: <Widget>[
                    // First row with three features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FeatureIcon(imagePath: 'assets/cleaning.png', label: 'Cleaning'),
                        FeatureIcon(imagePath: 'assets/cooking.png', label: 'Cooking'),
                        FeatureIcon(imagePath: 'assets/laundry-machine.png', label: 'Laundry'),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Second row with two centered features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FeatureIcon(imagePath: 'assets/baby.png', label: 'Child Care'),
                        SizedBox(width: 30), // Space between the two features
                        FeatureIcon(imagePath: 'assets/kitchen.png', label: 'Maintenance'),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Maid Security Verification Section (Vertical)
                Container(
                  padding: const EdgeInsets.only(right: 40, left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF43D385).withOpacity(0.5),
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 1), // Black stroke at the top
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),  // Top left corner
                      topRight: Radius.circular(50), // Top right corner
                      // Bottom corners will have no radius (they remain square)
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Maid Security Verification',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 110),
                        child: Column(
                          children: [
                            VerificationStep(
                              imagePath: 'assets/maid.png',
                              label: 'Maid Registered',
                            ),
                            Icon(Icons.arrow_downward, color: Colors.teal, size: 30),
                            VerificationStep(
                              imagePath: 'assets/authentication.png',
                              label: 'OTP Verified',
                            ),
                            Icon(Icons.arrow_downward, color: Colors.teal, size: 30),
                            VerificationStep(
                              imagePath: 'assets/identity.png',
                              label: 'Personal Verification',
                            ),
                            Icon(Icons.arrow_downward, color: Colors.teal, size: 30),
                            VerificationStep(
                              imagePath: 'assets/police-badge.png',
                              label: 'Police Verification',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),



                // Service Area Section
                Divider(
                  color: Colors.black,        // Color of the divider line
                  thickness: 1,             // Thickness of the line
                  height: 0,               // Height of the divider (distance from the top to the bottom of the line)
                  indent: 50.0,                // Indentation on the start of the line
                  endIndent: 50.0,             // Indentation on the end of the line
                ),
                Container(
                  color: Color(0xFF43D385).withOpacity(0.5),
                  padding: const EdgeInsets.only(top: 10,left: 30,bottom: 30),
                  child: Column(
                    children: [
                      Text(
                        'Service Areas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Container(

                        padding: const EdgeInsets.only(top:20,left: 100,right: 110),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Central image
                            Image.asset(
                              'assets/map.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),],),),
                            Row(
                            children: [Container(
                              padding:const EdgeInsets.only(top:20,left: 30) ,
                            child: Text(
                              'Delhi',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),),
                            Container(
                              padding:const EdgeInsets.only(top: 20,left: 30) ,
                            child:Text(
                              'Ghaziabad',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),),
                            Container(
                              padding:const EdgeInsets.only(top:20,left: 30) ,
                            child:Text(
                              'Noida',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),),],),
                            // Labels around the image

                          ],
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

// Custom Widget for Feature Icon
class FeatureIcon extends StatelessWidget {
  final String imagePath;
  final String label;

  FeatureIcon({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.tealAccent.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(20.0),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Custom Widget for Verification Step (Vertical)
class VerificationStep extends StatelessWidget {
  final String imagePath;
  final String label;

  VerificationStep({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
