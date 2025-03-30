import 'package:authentication_demo/components/my_button.dart';
import 'package:authentication_demo/components/my_textfield.dart';
import 'package:authentication_demo/components/square_tile.dart';
import 'package:authentication_demo/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // try create user
    try {
      //if confirm password is equal to password
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage('Passwords don\'t match');
      }
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
    }
  }

  void showErrorMessage(String errorMessage) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                //Logo
                Icon(Icons.lock, size: 100, color: Colors.grey[900]),
                const SizedBox(height: 25),
                // Let 's create an account for you
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                //user textfield
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
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

                //Confirm password
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(onTap: () => signUserUp(), text: 'Sign Up'),

                const SizedBox(height: 25),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey[400]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                //google button + apple button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Google button
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SquareTile(
                        imagePath: 'lib/images/google.png',
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
                    ),

                    //Apple button
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SquareTile(
                        imagePath: 'lib/images/apple_blue.png',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //not a member? register now
                // Expanded(
                //   child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
