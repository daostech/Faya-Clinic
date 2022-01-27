import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProductReviewsWidget extends StatelessWidget {
  const ProductReviewsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barWidth = MediaQuery.of(context).size.width * 0.6;
    return Container(
      height: 220,
      child: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    TransUtil.trans(
                      "header_reviews_and_comments",
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeLarge,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 50,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    wrapAlignment: WrapAlignment.start,
                    onRatingUpdate: (_) {},
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rate_rounded,
                      color: colorPrimary,
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "3.0"),
                    WidgetSpan(
                        child: SizedBox(
                      width: marginSmall,
                    )),
                    TextSpan(text: "of"),
                    WidgetSpan(
                        child: SizedBox(
                      width: marginSmall,
                    )),
                    TextSpan(text: "5.0"),
                    WidgetSpan(
                        child: SizedBox(
                      width: marginSmall,
                    )),
                    TextSpan(text: "250 reviews"),
                  ])),
                ],
              ),
            ),
            SizedBox(
              height: marginxLarge,
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  buildReviewBar(barWidth, 0.1, "5 Stars", "43"),
                  buildReviewBar(barWidth, 0.7, "4 Stars", "43"),
                  buildReviewBar(barWidth, 0.5, "3 Stars", "43"),
                  buildReviewBar(barWidth, 0.2, "2 Stars", "43"),
                  buildReviewBar(barWidth, 0.3, "1 Stars", "43"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviewBar(double width, double percent, String prefix, String postfix) {
    return Container(
      margin: const EdgeInsets.only(bottom: marginSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            child: Text(prefix),
          ),
          Expanded(
            child: LinearPercentIndicator(
              // width: width,
              lineHeight: 14.0,
              percent: percent,
              backgroundColor: colorPrimaryLight,
              progressColor: colorPrimary,
            ),
          ),
          Container(
            width: 30,
            child: Text(postfix),
          ),
        ],
      ),
    );
  }
}
