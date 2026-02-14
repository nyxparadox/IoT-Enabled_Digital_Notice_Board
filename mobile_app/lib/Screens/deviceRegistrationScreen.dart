import 'package:flutter/material.dart';

class Deviceregistrationscreen extends StatefulWidget {
  const Deviceregistrationscreen({super.key});

  @override
  State<Deviceregistrationscreen> createState() => _DeviceregistrationscreenState();
}

class _DeviceregistrationscreenState extends State<Deviceregistrationscreen> {
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

                    const SizedBox(height: 10,),

                    TextField(
          
                      decoration: InputDecoration(
                        labelText: 'notice board ID',
                        prefixIcon: Icon(Icons.library_books_outlined),
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 20,),

                    ElevatedButton(
                      onPressed: (){},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            
                            height: 20,
                            
                          ),
                          Text("Link", style: TextStyle(color: Colors.white, fontSize: 23),)
                        ],
                      ),
                      // : Text('Link', style: TextStyle(color: Colors.white, fontSize: 23)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                              255,
                              50,
                              83,
                              99,
                            ),
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