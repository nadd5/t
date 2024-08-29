import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/home/auth/custom_text_form_field.dart';
import 'package:todoappp/home/auth/register/register_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const String routeName = 'Login_screen';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomTextFormField(
                        label: 'Email',
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Email";
                          }
                          final bool emailValid = RegExp(
                                  r"[a-zA-Z0-9.a-zA-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextFormField(
                        label: 'Password',
                        controller: passController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Password";
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ))),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Text('create account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: appcolor.primarycolor,
                                          fontSize: 22)))),
                    ],
                  )),
            ],
          ),
        ));
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text);
                print('successfully Logged in');
        print(credential.user?.uid ?? "");
      } 
      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('Supplied auth credential is incorrect,malformed or has expired');
        } /*else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }*/
      } 
      catch (e) {
        print(e.toString());
      }
    }
  }
}
