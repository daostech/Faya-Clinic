import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/product_details/components/add_review_widget.dart';
import 'package:faya_clinic/screens/product_details/components/product_reviews.dart';
import 'package:faya_clinic/screens/product_details/components/users_reviews.dart';
import 'package:faya_clinic/screens/product_details/product_details_controller.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen._({Key key, this.controller}) : super(key: key);

  final ProductDetailsController controller;

  static Widget create(BuildContext context, Product product) {
    final database = Provider.of<Database>(context, listen: false);
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<ProductDetailsController>(
      create: (_) => ProductDetailsController(database: database, product: product, authRepository: authRepo),
      builder: (ctx, child) {
        return Consumer<ProductDetailsController>(
          builder: (context, controller, _) => ProductDetailsScreen._(
            controller: controller,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_product_details"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(marginLarge),
              child: Column(
                children: [
                  SizedBox(
                    height: marginxLarge,
                  ),
                  buildProductImage(size),
                  buildProductInfo(context, controller.product),
                  divider(),
                  ProductReviewsWidget(),
                  divider(),
                  UsersReviewsSection(controller: controller),
                  divider(),
                  AddProductReviewWidget(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductImage(size) {
    return Container(
      // product image container
      width: size.width * 0.5,
      height: size.width * 0.5,

      decoration: BoxDecoration(
        color: colorGreyLight,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        child: NetworkCachedImage(
          imageUrl: controller.product.randomImage,
        ),
      ),
    );
  }

  Widget buildProductInfo(context, Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: marginLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "DOLCE & GABANA",
                  product?.name ?? "",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  // "VELET DESERT OUT",
                  product?.description ?? "",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Text(
            // "\$325",
            "${AppConfig.PREFFERED_QURRENCY_UNIT}${product?.price?.toString()}",
            style: Theme.of(context).textTheme.headline4.copyWith(color: colorPrimary),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1.5,
      color: colorGrey,
    );
  }
}
