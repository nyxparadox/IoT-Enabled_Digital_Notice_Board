import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/Data/Model/userModel.dart';
import 'package:mobile_app/Services/baseRepository.dart';

class AuthRepository extends Baserepository {

  Future<Usermodel> signUpDetails({
    required String name,
    required String email,
    required String password,
  })async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.sendEmailVerification();
      log("Verification Link has been sended to User email address for verifiaction");

      final user = Usermodel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        createdAt: Timestamp.now(),
        
      );
      await saveUserData(user);
      return user;

    } catch (e){
      log(e.toString());
      rethrow;
    }
  } 



  Future <Usermodel> signIn({
    required String email,
    required String password,
  })async{
    try{
    final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

    if (!userCredential.user!.emailVerified){
      await auth.signOut();
      throw Exception("please verify email first");
    }

    final userData = await getUserData(userCredential.user!.uid);
    log("User Succesfully SignIn his account");
    return userData;

    }catch(e){
      log(e.toString());
      rethrow;
    }


  }



  Future<Usermodel> updateNoticeBoardId(String noticeBoardId) async{
    try{
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null){
        throw Exception("user not logged in");
      }
      await firestore.collection('users').doc(currentUser.uid).update({"noticeBoardId":noticeBoardId});

      final updatedDoc = await firestore.collection("users").doc(currentUser.uid).get();
      log("Succesfully updated Notice in database");

      return Usermodel.fromFirestore(updatedDoc);
      
    }catch(e){
      log("ERROR: $e");
      rethrow;
    }
  }


  



  Future<void> saveUserData(Usermodel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(user.toMap());
      log('User data saved successfully to Firestore');
    } catch (e) {
      log('Error saving user data: $e');
      throw "Failed to save user data: $e";
    }
  }


  Future<Usermodel> getUserData(String uid)async{
    try{
      log("atempting to get user data of user: $uid");
      final doc = await firestore.collection("users").doc(uid).get();

      if (!doc.exists){
        log("user document not found");
      }

      log("succesfully retreiving user data of user: $uid");
      return Usermodel.fromFirestore(doc);
    } catch(e){
      log(e.toString());
      rethrow;
    }

  }
  

  Future <void> signOut() async {                          // Sign out/ log out function
    try {
      await auth.signOut();
      log('User signed out successfully');
    } catch (e) {
      log('Error signing out: $e');
      throw "Failed to sign out: $e";
    }
  }


  Future<void> sendPasswordResetEmail(String email) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    log("Succesfully send Password Reset link to the user registered email");
  } catch (e) {
    log("ERROR: $e");
    rethrow;
  }
}


}