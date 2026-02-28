import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Data/Repository/auth_repository.dart';
import 'package:mobile_app/logic/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState()) ;

  

//       this will called after otp verification -creates anonymous user with email/phone

  Future<void> signUpDetails({
    required String name,
    required String email,
    required String password,
    
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await _authRepository.signUpDetails(
        name: name,
        email: email,
        password: password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      ));
    }
  }





  Future<void> updateNoticeBoardId({
    required String NoticeBoardId,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await _authRepository.updateNoticeBoardId(NoticeBoardId);
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      ));
    }
  }


  

           
  Future<void> signIn({                         
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: 'email/password are incorrect, Please enter correct email/password',
        
      ));
    }
  }

  Future<void> signOut() async {                          
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await _authRepository.signOut();
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      ));
    }
  }


  Future<void> checkAuthenticationStatus() async {               // Function to check whether user is authenticated or not
  try {
    emit(state.copyWith(status: AuthStatus.loading));
    
    final currentUser = _authRepository.auth.currentUser;
    
    if (currentUser != null) {
      final userData = await _authRepository.getUserData(currentUser.uid);
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: userData,
      ));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  } catch (e) {
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      error: e.toString(),
    ));
  }
}

  Future<void> forgotPassword(String email) async {
  try {
    emit(state.copyWith(status: AuthStatus.loading));

    await _authRepository.sendPasswordResetEmail(email);

    emit(state.copyWith(status: AuthStatus.authenticated));
  } catch (e) {
    emit(state.copyWith(
      status: AuthStatus.error,
      error: e.toString(),
    ));
  }
}


  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}