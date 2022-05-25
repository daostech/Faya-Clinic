import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/screens/product_details/product_details_screen.dart';
import 'package:faya_clinic/screens/store/store_all_products.dart';
import 'package:faya_clinic/screens/store/store_controller.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen._({Key key, @required this.controller}) : super(key: key);
  final StoreController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final favoriteRepo = Provider.of<FavoriteRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<StoreController>(
      create: (_) => StoreController(database: database, favoriteRepository: favoriteRepo),
      builder: (ctx, child) {
        return Consumer<StoreController>(
          builder: (context, controller, _) => StoreScreen._(controller: controller),
        );
      },
    );
  }

  void _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => widget));
  }

  void _showBottomSheet(BuildContext context) {
    DialogUtil.showBottomSheet(
        context,
        ChangeNotifierProvider.value(
          value: controller,
          child: StoreAllProductsBottomSheet(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_store"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ProductExpandedFilter(
            //   controller: controller,
            // ),
            SizedBox(
              height: marginStandard,
            ),
            _buildNewArrivalsSection(context),
            _buildAllProductsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNewArrivalsSection(context) {
    print("_buildNewArrivals called");
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  TransUtil.trans("header_new_arrivals"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
                onPressed: () => _showBottomSheet(context),
              ),
            ],
          ),
        ),
        Container(
          // new arraivales horizontal list container
          height: 220,
          child: _newArrivalsList(context),
        ),
      ],
    );
  }

  Widget _newArrivalsList(context) {
    if (controller.newArrivals == null) {
      if (controller.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );

      return MyErrorWidget(
        error: TransUtil.trans("error_loading_data"),
        onTap: controller.fetchNewArrivalsProducts,
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.newArrivals.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        print("index: $index");
        return ProductItem(
          product: controller.newArrivals[index],
          isFavorite: controller.isFavoriteProduct(controller.newArrivals[index]),
          onFavoriteToggle: (product) => controller.toggleFavorite(product),
          onTap: () => _goTo(
            context,
            ProductDetailsScreen.create(context, controller.newArrivals[index]),
          ),
        );
      },
    );
  }

  Widget _buildAllProductsSection(context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginStandard),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  TransUtil.trans("header_all_products"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
                onPressed: () => _showBottomSheet(context),
              ),
            ],
          ),
        ),
        Container(
          // all products grid view container
          child: _allProductsGrid(controller.filteredProductsList, context),
        ),
      ],
    );
  }

  Widget _allProductsGrid(List filteredItems, context) {
    if (controller.allProducts == null || controller.allProducts.isEmpty) {
      if (controller.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );

      return MyErrorWidget(
        error: TransUtil.trans("error_loading_data"),
        onTap: controller.fetchAllProducts,
      );
    }
    if (filteredItems.isEmpty) {
      return Container(
        height: 150,
        padding: const EdgeInsets.all(marginLarge),
        child: Center(
          child: Text(
            TransUtil.trans("msg_no_items_for_selected_category"),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final width = MediaQuery.of(context).size.width;
    final crossAxisCt = width ~/ (150 + (marginSmall * 2));
    return Column(
      children: [
        GridView.builder(
          // itemCount: 30,
          itemCount: filteredItems.length,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCt,
            crossAxisSpacing: marginSmall,
            mainAxisSpacing: marginSmall,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return ProductItem(
                product: filteredItems[index],
                isFavorite: controller.isFavoriteProduct(filteredItems[index]),
                onFavoriteToggle: (product) => controller.toggleFavorite(product),
                onTap: () => _goTo(
                      context,
                      ProductDetailsScreen.create(context, filteredItems[index]),
                    ));
          },
        ),
        SizedBox(
          height: marginLarge,
        ),
      ],
    );
  }
}
