import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_app/Data/Model/notice_Model.dart';
import 'package:mobile_app/Services/baseRepository.dart';

class NoticeRepository extends Baserepository {
  Future<NoticeModel> sendNotice({
    required String category,
    required String message,
    required String? symbol,
    Timestamp? expiryAt,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception("user not loged In");
      }
      final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();
      final userData = userDoc.data() as Map<String, dynamic>;

      final notice = NoticeModel(
        noticeBoardId: userData['noticeBoardId'],
        category: category,
        symbol: symbol,
        message: message,
        createdBy: userData['name'],
        isActive: false,
        createdAt: Timestamp.now(),
        expiryAt: expiryAt,     // optional 
      );

      final docRef = await firestore.collection("notices").add(notice.toMap());

      await firestore
         .collection("notices")
         .doc("currentNotice")
         .set(notice.toMap());

      final DatabaseReference rtdb = FirebaseDatabase.instance.ref();

      String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll( "/", "_");
          
      await rtdb.child("noticeBoard").child(boardId).child("Notice").set({
        "category": category,
        "message": message,
        "symbol": symbol,
        "createdAt": Timestamp.now().millisecondsSinceEpoch,
        "expiryAt":expiryAt?.millisecondsSinceEpoch,
      });
      
      return notice.copyWith(nid: docRef.id);
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }


// listen and stream notices from realtime databse for current dispaying message on app
  Stream<DatabaseEvent> currentNoticeStream(
    String boardId,
  ) {

    return firebaseDatabase
        .ref()
        .child("noticeBoard")
        .child(boardId)
        .child("Notice")
        .onValue;
  }
}
