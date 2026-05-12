import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/aboutUsPage.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
import 'package:mobile_app/Screens/settings_screen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/Widgets/current_notice_card.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';
import 'package:mobile_app/logic/cubit/notice_cubit.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<String> categories = [
    "NOTICE",
    "EXAM",
    "ACADEMIC",
    "EVENT",
    "HOLIDAY",
    "EMERGENCY",
  ];

  String selectedCategory = "NOTICE";
  String? selectedIcon;
  bool _isloading = false;

  // current live notice variable
  Map<String, dynamic>? currentNoticeData;

  bool isCurrentNoticeLoading = true;

  // FUNCTION FOR LOAD CURRENT LIVE DISPLAYED NOTICE

  void _listenCurrentNotice() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data();

      if (userData == null) return;

      String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll("/", "_");

      FirebaseDatabase.instance
          .ref()
          .child("noticeBoard")
          .child(boardId)
          .child("Notice")
          .onValue
          .listen((event) {
            final data = event.snapshot.value;

            if (data != null) {
              setState(() {
                currentNoticeData = Map<String, dynamic>.from(data as Map);

                isCurrentNoticeLoading = false;
              });
            } else {
              setState(() {
                currentNoticeData = null;

                isCurrentNoticeLoading = false;
              });
            }
          });
    } catch (e) {
      log("CURRENT NOTICE ERROR: $e");
    }
  }


