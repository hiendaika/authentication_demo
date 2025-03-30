import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Get user info
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(onPressed: () => signUserOut(), icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(
          'Logged in as ${user!.email}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
