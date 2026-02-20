import 'package:flutter/material.dart';
import 'package:mobile_app/Router/appRouter.dart';
// import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/Screens/aboutUsPage.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';
// import 'package:mobile_app/Services/serviceLocater.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<String> categories = [
    "General",
    "Exam",
    "Academic",
    "Event",
    "Holiday",
    "Emergency",
  ];

  String selectedCategory = "General";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Notice",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              TextSpan(
                text: "Desk",
                style: TextStyle(
                  color: const Color.fromARGB(255, 223, 50, 38),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 57, 81, 94),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color:const Color.fromARGB(255, 50, 83, 99)),
              child: Text(
                'Er. Rohit Singh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings,size: 33,),
              title: Text("Setting", style: TextStyle(fontSize: 18),),
            ),

            ListTile(
              leading: Icon(Icons.info_outline_rounded, size: 33,),
              title: Text("About us", style: TextStyle(fontSize: 18),),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));},
            ),

            ListTile(
              leading: Icon(Icons.logout,size: 33,color:  const Color.fromARGB(255, 175, 23, 12)),
              title: Text("Log out", style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 175, 23, 12)),),
              onTap: () async {
              getIt<AuthCubit>().signOut();
              Navigator.push(context, MaterialPageRoute(builder: (_)=> Signinscreen()));
              }
            ),
          ],
        ),
      ),

      body: Center(
        child: Container(
          height: double.infinity,
          color: Colors.grey[200],

          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text("Category:", style: TextStyle(fontSize: 20)),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: categories.map((category) {
                                          return ListTile(
                                            title: Text(category),
                                            trailing:
                                                selectedCategory == category
                                                ? Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                  )
                                                : null,
                                            onTap: () {
                                              setState(() {
                                                selectedCategory = category;
                                              });
                                              Navigator.pop(context);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedCategory),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Container(
                    // notice container
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Notice Message:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          TextField(
                            maxLines: 3,
                            
                            decoration: InputDecoration(
                              
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15,)),
                              hintText: "@ message",
                            ),
                          ),

                          SizedBox(height: 10),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Select Icon:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Container(
                                height: 95,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 236, 237, 238),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(3, 2), )],
                                ),
                                child: Image.asset("assets/images/icons/advertising.png"),

                              ),

                              SizedBox(width: 12),

                              Container(
                                height: 95,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 236, 237, 238),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(3, 2), )],
                                ),
                                child: Image.asset("assets/images/icons/calendar.png"),
                              ),

                              SizedBox(width: 13),

                              Container(
                                height: 95,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 236, 237, 238),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(3, 2), )],
                                ),
                                child: Image.asset("assets/images/icons/exam.png"),
                              ),

                              SizedBox(width: 13),

                              Container(
                                height: 95,
                                width: 95,
                                decoration: BoxDecoration(
                                  color:const Color.fromARGB(255, 236, 237, 238),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(3, 2), )],
                                ),
                                child: Image.asset("assets/images/icons/trophy.png"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  ElevatedButton(
                    onPressed: () {},

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "SEND NOTICE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(600),
                      elevation: 4,
                      backgroundColor: const Color.fromARGB(255, 50, 83, 99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  ElevatedButton(
                    onPressed: () {},

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber,
                            size: 44,
                          ),
                          Text(
                            "EMERGENCY ALERT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber,
                            size: 44,
                          ),
                        ],
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(600),
                      elevation: 4,
                      backgroundColor: const Color.fromARGB(255, 170, 37, 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
