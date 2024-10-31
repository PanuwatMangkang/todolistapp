import 'package:flutter/material.dart';
import 'package:todolist_app/components/my_button.dart';
import 'package:todolist_app/components/my_textfield.dart';
import 'package:todolist_app/constant/constant.dart';
import 'package:todolist_app/screens/sign_in_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passwordController = TextEditingController();

  void _showDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Colors.amber,
            title: const Text('Sign In'),
            content: Text(txtMsg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('OK')),
            ],
          ),
        );
      },
    );
  }

  void signUp() async {
    //Add data to firebase on this Friday GGEZ
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _showDialog('Create account successfully!');
    } on FirebaseAuthException catch (e) {
      _showDialog('Failed to create an account.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 80, 15, 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to KMUTNB community',
                style: textTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'To get started, please provide create an account.',
                style: textSubTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  controller: nameController,
                  hintText: 'Enter Your Name',
                  obscureText: false,
                  labelText: 'Name'),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: emailController,
                  hintText: 'Enter Your email',
                  obscureText: false,
                  labelText: 'email'),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Enter Your password',
                  obscureText: false,
                  labelText: 'password'),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: re_passwordController,
                  hintText: 'Confirm Your password',
                  obscureText: false,
                  labelText: 're-password'),
              const SizedBox(
                height: 30,
              ),
              MyButton(onTap: signUp, hintText: 'Register now'),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'already a member? go back to',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
