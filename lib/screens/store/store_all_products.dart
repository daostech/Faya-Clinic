import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/product_details/product_details_screen.dart';
import 'package:faya_clinic/screens/store/store_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/expanded_product_filter.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreAllProductsBottomSheet extends StatelessWidget {
  // const StoreAllProductsBottomSheet({Key key, @required this.controller}) : super(key: key);
  // final StoreController controller;

  void _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => widget));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = context.watch<StoreController>();
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: SectionCornerContainer(
        title: TransUtil.trans("header_all_products"),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductExpandedFilter(
                controller: controller,
              ),
              SizedBox(
                height: marginStandard,
              ),
              _buildAllProductsSection(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllProductsSection(BuildContext context, StoreController controller) {
    return Column(
      children: [
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
            child: _allProductsGrid(context, controller)),
      ],
    );
  }

  Widget _allProductsGrid(BuildContext context, StoreController controller) {
    if (controller.allProducts == null || controller.allProducts!.isEmpty) {
      if (controller.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );

      return MyErrorWidget(
        error: TransUtil.trans("error_loading_data"),
        onTap: controller.fetchAllProducts,
      );
    }
    if (controller.filteredProductsList!.isEmpty) {
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
    return Column(
      children: [
        GridView.builder(
          itemCount: controller.filteredProductsList!.length,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: marginSmall,
            mainAxisSpacing: marginSmall,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return ProductItem(
              product: controller.filteredProductsList![index],
              isFavorite: controller.isFavoriteProduct(controller.filteredProductsList![index]),
              onFavoriteToggle: (product) => controller.toggleFavorite(product),
              onTap: () => _goTo(
                context,
                ProductDetailsScreen.create(context, controller.filteredProductsList![index]),
              ),
            );
          },
        ),
        SizedBox(
          height: marginLarge,
        ),
      ],
    );
  }
}
