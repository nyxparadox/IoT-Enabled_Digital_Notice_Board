import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_app/Data/Model/notice_Model.dart';
import 'package:mobile_app/Services/baseRepository.dart';

class NoticeRepository extends Baserepository {
  Future<NoticeModel> setNotice(
    String category,
    String message,
    String? symbol,
  ) async {
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
      );

      final docRef = await firestore.collection("notices").add(notice.toMap());

      final DatabaseReference rtdb = FirebaseDatabase.instance.ref();

      String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll( "/", "_");
          
      await rtdb.child("noticeBoard").child(boardId).set({
        "category": category,
        "message": message,
        "symbol": symbol,
        "noticeBoardId": boardId, // optional
      });
      
      return notice.copyWith(nid: docRef.id);
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }

  Future<NoticeModel> updateNotice(
    String category,
    String message,
    String? symbol,
  ) async {
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

      final updatedNotice = NoticeModel(
        noticeBoardId: userData['noticeBoardId'],
        category: category,
        symbol: symbol,
        message: message,
        createdBy: userData['name'],
        isActive: true,
      );
      await firestore
          .collection("notices")
          .doc("currentNotice")
          .set(updatedNotice.toMap());

      final DatabaseReference rtdb = FirebaseDatabase.instance.ref();

       String boardId = userData['noticeBoardId']
          .replaceAll(".", "_")
          .replaceAll("/", "_");


      await rtdb.child("noticeBoard").child(boardId).set({
        "category": category,
        "message": message,
        "symbol": symbol,
        "noticeBoardId": boardId, // optional
      });

      final updatedNoticeDoc = await firestore
          .collection("notices")
          .doc("currentNotice")
          .get();
      return NoticeModel.fromFirestore(updatedNoticeDoc);
    } catch (e) {
      log("error: $e");
      rethrow;
    }
  }
}
