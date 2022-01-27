import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReviewItem extends StatelessWidget {
  const ProductReviewItem({Key key}) : super(key: key);

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
                  "Good Product !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("12 minutes ago"),
            ],
          ),
          RatingBar.builder(
            initialRating: 3,
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
          Text(LOREM_IPSUM),
        ],
      ),
    );
  }
}
