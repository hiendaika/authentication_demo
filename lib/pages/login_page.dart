import 'package:authentication_demo/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              //Logo
              Icon(Icons.lock, size: 100, color: Colors.grey[900]),
              const SizedBox(height: 50),
              // Welcome back, you've been missed
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(height: 25),
              //user textfield
              MyTextfield(
                controller: userController,
                hintText: 'User name',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              //password textfield
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              //forgot password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
                ],
              ),

              //sign in button
              const SizedBox(height: 25),
              // or continue with

              //google button + apple button

              //not a member? register now
            ],
          ),
        ),
      ),
    );
  }
}
