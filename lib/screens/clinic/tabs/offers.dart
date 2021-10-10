import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/widgets/item_offer.dart';
import 'package:flutter/material.dart';

class ClinicOffersTab extends StatelessWidget {
  const ClinicOffersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (2 / 2),
          crossAxisCount: 1,
          mainAxisSpacing: marginLarge,
        ),
        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return OfferItem();
        },
      ),
    );
  }
}
