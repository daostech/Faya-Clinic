import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/favorite_products.dart';
import 'package:faya_clinic/screens/previous_orders_screen.dart';
import 'package:faya_clinic/screens/profile_screen.dart';
import 'package:faya_clinic/screens/user_addresses.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.18;
    return SectionCornerContainer(
      title: TransUtil.trans("header_account"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // user avatar, name & phone number shadow container
              width: double.infinity,
              height: headerHeight,
              padding: const EdgeInsets.all(marginLarge),
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
                            "User name",
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeLarge,
                            ),
                          ),
                          Text(
                            "phone number",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => ProfileScreen())),
                    child: Icon(
                      Icons.edit,
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: marginLarge,
            ),
            Container(
              // list options group 1
              width: double.infinity,
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
                    title: TransUtil.trans("list_item_my_dates"),
                    leading: Icons.calendar_today_rounded,
                    withDivider: true,
                    onTap: () {},
                  ),
                  _buildListItem(
                    title: TransUtil.trans("list_item_my_addresses"),
                    leading: Icons.location_on,
                    withDivider: true,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => UserAddresses())),
                  ),
                  _buildListItem(
                    title: TransUtil.trans("list_item_fav_products"),
                    leading: Icons.favorite,
                    withDivider: true,
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => FavoriteProductsScreen())),
                  ),
                  _buildListItem(
                    title: TransUtil.trans("list_item_previous_orders"),
                    leading: Icons.shopping_bag_rounded,
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => PreviousOrdersScreen())),
                  ),
                ],
              ),
              // end list options group 1
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TransUtil.trans("header_languages"),
                ),
              ),
            ),
            Container(
              // languages options group
              width: double.infinity,
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
                  ),
                ],
              ),
              // end languages list options
            ),
            SizedBox(
              height: marginLarge,
            ),
            Container(
              // list options group 2
              width: double.infinity,
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
                    onTap: () {},
                  ),
                  _buildListItem(
                    title: TransUtil.trans("list_item_privacy_policy"),
                    leading: Icons.lock,
                    withDivider: true,
                    onTap: () {},
                  ),
                  _buildListItem(
                    title: TransUtil.trans("list_item_terms_conditions"),
                    leading: Icons.note,
                    onTap: () {},
                  ),
                ],
              ),
              // end list options group 2
            ),
            SizedBox(
              height: marginLarge,
            ),
            Container(
              // list options group 3
              width: double.infinity,
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
                    onTap: () {},
                  ),
                ],
              ),
              // end list options group 3
            ),
            SizedBox(
              height: marginLarge,
            ),
          ],
        ),
      ),
    );
  }
}
