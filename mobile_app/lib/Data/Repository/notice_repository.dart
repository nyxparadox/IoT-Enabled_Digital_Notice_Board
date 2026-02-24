import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/Data/Model/notice_Model.dart';
import 'package:mobile_app/Services/baseRepository.dart';

class NoticeRepository extends Baserepository{
  Future<NoticeModel> setNotice(String category, String message, String? symbol)async{
    try{
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null){
        throw Exception("user not loged In");
      }
      final userDoc = await firestore.collection("users").doc(currentUser.uid).get();
      final userData =  userDoc.data() as Map<String, dynamic>;

      final notice = NoticeModel(
        noticeBoardId: userData['noticeBoardId'],
        category: category,
        symbol: symbol,
        message: message,
        createdBy: userData['name'],
        isActive: false,

      );

      final docRef = await firestore.collection("notices").add(notice.toMap());
      return notice.copyWith(nid: docRef.id);
      
    }catch(e){
      log("Error: $e");
      rethrow;
    }
  }



  Future<NoticeModel> updateNotice(String category, String message, String? symbol)async{
    try{
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null){
        throw Exception("user not loged In");
      }
      final userDoc = await firestore.collection("users").doc(currentUser.uid).get();
      final userData =  userDoc.data() as Map<String, dynamic>;

      final updatedNotice = NoticeModel(
        noticeBoardId: userData['noticeBoardId'],
        category: category,
        symbol: symbol,
        message: message,
        createdBy: userData['name'],
        isActive: true,

      );
      await firestore.collection("notices").doc("currentNotice").set(updatedNotice.toMap());
      final updatedNoticeDoc = await firestore.collection("notices").doc("currentNotice").get();
      return NoticeModel.fromFirestore(updatedNoticeDoc);

    }catch(e){
      log("error: $e");
      rethrow;
    }
  }




  Future<void> resetNotice(String noticeBoardId) async {
  try {
    final snapshot = await firestore
        .collection("notices")
        .where("noticeBoardId", isEqualTo: noticeBoardId)
        .where("isActive", isEqualTo: true)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({
        "isActive": false,
      });
    }
  } catch (e) {
    log("Error resetting notice: $e");
    rethrow;
  }
}
}