import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/screens/checkout/checkout_screen.dart';
import 'package:faya_clinic/screens/product_details_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/item_product_cart.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CheckoutScreen())),
              ),
            SizedBox(
              height: marginLarge,
            ),
            _buildOtherProducts(context),
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
                child: Text("label_total" + " " + "1"),
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
                remoceQTY: () => controller.removeQTY(currentItem.id),
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
                Text("\$${controller.cartPrice}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProducts(BuildContext context) {
    return Column(
      children: [
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
            itemCount: DummyData.latestProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final products = DummyData.latestProducts;
              return ProductItem(
                product: products[index],
                // isFavorite: _favController.isFavoriteProduct(products[index]),
                // onFavoriteToggle: (product) => _favController.toggleFavorite(product),
                onTap: () => _goTo(
                  context,
                  ProductDetailsScreen(
                    product: products[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
