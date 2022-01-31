import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/product_details/product_details_controller.dart';
import 'package:faya_clinic/screens/product_details/users_reviews_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_product_review.dart';
import 'package:flutter/material.dart';

class UsersReviewsSection extends StatelessWidget {
  const UsersReviewsSection({Key key, @required this.controller, this.global = false}) : super(key: key);
  final ProductDetailsController controller;
  final bool global;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    if (controller.topReviews == null) {
      if (controller.isLoading) {
        return Container(height: 220, child: Center(child: CircularProgressIndicator()));
      }
      return MyErrorWidget(onTap: () => controller.fetchProductReviews());
    }
    if (controller.topReviews.isEmpty) {
      return Container(
        height: 220,
        child: Center(
          child: Wrap(
            children: [
              Text(
                TransUtil.trans("msg_no_reviews_for_product"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      child: Center(
        child: global ? allReviewsList() : topReviewsList(context),
      ),
    );
  }

  Widget allReviewsList() {
    return ListView.separated(
      itemCount: controller.allReviews.length,
      itemBuilder: (ctx, index) {
        return ProductReviewItem(
          productReview: controller.allReviews[index],
        );
      },
      separatorBuilder: (ctx, index) {
        return Divider(
          thickness: 1.0,
          color: colorGreyDark,
        );
      },
    );
  }

  Widget topReviewsList(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          itemCount: controller.topReviews.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return ProductReviewItem(
              productReview: controller.allReviews[index],
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider(
              thickness: 1.0,
              color: colorGreyDark,
            );
          },
        ),
        SizedBox(
          height: marginLarge,
        ),
        Container(
          margin: const EdgeInsets.all(marginLarge),
          child: TextButton(
            child: Text(TransUtil.trans("btn_show_all_reviews")),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => UsersReviewsScreen(controller: controller))),
          ),
        ),
      ],
    );
  }
}
