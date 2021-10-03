import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/home.dart';
import 'package:faya_clinic/screens/login_screen.dart';
import 'package:faya_clinic/screens/main_wrapper.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(langEnCode, ""),
        Locale(langArCode, ""),
      ],
      path: "assets/languages",
      fallbackLocale: Locale(langEnCode),
      saveLocale: true,
      useOnlyLangCode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthService(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<AuthService>();

    return MaterialApp(
      title: 'Faya Clinic',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: StreamBuilder<Object>(
        stream: _provider.authChangeStream,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (!snapshot.hasData || snapshot.hasError) {
          //   return LoginScreen();
          // }
          return HomeMainWrapper();
        },
      ),
    );
  }
}
