import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/favorite_products/favorite_products_screen.dart';
import 'package:faya_clinic/screens/user_orders/user_orders_screen.dart';
import 'package:faya_clinic/screens/user_account/profile_screen.dart';
import 'package:faya_clinic/screens/user_account/user_account_controller.dart';
import 'package:faya_clinic/screens/user_addresses/user_addresses.dart';
import 'package:faya_clinic/screens/user_dates/user_dates_screen.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/utils/url_launcher_util.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  final Function onLogout;
  const MyAccountScreen._({Key key, @required this.controller, this.onLogout}) : super(key: key);
  final UserAccountController controller;

  static Widget create(BuildContext context, Function onLogout) {
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<UserAccountController>(
      create: (_) => UserAccountController(authRepository: authRepo),
      builder: (ctx, child) {
        return Consumer<UserAccountController>(
          builder: (context, controller, _) => MyAccountScreen._(
            controller: controller,
            onLogout: onLogout,
          ),
        );
      },
    );
  }

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Function get onLogout => widget.onLogout;
  UserAccountController get controller => widget.controller;
  var currentLangCode = "";

  @override
  void didChangeDependencies() {
    currentLangCode = TransUtil.getCurrentLangCode(context);
    super.didChangeDependencies();
  }

  void changeLanguage(String langCode) {
    if (currentLangCode == langCode) return;
    TransUtil.changeLocale(context, langCode);
    setState(() {});
  }

  void openProfileScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => ChangeNotifierProvider.value(
          value: controller,
          child: ProfileScreen(),
        ),
      ),
    );
  }

  void openUrl(String url) {
    try {
      UrlLauncherUtil.openURL(url);
    } catch (error) {
      DialogUtil.showAlertDialog(context, error.toString(), null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.18;
    return SectionCornerContainer(
      title: TransUtil.trans("header_account"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserSection(headerHeight),
            _buildOptionsGroup1(context),
            // _buildLangSection(context),
            _buildOptionsGroup2(),
            _buildOptionsGroup3(),
          ],
        ),
      ),
    );
  }

  Container _buildOptionsGroup3() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: marginLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListItem(
            title: TransUtil.trans("list_item_logout"),
            leading: Icons.logout,
            onTap: onLogout,
            // onTap: () {
            //   Provider.of<AuthController>(context, listen: false).logout();
            //   Provider.of<CartController>(context, listen: false).clearCart();
            // },
          ),
        ],
      ),
      // end list options group 3
    );
  }

  Container _buildOptionsGroup2() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: marginLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListItem(
            title: TransUtil.trans("list_item_faq"),
            leading: Icons.question_answer,
            withDivider: true,
            onTap: () => openUrl(AppConfig.URL_FAQs),
          ),
          _buildListItem(
            title: TransUtil.trans("list_item_privacy_policy"),
            leading: Icons.lock,
            withDivider: true,
            onTap: () => openUrl(AppConfig.URL_PRIVACY_POLICY),
          ),
          _buildListItem(
            title: TransUtil.trans("list_item_terms_conditions"),
            leading: Icons.note,
            onTap: () => openUrl(AppConfig.URL_TERMS_CONDITIONS),
          ),
        ],
      ),
      // end list options group 2
    );
  }

  // ! disabled for now
  Widget _buildLangSection(BuildContext context) {
    final isRTL = TransUtil.isArLocale(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
          child: Align(
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              TransUtil.trans("header_languages"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: marginLarge),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 1.0),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: [
              RadioListTile(
                value: langEnCode,
                selected: TransUtil.isEnLocale(context),
                groupValue: currentLangCode,
                toggleable: true,
                selectedTileColor: colorPrimary,
                tileColor: colorPrimary,
                onChanged: (langCode) => changeLanguage(langCode),
                title: Text("English"),
                activeColor: colorPrimary,
              ),
              RadioListTile(
                value: langArCode,
                selected: TransUtil.isArLocale(context),
                groupValue: currentLangCode,
                toggleable: true,
                selectedTileColor: colorPrimary,
                tileColor: colorPrimary,
                onChanged: (langCode) => changeLanguage(langCode),
                title: Text("العربية"),
                activeColor: colorPrimary,
              ),
            ],
          ),
          // end languages list options
        ),
      ],
    );
  }

  Widget _buildOptionsGroup1(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black26,
        //     offset: Offset(0.0, 1.0),
        //     blurRadius: 1.0,
        //   ),
        // ],// ! un comment when the lang section is back
      ),
      child: Column(
        children: [
          _buildListItem(
            title: TransUtil.trans("list_item_my_dates"),
            leading: Icons.calendar_today_rounded,
            withDivider: true,
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => UserDatesScreen.create(context))),
          ),
          _buildListItem(
            title: TransUtil.trans("list_item_my_addresses"),
            leading: Icons.location_on,
            withDivider: true,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => UserAddressesScreen.create(context))),
          ),
          _buildListItem(
            title: TransUtil.trans("list_item_fav_products"),
            leading: Icons.favorite,
            withDivider: true,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => FavoriteProductsScreen.create(context))),
          ),
          _buildListItem(
            withDivider: true, // ! remove the divider when the lang section is back
            title: TransUtil.trans("list_item_previous_orders"),
            leading: Icons.shopping_bag_rounded,
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => UserOrdersScreen.create(context))),
          ),
        ],
      ),
      // end list options group 1
    );
  }

  Widget _buildListItem({String title, IconData leading, Function onTap, bool withDivider = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            leading,
            color: colorPrimary,
          ),
          title: Text(
            title,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorPrimary,
          ),
          onTap: onTap,
        ),
        Visibility(
          visible: withDivider,
          child: Divider(
            thickness: 1.0,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }

  Widget _buildUserSection(double headerHeight) {
    return Container(
      width: double.infinity,
      height: headerHeight,
      padding: const EdgeInsets.all(marginLarge),
      margin: const EdgeInsets.only(bottom: marginLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // user avatar container
            width: headerHeight * 0.6,
            height: headerHeight * 0.6,
            decoration: BoxDecoration(
              color: colorGreyLight,
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: controller.user?.imgUrl == null
                ? SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radiusStandard),
                    ),
                    child: NetworkCachedImage(
                      imageUrl: controller.user.imgUrl,
                    ),
                  ),
          ),
          SizedBox(
            width: marginLarge,
          ),
          Expanded(
            // user name and phone number container
            child: Container(
              height: headerHeight * 0.6,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user?.userName ?? "",
                    style: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeLarge,
                    ),
                  ),
                  Text(
                    controller.user?.phoneNumber?.toString() ?? "",
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: openProfileScreen,
            child: Icon(
              Icons.edit,
              color: colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
