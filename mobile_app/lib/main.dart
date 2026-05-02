import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Data/Repository/settings_repository.dart';
import 'package:mobile_app/Router/appRouter.dart';
import 'package:mobile_app/Screens/splashScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/logic/cubit/auth_cubit.dart';
import 'package:mobile_app/logic/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setUpServiceLocater();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsCubit(settingsRepository: getIt<SettingsRepository>()),
        ),

        BlocProvider.value(value: getIt<AuthCubit>()),
      ],
      child: MaterialApp(
        title: "NoticeDesk",
        navigatorKey: getIt<AppRouter>().navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const Splashscreen(),
      ),
    );
  }
}
