

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Data/Repository/notice_repository.dart';
import 'package:mobile_app/logic/cubit/notice_state.dart';

class NoticeCubit extends Cubit<NoticeState> {
  final NoticeRepository _noticeRepository;

  NoticeCubit({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository,
        super(const NoticeState());

  /// 🔹 Create Notice
  Future<void> createNotice({
    required String category,
    required String message,
    required String? symbol,
    
  }) async {
    try {
      emit(state.copyWith(status: NoticeSatus.loading));

      final notice = await _noticeRepository.setNotice(
        category,
        message,
        symbol,
        
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


  // update notice
  Future<void> updateNotice({
    required String category,
    required String message,
    required String? symbol,
    
  }) async {
    try {
      emit(state.copyWith(status: NoticeSatus.loading));

      final notice = await _noticeRepository.updateNotice(
        category,
        message,
        symbol,
        
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








  /// 🔹 Reset Notice
  Future<void> resetNotice(String noticeBoardId) async {
    try {
      emit(state.copyWith(status: NoticeSatus.loading));

      await _noticeRepository.resetNotice(noticeBoardId);

      emit(state.copyWith(status: NoticeSatus.success));
    } catch (e) {
      log("Reset Error: $e");
      emit(state.copyWith(
        status: NoticeSatus.error,
        error: e.toString(),
      ));
    }
  }
}