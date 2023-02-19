import 'package:badges/badges.dart';
import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/providers/notifications_controller.dart';
import 'package:faya_clinic/providers/search_controller.dart';
import 'package:faya_clinic/screens/clinic/clinic_offers_details.dart';
import 'package:faya_clinic/screens/clinic/clinic_sub_sections.dart';
import 'package:faya_clinic/screens/product_details/product_details_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class AppBarSearch extends StatelessWidget {
  final Function? onCartTap;
  final Function? onNotificationTap;
  const AppBarSearch({Key? key, this.onCartTap, this.onNotificationTap}) : super(key: key);

  _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => widget));
  }

  _handleOnTap(BuildContext context, ListAble item) {
    // todo check the item type and open its details
    if (item is Product) {
      _goTo(context, ProductDetailsScreen.create(context, item));
    }
    if (item is Section) {
      _goTo(context, ClinicSubSectionsScreen(sectionId: item.id));
    }
    if (item is Offer) {
      _goTo(context, ClinicOfferDetailsScreen(offer: item));
    }
  }

  Widget _itemTrailingIcon(ListAble item) {
    if (item is Product) {
      return Icon(Icons.shopping_cart);
    }
    if (item is Section) {
      return Icon(Icons.medical_services_outlined);
    }
    if (item is Offer) {
      return Icon(Icons.local_offer_rounded);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final controller = context.watch<SearchController>();
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
                child: TypeAheadField<ListAble>(
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
                  // hideOnEmpty: true,
                  suggestionsCallback: (pattern) async {
                    print("AppBarSearch suggestionsCallback called");
                    return await controller.onSearch(pattern);
                  },
                  loadingBuilder: (context) {
                    print("AppBarSearch loadingBuilder called");
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                        // color: colorPrimary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusStandard),
                          bottomRight: Radius.circular(radiusStandard),
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) {
                    print("AppBarSearch noItemsFoundBuilder called");
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                        // color: colorPrimary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusStandard),
                          bottomRight: Radius.circular(radiusStandard),
                        ),
                      ),
                      child: Center(
                        child: Text(TransUtil.trans("msg_no_items_found")),
                      ),
                    );
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorGreyDark,
                        // radius: 500,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(500)),
                            child: NetworkCachedImage(
                              imageUrl: suggestion.imageUrl,
                            ),
                          ),
                        ),
                      ),
                      title: Text(suggestion.titleValue!),
                      trailing: _itemTrailingIcon(suggestion),
                    );
                  },
                  onSuggestionSelected: (item) => _handleOnTap(context, item),
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
                  onTap: onCartTap as void Function()?,
                  child: Badge(
                    toAnimate: true,
                    animationType: BadgeAnimationType.scale,
                    animationDuration: Duration(milliseconds: 300),
                    shape: BadgeShape.circle,
                    badgeColor: colorPrimaryLight,
                    borderRadius: BorderRadius.circular(8),
                    showBadge: context.select<CartController, int>((controller) => controller.count) > 0,
                    badgeContent:
                        Text(context.select<CartController, int>((controller) => controller.count).toString()),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  width: marginLarge,
                ),
                InkWell(
                  onTap: onNotificationTap as void Function()?,
                  child: Badge(
                    toAnimate: true,
                    animationType: BadgeAnimationType.scale,
                    animationDuration: Duration(milliseconds: 300),
                    shape: BadgeShape.circle,
                    badgeColor: colorPrimaryLight,
                    borderRadius: BorderRadius.circular(8),
                    showBadge: context
                            .select<NotificationsController, int>((controller) => controller.unReadNotificationsCount) >
                        0,
                    badgeContent: Text(context
                        .select<NotificationsController, int>((controller) => controller.unReadNotificationsCount)
                        .toString()),
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
