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
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/providers/search_controller.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/screens/auth_wrapper.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/storage/hive_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:month_year_picker/month_year_picker.dart';
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
        final db = DatabaseService(apiService: api);
        final favRepo = FavoriteRepository(HiveLocalStorageService(HiveKeys.BOX_FAVORITE));
        final addressRepo = AddressesRepository(HiveLocalStorageService(HiveKeys.BOX_ADDRESSES));
        final cartRepo = CartRepository(
          apiService: api,
          localStorage: HiveLocalStorageService(HiveKeys.BOX_CART),
        );
        final authRepo = AuthRepository(
          authService: FirebaseAuthService(),
          apiService: api,
          favoriteRepository: favRepo,
          addressesRepository: addressRepo,
          cartRepository: cartRepo,
          localStorageService: HiveLocalStorageService(
            HiveKeys.BOX_AUTH,
          ),
        );
        return MultiProvider(
          providers: [
            Provider<Database>(
              create: (_) => db,
            ),
            Provider<AuthRepositoryBase>(
              create: (_) => authRepo,
            ),
            Provider<FavoriteRepositoryBase>(
              create: (_) => favRepo,
            ),
            Provider<AddressesRepositoryBase>(
              create: (_) => addressRepo,
            ),
            Provider<CartRepositoryBase>(
              create: (_) => cartRepo,
            ),
            ChangeNotifierProvider(
              create: (_) => AuthController(
                authRepository: authRepo,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => CartController(
                cartRepository: cartRepo,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => SearchController(db),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: TransUtil.trans("app_name"),
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: context.localizationDelegates,
      localizationsDelegates: [
        ...context.localizationDelegates,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyThemes.lightTheme,
      home: AuthWrapper(),
    );
  }
}

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
  await Hive.openBox(HiveKeys.BOX_AUTH);
}
