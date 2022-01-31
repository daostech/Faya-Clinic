import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/product_details/components/users_reviews.dart';
import 'package:faya_clinic/screens/product_details/product_details_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';

class UsersReviewsScreen extends StatelessWidget {
  const UsersReviewsScreen({Key key, @required this.controller}) : super(key: key);
  final ProductDetailsController controller;

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
                title: TransUtil.trans("header_all_reviews"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: UsersReviewsSection(
              controller: controller,
              global: true,
            ),
          ),
        ],
      ),
    );
  }
}
