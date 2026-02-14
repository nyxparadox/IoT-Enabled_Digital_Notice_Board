import 'package:flutter/material.dart';
import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/Screens/authScreens/signUpScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Signinscreen> {
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

                          TextField(
                            decoration: InputDecoration(
                              labelText: "email",
                              icon: Icon(Icons.email_outlined),
                            ),
                          ),

                          SizedBox(height: 8),

                          TextField(
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
                            onPressed: () {},
                            child: Text(
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
                            onTap: () {
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
