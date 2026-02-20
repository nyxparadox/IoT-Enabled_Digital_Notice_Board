import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/Screens/authScreens/signUpScreen.dart';
import 'package:mobile_app/Screens/homeScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';
import 'package:mobile_app/logic/cubit/auth_state.dart';


class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Signinscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isloading = false;

    // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }




  Future<void> _handelSignIn()async{
      setState(() {
        _isloading=true;
      });
    try{
      
      await getIt<AuthCubit>().signIn(email: _emailController.text, password: _passwordController.text
      );
      
      final authState = getIt<AuthCubit>().state;
      if (authState.status == AuthStatus.authenticated && authState.user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Homescreen()));
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(authState.error ?? 'Login failed'), backgroundColor: Colors.red,),
          );
      }

      setState(() {
        _isloading = false;
      });

    }catch(e){
      log("ERROR: $e");
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );

      setState(() {
        _isloading = false;
      });
    } 
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticeDesk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 57, 81, 94),
      ),

      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(0, 3),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 150),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(50, 60)),
                      color: Colors.white,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/NoticeDesk.png",
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "ABVGIET ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextSpan(
                                  text: "Notice",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: const Color.fromARGB(
                                      255,
                                      6,
                                      51,
                                      129,
                                    ),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextSpan(
                                  text: "Desk",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: const Color.fromARGB(
                                      255,
                                      190,
                                      24,
                                      12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome!',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "SignIn to continue",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 15),

                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "email",
                              icon: Icon(Icons.email_outlined),
                              errorText:
                                _emailController.text.isNotEmpty && !_isValidEmail((_emailController.text.trim())) ? " please enter valid email" : null, 
                            ), onChanged: (value) => setState(() {}),                            
                          ),

                          SizedBox(height: 8),

                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "password",
                              icon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.visibility_outlined),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),

                          SizedBox(height: 40),

                          ElevatedButton(
                            onPressed: _isloading ? null: _handelSignIn,
                            child: _isloading ? Center(child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white),),)
                            : Text(
                              "SignIn",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
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

                          SizedBox(height: 5),

                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          InkWell(
                            onTap: () 
                             {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Signupscreen()));
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 21),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
