import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'services_page.dart';
import 'pricing_page.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maid Service App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home:SplashScreen(),  // Start with the SplashScreen
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainPage(),
        '/services': (context) => FirestoreCardPage(),
        '/pricing': (context) => MaidRegistrationPage(),
        '/about': (context) => TechHelpPage(),
        '/contact': (context) => ProfilePage(),
        '/register': (context) => RegistrationPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before transitioning to the main splash screen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainSplashScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenWithLogo();
  }
}

class SplashScreenWithLogo extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/maid_service_logo.png', // Add your logo image here
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20)
          ],
        ),
      ),)
    ) ;
  }
}

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: Stack(

        children: [
          PageView(
            controller: _pageController,
            physics: _currentPage == 3
                ? NeverScrollableScrollPhysics() // Disable scroll after last page
                : ClampingScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              SplashPage(
                head:'Maid Service',
                imagePath: 'assets/image1.png',
                title: 'Cleaning',
                description: 'Professional and efficient cleaning service.',
              ),
              SplashPage(
                head:'Maid Service',
                imagePath: 'assets/image2.png',
                title: 'Window-washing',
                description: 'Get your windows sparkling clean.',
              ),
              SplashPage(
                head:'Maid Service',
                imagePath: 'assets/image3.png',
                title: 'Rearranging the bedclothes',
                description: 'We make your bed look neat and tidy.',
              ),
              SplashPageWithButton(
                head:'Maid Service',
                imagePath: 'assets/image4.png',
                title: 'Vacuum cleaning',
                description: 'We take care of the dust with our vacuum cleaning.',
                buttonText: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(4, (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 12.0,
                  width: _currentPage == index ? 12.0 : 12.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.teal : Colors.teal[200],
                    borderRadius: BorderRadius.circular(6.0),

                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String head;

  SplashPage({required this.imagePath, required this.title, required this.description, required this.head});

  @override
  Widget build(BuildContext context) { return Scaffold(
    body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)], // Light gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              head,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xFF6791A4)),
              textAlign: TextAlign.center,


            ),
            SizedBox(height: 20),
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              selectionColor: Colors.cyan,
            ),
          ],
        ),
      ),)
    ),);
  }
}

class SplashPageWithButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final String head;

  SplashPageWithButton({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    required this.head,
  });

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

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              head,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xFF6791A4)),
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 20),
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F5D71), // Set the background color here
              ),
              child: Text(buttonText,
                style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ],
        ),
      ),),
    ),);
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FirestoreCardPage(),
    MaidRegistrationPage(),
    TechHelpPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Join',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
