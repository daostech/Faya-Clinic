import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key key, @required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AddAddressScreen())),
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.black87,
      //   ),
      // ),
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_previous_orders"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Column(
                children: [
                  SizedBox(
                    height: marginxLarge,
                  ),
                  buildProductImage(size),
                  buildProductInfo(context, product),
                  divider(),
                  buildReviewSection(),
                  divider(),
                  buildCommentsSection(),
                  divider(),
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
      child: FittedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          child: NetworkCachedImage(
            imageUrl: product.randomImage,
          ),
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
                  product?.name ?? "DOLCE & GABANA",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  // "VELET DESERT OUT",
                  product?.description ?? "VELET DESERT OUT",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                // Text(
                //   "Spray 100 ml",
                //   style: Theme.of(context).textTheme.subtitle1,
                // ),
              ],
            ),
          ),
          Text(
            // "\$325",
            "\$${product?.price?.toString()}",
            style: Theme.of(context).textTheme.headline4.copyWith(color: colorPrimary),
          ),
        ],
      ),
    );
  }

  Widget buildReviewSection() {
    return Container(
      height: 220,
      child: Center(
        child: Text("Review Section"),
      ),
    );
  }

  Widget buildCommentsSection() {
    return Container(
      height: 220,
      child: Center(
        child: Text("Comment Section"),
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
