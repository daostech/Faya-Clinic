import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/product_review.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReviewItem extends StatelessWidget {
  final ProductReview productReview;
  const ProductReviewItem({Key? key, required this.productReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productReview.user?.userName ?? TransUtil.trans("label_unknown_user"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(MyDateFormatter.toStringDate(productReview.creationDate)),
            ],
          ),
          RatingBar.builder(
            initialRating: productReview.rate?.toDouble() ?? 0.0,
            minRating: 1,
            itemCount: 5,
            direction: Axis.horizontal,
            wrapAlignment: WrapAlignment.start,
            itemSize: 25,
            ignoreGestures: true,
            itemBuilder: (context, _) => Icon(
              Icons.star_rate_rounded,
              color: colorPrimary,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          Text(productReview.text!),
        ],
      ),
    );
  }
}
