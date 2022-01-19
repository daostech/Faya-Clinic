import 'package:badges/badges.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class AppBarSearch extends StatelessWidget {
  final Function onCartTap;
  final Function onNotificationTap;
  const AppBarSearch({Key key, this.onCartTap, this.onNotificationTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.fromLTRB(marginLarge, paddingTop + marginLarge, marginLarge, marginLarge),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: marginLarge,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(radiusStandard),
                  ),
                ),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                      hintText: TransUtil.trans("hint_search_now"),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return null;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(suggestion['name']),
                      subtitle: Text('\$${suggestion['price']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(product: suggestion)));
                  },
                ),
              ),
            ),
            SizedBox(
              width: marginStandard,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onCartTap,
                  child: context.select<CartController, int>((controller) => controller.count) == 0
                      ? Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black87,
                        )
                      : Badge(
                          toAnimate: true,
                          animationType: BadgeAnimationType.scale,
                          animationDuration: Duration(milliseconds: 300),
                          shape: BadgeShape.circle,
                          badgeColor: colorPrimaryLight,
                          borderRadius: BorderRadius.circular(8),
                          badgeContent:
                              Text(context.select<CartController, int>((controller) => controller.count).toString()),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black87,
                          ),
                        ),
                ),
                SizedBox(
                  width: marginStandard,
                ),
                Padding(
                  padding: const EdgeInsets.all(marginSmall),
                  child: InkWell(
                    onTap: onNotificationTap,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
