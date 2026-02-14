import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
import 'package:mobile_app/Screens/deviceRegistrationScreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
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
                          decoration: InputDecoration(
                            labelText: "name",
                            icon: Icon(Icons.person),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextField(
                          decoration: InputDecoration(
                            labelText: 'email',
                            icon: Icon(Icons.email_outlined),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextField(
                          decoration: InputDecoration(
                            labelText: 'set password',
                            icon: Icon(Icons.lock_outline_rounded),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextField(
                          decoration: InputDecoration(
                            labelText: 'confirm password',
                            icon: Icon(Icons.check_circle_outline_sharp),
                          ),
                        ),

                        SizedBox(height: 45),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Deviceregistrationscreen()));
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 25),
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
    );
  }
}
