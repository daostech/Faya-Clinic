import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/api/api.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/constants/themes.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/screens/landing_screen.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/storage/hive_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await init();

  // FavoriteRepositoryBase favoriteRepository = FavoriteRepository(HiveLocalStorageService(HiveKeys.BOX_FAVORITE));
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
      // child: dependenciesWrappr(),
      child: MultiProvider(
        providers: [
          Provider<Database>(
            create: (_) => DatabaseService(apiService: APIService(API())),
          ),
          Provider<FavoriteRepositoryBase>(
            create: (_) => FavoriteRepository(HiveLocalStorageService(HiveKeys.BOX_FAVORITE)),
          ),
          Provider<AuthBase>(
            create: (_) => AuthService(),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => AuthService(),
          // ),
          ChangeNotifierProvider(
            create: (_) => CheckoutController(),
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
    return MaterialApp(
      title: 'Faya Clinic',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyThemes.lightTheme,
      home: LandingScreen(),
    );
  }
}

// void

Future init() async {
  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  // register adapters
  if (!Hive.isAdapterRegistered(HiveKeys.TYPE_PRODUCT)) {
    Hive.registerAdapter(ProductAdapter());
  }

  // open boxes
  await Hive.openBox(HiveKeys.BOX_FAVORITE);
}