//  FUNCTION TO HANDEL SEND NOTICE MESSAGES 
  Future<void> _handelSendNotice() async {
    setState(() {
      _isloading = true;
    });
    try {
      if (_messageController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please provide message to send",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 200),
          ),
        );
        setState(() {
          _isloading = false;
        });
        return;
      }

      await getIt<NoticeCubit>().sendNotice(
        category: selectedCategory,
        message: _messageController.text,
        symbol: selectedIcon,
        expiryAt: null,  // this will be added later as when scheduled expire message 
      );

      setState(() {
        _isloading = false;
        selectedCategory = "NOTICE"; // reset to deafault state
        _messageController
            .clear(); // reset message field by clearing message after success
        selectedIcon =
            null; // if icon is selected than it will sated as unselected after uploading message
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "NOTICE SUCCESSFULY UPLOADED",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green[900],
        ),
        snackBarAnimationStyle: AnimationStyle(
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        ),
      );

      FocusScope.of(context).unfocus();
    } catch (e) {
      log("Error: $e");
      setState(() {
        _isloading = false;
      });
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();

    _listenCurrentNotice();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 50, 83, 99),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("assets/images/collage_logo.png"),
                  ),
                  SizedBox(width: 12),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 47)),
                      Text(
                        "ABVGIET, SHIMLA (H.P.)",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Text(
                        "director.abv@gmail.com",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),

                  // Text("NoticeDesk", style: TextStyle(color: Colors.white, fontSize: 13),),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings, size: 33),
              title: Text("Settings", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.info_outline_rounded, size: 33),
              title: Text("About us", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),

            ListTile(
              leading: Icon(
                Icons.logout,
                size: 33,
                color: const Color.fromARGB(255, 175, 23, 12),
              ),
              title: Text(
                "Log out",
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 175, 23, 12),
                ),
              ),
              onTap: () async {
                getIt<AuthCubit>().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Signinscreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            height: double.infinity,
            color: Colors.grey[200],

            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                  
                    // CURRENT LIVE NOTICE CARD
                    isCurrentNoticeLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CurrentNoticeCard(
                            category:
                                currentNoticeData?['category'] ?? "NOTICE",
                            message:
                                currentNoticeData?['message'] ??
                                "No active notice",
                            symbol: currentNoticeData?['symbol'],

                            // ACTIVE TIME
                            activeSince: currentNoticeData?['createdAt'] != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                    currentNoticeData!['createdAt'],
                                  ).toString()
                                : "--",

                            // EXPIRY TIME           -- function will be added later 
                            expiryTime: currentNoticeData?['expiryAt'] != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                    currentNoticeData!['expiryAt'],
                                  ).toString()
                                : "No expiry",
                          ),

                    const SizedBox(height: 25),

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
                              controller: _messageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedIcon == "anouncement") {
                                        selectedIcon = null;
                                      } else {
                                        selectedIcon = "anouncement";
                                      }
                                    });
                                    log("button pressed");
                                    log(
                                      "selectedIcon is seted as = $selectedIcon",
                                    );
                                  },
                                  child: AnimatedScale(
                                    scale: selectedIcon == "anouncement"
                                        ? 1.08
                                        : 1.0,
                                    duration: Duration(milliseconds: 250),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.all(12),
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        color: selectedIcon == "anouncement"
                                            ? Colors.blue[200]
                                            : const Color.fromARGB(
                                                255,
                                                236,
                                                237,
                                                238,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: selectedIcon == "anouncement"
                                            ? [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    4,
                                                    10,
                                                    15,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                  offset: Offset(3, 2),
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(3, 2),
                                                ),
                                              ],
                                      ),
                                      child: Image.asset(
                                        "assets/images/icons/advertising.png",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedIcon == "calender") {
                                        selectedIcon = null;
                                      } else {
                                        selectedIcon = "calender";
                                      }
                                    });
                                    log("button pressed");
                                    log(
                                      "selectedIcon is seted as = $selectedIcon",
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: AnimatedScale(
                                    scale: selectedIcon == "calender"
                                        ? 1.08
                                        : 1.0,
                                    duration: Duration(milliseconds: 250),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.all(12),
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        color: selectedIcon == "calender"
                                            ? Colors.blue[200]
                                            : const Color.fromARGB(
                                                255,
                                                236,
                                                237,
                                                238,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: selectedIcon == "calender"
                                            ? [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    4,
                                                    10,
                                                    15,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                  offset: Offset(3, 2),
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(3, 2),
                                                ),
                                              ],
                                      ),
                                      child: Image.asset(
                                        "assets/images/icons/calendar.png",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 13),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedIcon == "exam") {
                                        selectedIcon = null;
                                      } else {
                                        selectedIcon = "exam";
                                      }
                                    });
                                    log("button pressed");
                                    log(
                                      "selectedIcon is seted as = $selectedIcon",
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: AnimatedScale(
                                    scale: selectedIcon == "exam" ? 1.08 : 1.0,
                                    duration: Duration(milliseconds: 250),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.all(12),
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        color: selectedIcon == "exam"
                                            ? Colors.blue[200]
                                            : const Color.fromARGB(
                                                255,
                                                236,
                                                237,
                                                238,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: selectedIcon == "exam"
                                            ? [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    4,
                                                    10,
                                                    15,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                  offset: Offset(3, 2),
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(3, 2),
                                                ),
                                              ],
                                      ),
                                      child: Image.asset(
                                        "assets/images/icons/exam.png",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 13),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedIcon == "trophy") {
                                        selectedIcon = null;
                                      } else {
                                        selectedIcon = "trophy";
                                      }
                                    });
                                    log("button pressed");
                                    log(
                                      "selectedIcon is seted as = $selectedIcon",
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: AnimatedScale(
                                    scale: selectedIcon == "trophy"
                                        ? 1.08
                                        : 1.0,
                                    duration: Duration(milliseconds: 250),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.all(12),
                                      height: 95,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        color: selectedIcon == "trophy"
                                            ? Colors.blue[200]
                                            : const Color.fromARGB(
                                                255,
                                                236,
                                                237,
                                                238,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: selectedIcon == "trophy"
                                            ? [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    4,
                                                    10,
                                                    15,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                  offset: Offset(3, 2),
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  offset: Offset(3, 2),
                                                ),
                                              ],
                                      ),
                                      child: Image.asset(
                                        "assets/images/icons/trophy.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 35),

                    ElevatedButton(
                      onPressed: _isloading ? null : _handelSendNotice,
                      child: _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : Padding(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
