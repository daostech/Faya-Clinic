import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/screens/favorite_products/favorite_products_controller.dart';
import 'package:faya_clinic/screens/product_details/product_details_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen._({Key key, @required this.controller}) : super(key: key);
  final FavoriteProductsController controller;

  static Widget create(BuildContext context) {
    final favoriteRepo = Provider.of<FavoriteRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<FavoriteProductsController>(
      create: (_) => FavoriteProductsController(favoriteRepository: favoriteRepo),
      builder: (ctx, child) {
        return Consumer<FavoriteProductsController>(
          builder: (context, controller, _) => FavoriteProductsScreen._(controller: controller),
        );
      },
    );
  }

  void _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_favorite_products"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              itemCount: controller.favoriteProducts.length,
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: marginSmall,
                mainAxisSpacing: marginSmall,
              ),
              itemBuilder: (ctx, index) {
                final currentProduct = controller.favoriteProducts[index];
                return ProductItem(
                  product: currentProduct,
                  isFavorite: controller.isFavoriteProduct(currentProduct),
                  onFavoriteToggle: (product) => controller.toggleFavorite(product),
                  onTap: () => _goTo(
                    context,
                    ProductDetailsScreen.create(context, currentProduct),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
