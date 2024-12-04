import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // For handling SocketException
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  // SignIn Method
  Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        print("Signed in: ${userCredential.user?.email}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign-in successful!")));

        // Navigate to the home page
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email.";
          break;
        case 'wrong-password':
          message = "Wrong password provided.";
          break;
        case 'invalid-email':
          message = "The email address is invalid.";
          break;
        case 'user-disabled':
          message = "This user account has been disabled.";
          break;
        case 'too-many-requests':
          message = "Too many attempts. Please try again later.";
          break;
        default:
          message = "An error occurred. Try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      print("FirebaseAuthException: $message");
    } on SocketException catch (e) {
      String message = "Network error: Please check your internet connection.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      print("SocketException: $e");
    } catch (e) {
      String message = "An unexpected error occurred.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      print("Unknown error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("images/amongus.jpg", height: 120, width: 120),
            Text(
              "Welcome back!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signIn(); // Call the SignIn method directly
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              child: const Text(
                'Don\'t have an account? Register here',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
