import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
import 'package:mobile_app/Screens/homeScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';
import 'package:mobile_app/logic/cubit/auth_state.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();

    getIt<AuthCubit>().checkAuthenticationStatus();
  }
  @override
  Widget build(BuildContext context){
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status){
          case AuthStatus.loading:
          case AuthStatus.initial:
           return _buildSplashScreen();

          case AuthStatus.authenticated:
            return const Homescreen();

          case AuthStatus.unauthenticated:
          case AuthStatus.error:
            return const Signinscreen();
        }
      }
    );
  }
  Widget _buildSplashScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 27, 49, 61),
              Color.fromARGB(255, 69, 127, 158),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset("assets/images/NoticeDesk.png",
              errorBuilder: (context, error, StackTrace){
                return const Icon(
                  Icons.home_outlined,
                  size: 60,
                  color: Color.fromARGB(255, 16, 56, 141),
                );
              },
              ),
            ),
            const SizedBox(height: 30,),

            const Text.rich(TextSpan(children: [TextSpan(text: "Notice",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32)), TextSpan(text: "Desk", style: TextStyle(color: Color.fromARGB(255, 172, 2, 2), fontSize: 32, fontWeight: FontWeight.bold),)])),

            const SizedBox(height: 10,),

            Text("From phone to board--> in seconds", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            textAlign: TextAlign.center,
            ),

            const SizedBox(height: 50,),

            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            const SizedBox(height: 20,),

            Text('Loading...', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),),
           
          ],
        ),
      ),
    );
  }
}
