import 'package:get_it/get_it.dart';
import 'package:mobile_app/Router/appRouter.dart';

final getIt = GetIt.instance;

Future<void> setUpServiceLocater() async{
  getIt.registerLazySingleton(() => AppRouter());

}