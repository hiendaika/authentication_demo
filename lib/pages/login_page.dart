import 'package:authentication_demo/components/my_button.dart';
import 'package:authentication_demo/components/my_textfield.dart';
import 'package:authentication_demo/components/square_tile.dart';
import 'package:authentication_demo/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //wrong email
      if (e.code == 'user-not-found') {
        showErrorMessage(e.message!);
      }
      //wrong password
      else if (e.code == 'wrong-password') {
        showErrorMessage(e.message!);
      }
      Navigator.pop(context);
    }
    //catch error
    catch (e) {
      print(e);
    } finally {
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

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text('Wrong password buddy'),
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
                // Welcome back, you've been missed
                Text(
                  'Welcome back you\'ve been missed!',
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
                const SizedBox(height: 25),

                //sign in button
                MyButton(onTap: () => signUserIn(), text: 'Sign In'),

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
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
