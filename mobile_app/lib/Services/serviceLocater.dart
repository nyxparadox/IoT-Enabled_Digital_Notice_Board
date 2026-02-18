import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/Data/Repository/auth_repository.dart';
import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setUpServiceLocater() async{
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(()=> FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(()=> FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(()=> AuthCubit(authRepository: AuthRepository()));

}