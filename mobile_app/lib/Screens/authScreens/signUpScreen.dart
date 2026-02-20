import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/Screens/authScreens/emailVerificationScreen.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
// import 'package:mobile_app/Screens/deviceRegistrationScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;

  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String? _validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create your account password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  String? _validateConfirmPasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Password confirmation does not match';
    }
    return null;
  }

  Future<void> _handelSignUP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isloading = true;
    });

    try {
      final authCubit = getIt<AuthCubit>();
      

      await authCubit.signUpDetails(
        name: _nameController.text,
        email: _emailController.text,
        password: _confirmPasswordController.text,
      );
      setState(() {
        _isloading = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailVerificationScreen()));

      

    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticeDesk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 57, 81, 94),
      ),

      body: Center(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),

          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 150),
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.elliptical(50, 60)),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: 30),

                          Text(
                            "Please fill the details to continue",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 19,
                            ),
                          ),

                          SizedBox(height: 25),

                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "name",
                              icon: Icon(Icons.person),
                            ),
                          ),

                          SizedBox(height: 10),

                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'email',
                              icon: Icon(Icons.email_outlined),
                              errorText:
                                  _emailController.text.isNotEmpty &&
                                      !_isValidEmail(
                                        (_emailController.text.trim()),
                                      )
                                  ? "please enter valis email address"
                                  : null,
                            ),
                            onChanged: (value) => setState(() {}),
                          ),

                          SizedBox(height: 10),

                          TextFormField(
                            controller: _passwordController,
                            validator: _validatePasswordField,
                            decoration: InputDecoration(
                              labelText: 'set password',
                              icon: Icon(Icons.lock_outline_rounded),
                            ),
                          ),

                          SizedBox(height: 10),

                          TextFormField(
                            controller: _confirmPasswordController,
                            validator: _validateConfirmPasswordField,
                            decoration: InputDecoration(
                              labelText: 'confirm password',
                              icon: Icon(Icons.check_circle_outline_sharp),
                            ),
                          ),

                          SizedBox(height: 45),

                          ElevatedButton(
                            onPressed: _isloading ? null : _handelSignUP,
                            child: _isloading ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            ) 
                             
                           
                            : Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                50,
                                83,
                                99,
                              ),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "already have an account? "),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signinscreen(),
                                ),
                              );
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "SignIn",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
