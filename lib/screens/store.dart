import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/providers/favorite_products.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/expanded_product_filter.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _favController = context.watch<FavoriteProductsProvider>();
    return SectionCornerContainer(
      title: TransUtil.trans("header_store"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProductExpandedFilter(),
            SizedBox(
              height: marginStandard,
            ),
            Align(
              // last offers header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
                child: Text(
                  TransUtil.trans("header_new_arrivals"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                  ),
                ),
              ),
            ),
            Container(
              // new arraivales horizontal list container
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: DummyData.latestProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final products = DummyData.latestProducts;
                  return ProductItem(
                    product: products[index],
                    isFavorite: _favController.isFavoriteProduct(products[index]),
                    onFavoriteToggle: (product) => _favController.toggleFavorite(product),
                  );
                },
              ),
            ),
            Align(
              // last offers header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
                child: Text(
                  TransUtil.trans("header_all_products"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                  ),
                ),
              ),
            ),
            Container(
              // all products grid view container
              // height: 175,
              child: GridView.builder(
                itemCount: DummyData.latestProducts.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: marginSmall,
                  mainAxisSpacing: marginSmall,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final products = DummyData.latestProducts;
                  return ProductItem(
                    product: products[index],
                    isFavorite: _favController.isFavoriteProduct(products[index]),
                    onFavoriteToggle: (product) => _favController.toggleFavorite(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
