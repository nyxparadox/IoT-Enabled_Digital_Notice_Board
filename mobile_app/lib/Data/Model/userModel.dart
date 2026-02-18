import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String? uid;
  final String? name;
  final String? email;
  final Timestamp? createdAt;
  final bool? isActive;
  final String? noticeBoardId;


  Usermodel({
    this.uid,
    this.name,
    this.email,
    this.isActive,
    this.noticeBoardId,  
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  Usermodel copyWith({
  String? uid,
  String? name,
  String? email,
  Timestamp? createdAt,
  bool? isActive,
  String? noticeBoardId,
  }) {
    return Usermodel(
      uid : uid ?? this.uid,
      name : name ?? this.name,
      email : email ?? this.email,
      noticeBoardId: noticeBoardId ?? this.noticeBoardId,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive
    );
  }


  // to make fields in firebase database
  // firebase does not understand dart onjects that's why we need to chnage in jason type to store
  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "email" : email,
      "noticeBoardId" : noticeBoardId,
      "createdAt" : createdAt,
      "isActive" : isActive
    };
  }


  //It allows our Flutter app to convert a Firestore user document into a usable Dart object (UserModel),
  // so we can easily access user info in our app code.
  factory Usermodel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return Usermodel(
      uid: doc.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "" ,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      isActive: data['isActive'] ?? "" ,

    );
  }


}





