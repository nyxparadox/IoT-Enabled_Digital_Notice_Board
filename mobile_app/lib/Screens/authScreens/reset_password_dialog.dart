import 'package:flutter/material.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return AlertDialog(
      title: Text("Reset Password"),
      content: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: "enter your registered email",
        ),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context),
         child: Text("cancel")),
         ElevatedButton(onPressed: (){
          getIt<AuthCubit>().forgotPassword(_emailController.text);
          Navigator.pop(context);
         }, child: Text("Send"))
      ],
    );
  }
}