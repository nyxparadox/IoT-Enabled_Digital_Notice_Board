import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_app/Data/Model/settings_model.dart';
import 'package:mobile_app/Services/baseRepository.dart';

class SettingsRepository extends Baserepository {
  final DatabaseReference rtdb = FirebaseDatabase.instance.ref();

  Future<SettingsModel> fetchSettings(
  ) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception("user not logged");
      }

      final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;

      String boardId = userData['noticeBoardId']     // this is for replacing . and / with "_" so it easy for us and realtime databse 
          .replaceAll(".", "_")
          .replaceAll("/", "_");

      final doc = await rtdb
          .child("noticeBoard")
          .child("boardId")
          .child("Settings")
          .get();

      if (!doc.exists) {
        // DEFAULT SETTINGS   (This is default setting for messages settings)
        final defaultSettings = SettingsModel(
          brightness: 65,
          scrollSpeed: 2,
          displayMode: "scroll",
          headerTextColor: "red",
          bodyTextColor: "blue",
          borderEnabled: false,
          borderStyle: "single",
          borderColor: "green",
          borderThickness: 2,
        );

        await rtdb.child("noticeBoard").child(boardId).child("Settings").set({
          "settings": defaultSettings.toMap(),
          "commands": {
            "restartDeviece": false,
            "resetWifi": false,
            "resetDisplay": false,
          },
        });

        return defaultSettings;
      }

      final data =doc.value as Map<dynamic, dynamic>; // we can use null assertion operator !

      if (!data.containsKey("settings")) {
        final defaultSettings = SettingsModel(
          brightness: 65,
          scrollSpeed: 2,
          displayMode: "scroll",
          headerTextColor: "red",
          bodyTextColor: "blue",
          borderEnabled: false,
          borderStyle: "single",
          borderColor: "green",
          borderThickness: 2,
        );

        await rtdb.child("noticeBoard").child(boardId).child("Settings").update({
          "settings": defaultSettings.toMap(),
        });

        return defaultSettings;
      }
      return SettingsModel.fromMap(data["settings"]);
      
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }

  Future<void> updateSettings(SettingsModel settings) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("user not logged");
    }

    final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

    final userData = userDoc.data() as Map<String, dynamic>;
    
    String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll("/", "_");

    await rtdb.child("noticeBoard").child(boardId).child("Settings").update({
      "settings" : settings.toMap(),
    });
  }




  Future<void> sendCommand(String command) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("user not logged");
    }

    final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

    final userData = userDoc.data() as Map<String, dynamic>;
    
    String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll("/", "_");

    await rtdb.child("noticeBoard").child(boardId).child("Settings").update({
      "commands" : {command : true},
    });
  }



  Future<void> sendWifiCredentials(String ssid, String password) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("user not logged");
    }

    final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

    final userData = userDoc.data() as Map<String, dynamic>;
    
    String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll("/", "_");

    await rtdb.child("noticeBoard").child(boardId).child("Settings").update({
      "wifi" : {"ssid": ssid, "password": password},
    });
  }
  
}


  

