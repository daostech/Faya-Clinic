import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/product_details/product_details_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddProductReviewWidget extends StatelessWidget {
  const AddProductReviewWidget({Key key, @required this.controller}) : super(key: key);
  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(marginLarge),
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
        child: Column(
          children: [
            Text(
              TransUtil.trans("header_write_your_review"),
            ),
            SizedBox(height: marginLarge),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              itemCount: 5,
              direction: Axis.horizontal,
              wrapAlignment: WrapAlignment.start,
              itemBuilder: (context, _) => Icon(
                Icons.star_rate_rounded,
                color: colorPrimary,
              ),
              onRatingUpdate: (rating) => controller.initialRate = rating.toInt(),
            ),
            SizedBox(height: marginLarge),
            Container(
              // commecnt input
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: marginSmall),
              padding: const EdgeInsets.all(marginStandard),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusStandard),
                ),
                border: Border.all(color: colorGreyDark, width: 0.5),
              ),
              child: TextFormField(
                controller: controller.reviewTxtController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: TransUtil.trans("hint_write_your_review"),
                ),
                onChanged: (val) => controller.updateWith(review: val),
              ),
            ),
            SizedBox(height: marginLarge),
            Container(
              child: controller.postingReview
                  ? CircularProgressIndicator()
                  : StandardButton(
                      radius: radiusStandard,
                      text: TransUtil.trans("btn_publish"),
                      onTap: controller.reviewTxtController.text.length < 10
                          ? null
                          : () {
                              controller.postReview();
                            },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
