import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/item_product_cart.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SectionCornerContainer(
      title: TransUtil.trans("header_cart"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                // vertical: marginSmall / 2,
                horizontal: marginLarge,
              ),
              color: colorGrey,
              child: Row(
                // total products quantity and clear cart button container
                children: [
                  Expanded(
                    child: Text("label_total" + " " + "1"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      TransUtil.trans("btn_clear_cart"),
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: marginStandard,
            ),
            Container(
              //products list view
              height: size.height * 0.3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                itemCount: 5,
                itemBuilder: (ctx, index) {
                  return CartProductItem(
                    onTap: () {},
                  );
                },
              ),
            ),
            SizedBox(
              height: marginStandard,
            ),
            Padding(
              // coupon input container
              padding: const EdgeInsets.symmetric(
                horizontal: marginLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(),
                  ),
                  SizedBox(
                    width: marginLarge,
                  ),
                  StandardButton(
                    text: TransUtil.trans("btn_buy"),
                    topRightRadius: radiusStandard,
                    bottomRightRadius: radiusStandard,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: marginSmall,
            ),
            Container(
              padding: const EdgeInsets.all(marginStandard),
              margin: const EdgeInsets.all(marginLarge),
              color: colorGrey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: marginStandard,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            TransUtil.trans("label_products"),
                          ),
                        ),
                        Text("x2"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: marginStandard,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            TransUtil.trans("label_total"),
                          ),
                        ),
                        Text("\$3,200"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StandardButton(
              onTap: () {},
              radius: radiusStandard,
              text: TransUtil.trans("btn_checkout"),
            ),
            SizedBox(
              height: marginLarge,
            ),
            Align(
              // last product header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                child: Text(
                  TransUtil.trans("header_other_products"),
                ),
              ),
            ),
            Container(
              // last products horizontal list container
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return ProductItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
