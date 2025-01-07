import 'dart:convert'; // For base64 decoding
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fullName;
  String? userEmail;
  String? imageBase64;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        fullName = snapshot['fullName'];
        userEmail = snapshot['email'];
        imageBase64 = snapshot['imageBase64'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  imageBase64 == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage("images/amongus.jpg"), // Default image if none exists
                          radius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(base64Decode(imageBase64!)),
                          radius: 30,
                        ),
                  SizedBox(height: 10),
                  Text(
                    fullName ?? 'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    userEmail ?? 'No email available',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Covid Tracker'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Emsi Chatbot'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(color: Colors.blue),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // A clean, floating card with a welcome message and user info
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Profile image and username
                      imageBase64 == null
                          ? CircleAvatar(
                              backgroundImage: AssetImage("images/amongus.jpg"), // Default image if none exists
                              radius: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: MemoryImage(base64Decode(imageBase64!)),
                              radius: 50,
                            ),
                      SizedBox(height: 20),
                      Text(
                        "Welcome, ${fullName ?? 'Loading...'}",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Email: ${userEmail ?? 'Loading...'}",
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                      ),
                      SizedBox(height: 30),
                      // Interactive buttons
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/covidTracker');
                        },
                        child: Text("Track Your Covid Status"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/chatbot');
                        },
                        child: Text("Start Chatbot"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
