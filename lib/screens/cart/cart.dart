import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/screens/checkout/checkout_screen.dart';
import 'package:faya_clinic/screens/product_details/product_details_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/item_product_cart.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key key}) : super(key: key);

  void _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => widget));
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CartController>();
    final size = MediaQuery.of(context).size;

    return SectionCornerContainer(
      title: TransUtil.trans("header_cart"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildListView(controller, size.height * 0.3),
            _buildCoupunInput(controller),
            _buildCartDetails(controller),
            if (!controller.isCartEmpty)
              StandardButton(
                radius: radiusStandard,
                text: TransUtil.trans("btn_checkout"),
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CheckoutScreen.create(context))),
              ),
            SizedBox(
              height: marginLarge,
            ),
            _buildSuggestedProducts(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(double height) {
    return Container(
      height: height,
      child: Center(
        child: Text(TransUtil.trans("msg_cart_is_empty")),
      ),
    );
  }

  Widget _buildListView(CartController controller, double height) {
    if (controller.isCartEmpty) return _buildEmptyCart(height);
    return Column(
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
                child: Text(TransUtil.trans("label_total") + " " + controller.count.toString()),
              ),
              TextButton(
                onPressed: controller.clearCart,
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
        Container(
          height: height,
          margin: const EdgeInsets.only(top: marginStandard),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: marginLarge),
            itemCount: controller.count,
            itemBuilder: (ctx, index) {
              final currentItem = controller.allItems[index];
              return CartProductItem(
                orderItem: currentItem,
                addQTY: () => controller.addQTY(currentItem.id),
                removeQTY: () => controller.removeQTY(currentItem.id),
                deleteFromCart: () => controller.deleteItem(currentItem.id),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCoupunInput(CartController controller) {
    if (controller.isCartEmpty) return SizedBox();
    return Container(
      // coupon input container
      padding: const EdgeInsets.symmetric(
        horizontal: marginLarge,
      ),
      margin: const EdgeInsets.symmetric(vertical: marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // input + error container
        children: [
          Row(
            // coupon input container
            children: [
              Expanded(
                child: StandardInput(
                  controller: controller.coupunTxtController,
                  hintText: TransUtil.trans("hint_enter_your_coupon"),
                  isReadOnly: controller.hasCoupun,
                  initialValue: controller.hasCoupun ? controller.appliedCoupon?.title : null,
                  onChanged: (_) {},
                ),
              ),
              SizedBox(
                width: marginLarge,
              ),
              StandardButton(
                text: controller.hasCoupun ? TransUtil.trans("btn_delete") : TransUtil.trans("btn_search"),
                topRightRadius: radiusStandard,
                bottomRightRadius: radiusStandard,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () => controller.hasCoupun ? controller.deleteCuopon() : controller.checkCuopon(),
              ),
            ],
          ),
          if (controller.appliedCoupon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: TransUtil.trans("label_applied_coupon"),
                      style: TextStyle(color: colorGreenSuccess),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: marginSmall,
                    )),
                    WidgetSpan(
                      child: SizedBox(
                        width: marginSmall,
                      ),
                    ),
                    TextSpan(
                      text: controller.appliedCoupon?.title ?? "N/A",
                      style: TextStyle(color: colorGreenSuccess),
                    ),
                  ],
                ),
              ),
            ),
          if (controller.hasError)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Text(
                TransUtil.trans(controller.error),
                style: TextStyle(color: colorRedError),
              ),
            ),
          if (controller.isLoading)
            Container(
              height: 70,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCartDetails(CartController controller) {
    if (controller.isCartEmpty) return SizedBox();
    return Container(
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
                Text("x${controller.count}"),
              ],
            ),
          ),
          if (controller.hasCoupun)
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: marginStandard,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      TransUtil.trans("label_coupon_discount"),
                    ),
                  ),
                  // todo check whether the coupon is an amount or percentage
                  Text(
                      "${AppConfig.PREFFERED_QURRENCY_UNIT}${controller.appliedCoupon.discountValue.toString() ?? "${0.0.toString()}"}"),
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
                Text("${AppConfig.PREFFERED_QURRENCY_UNIT}${controller.totalPrice}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedProducts(BuildContext context, CartController controller) {
    final isRTL = TransUtil.isArLocale(context);
    return Builder(builder: (context) {
      if (controller.suggestedProducts.isEmpty) {
        return SizedBox();
      }
      return Column(
        children: [
          Align(
            // last product header
            alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
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
            child: _buildProductsList(controller),
          ),
        ],
      );
    });
  }

  Widget _buildProductsList(CartController controller) {
    return Container(
      height: 220,
      child: Builder(builder: (context) {
        if (controller.suggestedProducts.isEmpty) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Text(TransUtil.trans("text"));
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.suggestedProducts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            final products = controller.suggestedProducts;
            return ProductItem(
              product: products[index],
              isFavorite: controller.isFavoriteProduct(products[index]),
              onFavoriteToggle: (product) => controller.toggleFavorite(product),
              onTap: () => _goTo(
                context,
                ProductDetailsScreen.create(context, products[index]),
              ),
            );
          },
        );
      }),
    );
  }
}
