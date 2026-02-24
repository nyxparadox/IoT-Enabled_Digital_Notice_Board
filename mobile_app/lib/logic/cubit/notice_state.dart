import 'package:equatable/equatable.dart';
import 'package:mobile_app/Data/Model/notice_Model.dart';

enum NoticeSatus {
  initial,
  loading,
  error,
  success
}

class NoticeState extends Equatable{
  final NoticeSatus status;
  final List<NoticeModel> notices;
  final String? error;

  const NoticeState({
    this.status = NoticeSatus.initial,
    this.notices = const [],
    this.error
  });

  NoticeState copyWith({
    NoticeSatus? status,
    List<NoticeModel>? notices,
    String? error
  }){
    return NoticeState(
      status: status ?? this.status,
      notices: notices ?? this.notices,
      error: error ?? this.error,
    );
  }

   @override
  List<Object?> get props => [status, notices , error ];
}

