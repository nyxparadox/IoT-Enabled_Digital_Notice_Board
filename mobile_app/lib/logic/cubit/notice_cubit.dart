

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Data/Repository/notice_repository.dart';
import 'package:mobile_app/logic/cubit/notice_state.dart';

class NoticeCubit extends Cubit<NoticeState> {
  final NoticeRepository _noticeRepository;

  NoticeCubit({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository,
        super(const NoticeState());

  // Create Notice
  Future<void> sendNotice({
    required String category,
    required String message,
    required String? symbol,
    Timestamp? expiryAt,          //  added timestampt for expiry message
    
  }) async {
    try {
      emit(state.copyWith(status: NoticeSatus.loading));

      final notice = await _noticeRepository.sendNotice(
        category : category,
        message: message,
        symbol: symbol,
        expiryAt: expiryAt,
        
      );

      emit(state.copyWith(
        status: NoticeSatus.success,
        notices: [...state.notices, notice],
      ));
    } catch (e) {
      log("cubit error: $e");
      emit(state.copyWith(
        status: NoticeSatus.error,
        error: e.toString(),
      ));
    }
  }

}