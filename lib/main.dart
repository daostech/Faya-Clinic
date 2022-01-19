import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/api/api.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/constants/themes.dart';
import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/repositories/user_repository.dart';
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
      child: Builder(builder: (context) {
        final api = APIService(API());
        return MultiProvider(
          providers: [
            Provider<Database>(
              create: (_) => DatabaseService(apiService: api),
            ),
            Provider<UserRepositoryBase>(
              create: (_) => UserRepository(
                apiService: api,
                localStorageService: HiveLocalStorageService(
                  HiveKeys.BOX_USER_DATA,
                ),
              ),
            ),
            Provider<FavoriteRepositoryBase>(
              create: (_) => FavoriteRepository(HiveLocalStorageService(HiveKeys.BOX_FAVORITE)),
            ),
            Provider<AddressesRepositoryBase>(
              create: (_) => AddressesRepository(HiveLocalStorageService(HiveKeys.BOX_ADDRESSES)),
            ),
            Provider<AuthBase>(
              create: (_) => AuthService(),
            ),
            // ChangeNotifierProvider(
            //   create: (_) => AuthService(),
            // ),
            ChangeNotifierProvider(
              create: (_) => CheckoutController(),
            ), // ! lift down
            ChangeNotifierProvider(
              create: (_) => CartController(HiveLocalStorageService(HiveKeys.BOX_CART)),
            ),
          ],
          child: MyApp(),
        );
      }),
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
  if (!Hive.isAdapterRegistered(HiveKeys.TYPE_ADDREESS)) {
    Hive.registerAdapter(AddressAdapter());
  }
  if (!Hive.isAdapterRegistered(HiveKeys.TYPE_USER)) {
    Hive.registerAdapter(MyUserAdapter());
  }
  if (!Hive.isAdapterRegistered(HiveKeys.TYPE_ORDER_ITEM)) {
    Hive.registerAdapter(OrderItemAdapter());
  }

  // open boxes
  await Hive.openBox(HiveKeys.BOX_FAVORITE);
  await Hive.openBox(HiveKeys.BOX_ADDRESSES);
  await Hive.openBox(HiveKeys.BOX_USER_DATA);
  await Hive.openBox(HiveKeys.BOX_CART);
}
