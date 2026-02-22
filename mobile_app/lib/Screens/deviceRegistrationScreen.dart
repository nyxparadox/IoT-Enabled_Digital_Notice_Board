import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/homeScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';

class Deviceregistrationscreen extends StatefulWidget {
  const Deviceregistrationscreen({super.key});

  @override
  State<Deviceregistrationscreen> createState() =>
      _DeviceregistrationscreenState();
}

class _DeviceregistrationscreenState extends State<Deviceregistrationscreen> {
  final TextEditingController _noticeBoardIdController =
      TextEditingController();
  bool _isloading = false;

  Future<void> _handelIdRegistration() async {
    setState(() {
      _isloading = true;
    });
    try {
      if (_noticeBoardIdController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please Enter Notice Board Id ",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() {
          _isloading = false;
        });
        return;
      }

      await getIt<AuthCubit>().updateNoticeBoardId(
        NoticeBoardId: _noticeBoardIdController.text,
      );
      setState(() {
        _isloading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Homescreen()),
      );
    } catch (e) {
      log("ERROR: $e");
      setState(() {
        _isloading = false;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 228, 234, 237),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Enter your Notice Board ID to link your device'),

                    const SizedBox(height: 10),

                    TextFormField(
                      // validator: _validate,
                      controller: _noticeBoardIdController,
                      decoration: InputDecoration(
                        labelText: 'notice board ID',
                        prefixIcon: Icon(Icons.library_books_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _isloading ? null : _handelIdRegistration,
                      child: _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Link",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                      // : Text('Link', style: TextStyle(color: Colors.white, fontSize: 23)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 50, 83, 99),
                        minimumSize: Size(200, 57),
                        elevation: 3,
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
