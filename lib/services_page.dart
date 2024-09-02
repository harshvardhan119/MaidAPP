
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCardPage extends StatefulWidget {
  @override
  _FirestoreCardPageState createState() => _FirestoreCardPageState();
}

class _FirestoreCardPageState extends State<FirestoreCardPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  Stream<QuerySnapshot> _fetchData() {
    if (_searchQuery.isEmpty) {
      return FirebaseFirestore.instance.collection('maids').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('maids')
          .where('location', isGreaterThanOrEqualTo: _searchQuery)
          .where('location', isLessThanOrEqualTo: '$_searchQuery\uf8ff')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent, // Set AppBar background color to cyan accent
        title: Text('Registered Maid', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Larger heading
        centerTitle: true, // Center the title
      ),
      body: Container(
        color: Colors.grey[200], // Set body background color to grey
        child: Column(
          children: [
            // Heading and search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 10),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by location...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Set the border radius here
                        borderSide: BorderSide(color: Colors.black, width: 2.0), // Customize border color and width on focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Set the border radius here
                        borderSide: BorderSide(color: Colors.grey, width: 2.0), // Customize border color and width when not focused
                      ),
                      filled: true,
                      fillColor: Colors.white, // Background color of the search bar
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  )

                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No data available.'));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;

                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 0.5), // Card border stroke
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          title: Text(data['name'] ?? 'No Name'),
                          subtitle: Text(
                            'Age: ${data['age'] ?? 'N/A'}\n'
                                'Location: ${data['location'] ?? 'N/A'}\n'
                                'Gender: ${data['gender'] ?? 'N/A'}\n'
                                'Food Preference: ${data['foodPreference'] ?? 'N/A'}\n'
                                'Caste: ${data['caste'] ?? 'N/A'}',
                          ),
                          trailing: CircleAvatar(
                            radius: 30,
                            backgroundImage: data['photoUrl'] != null
                                ? NetworkImage(data['photoUrl'])
                                : AssetImage('assets/placeholder.png') as ImageProvider,
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
