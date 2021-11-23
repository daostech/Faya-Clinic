import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/favorite_products.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<FavoriteProductsProvider>();
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
              itemCount: _controller.favoriteProducts.length,
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: marginSmall,
                mainAxisSpacing: marginSmall,
              ),
              itemBuilder: (ctx, index) {
                final currentProduct = _controller.favoriteProducts[index];
                return ProductItem(
                  product: currentProduct,
                  isFavorite: _controller.isFavoriteProduct(currentProduct),
                  onFavoriteToggle: (product) => _controller.toggleFavorite(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
