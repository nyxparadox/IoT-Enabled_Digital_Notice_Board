import 'package:cloud_firestore/cloud_firestore.dart';


class NoticeModel {
  final String? nid;
  final String? noticeBoardId;
  final String? message;
  final String? category;
  final String? symbol;
  final String? createdBy;
  final Timestamp? createdAt;
  final Timestamp? expiryAt;
  final bool? isActive;

  NoticeModel({
    this.nid,
    this.noticeBoardId,
    this.message,
    this.category,
    this.symbol,
    this.createdBy,
    Timestamp? createdAt,
    this.expiryAt,
    this.isActive
  }): createdAt = createdAt ?? Timestamp.now();

  NoticeModel copyWith({
    String? nid,
    String? noticeBoardId,
    String? message,
    String? category,
    String? symbol,
    String? createdBy,
    Timestamp? createdAt,
    Timestamp? expiryAt,
    bool? isActive

  }) {
    return NoticeModel(
    nid: nid ?? this.nid,
    noticeBoardId: noticeBoardId ?? this.noticeBoardId,
    message: message ?? this.message,
    category: category ?? this.category,
    symbol: symbol ?? this.symbol,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    expiryAt: expiryAt ?? this.expiryAt,
    isActive: isActive ?? this.isActive
    );
  }
  
  Map<String, dynamic> toMap(){
    return{
      
      "noticeBoardId": noticeBoardId,
      "message": message,
      "category" : category,
      "symbol" : symbol,
      "createdBy" : createdBy,
      "createdAt" : createdAt,
      "expiryAt" : expiryAt,
      "isActive" : isActive
    };
  }

  factory NoticeModel.fromFirestore(DocumentSnapshot doc){
    final noticeData = doc.data() as Map<String, dynamic>? ?? {};
    return NoticeModel(
      nid: doc.id,
      noticeBoardId: noticeData["noticeBoardId"] ?? "",
      message: noticeData["message"] ?? "",
      category: noticeData["category"] ?? "" ,
      symbol: noticeData["symbol"] ?? "" ,
      createdBy: noticeData['createdBy'] ?? "",
      createdAt: noticeData['createdAt'] as Timestamp? ?? Timestamp.now(),
      expiryAt: noticeData['expiryAt'] as Timestamp?,
      isActive: noticeData['isActive'] as bool ? noticeData['isActive'] : false ,
    );
  }


}
