import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/screens/clinic/clinic_offers_details.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_offer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicOffersTab extends StatelessWidget {
  const ClinicOffersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClinicController>();
    return Container(
      child: _buildContent(context, controller),
    );
  }

  Widget _buildContent(BuildContext context, ClinicController controller) {
    if (controller.offersList == null) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
          child: MyErrorWidget(
        onTap: controller.fetchOffers,
      ));
    } else if (controller.offersList.isEmpty) {
      return Center(
        child: Text(TransUtil.trans("msg_no_data_for_this_section")),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (2 / 2),
        crossAxisCount: 1,
        mainAxisSpacing: marginLarge,
      ),
      padding: const EdgeInsets.symmetric(horizontal: marginLarge),
      itemCount: controller.offersList.length,
      itemBuilder: (ctx, index) {
        return OfferItem(
          offer: controller.offersList[index],
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => ClinicOfferDetailsScreen(
                    offer: controller.offersList[index],
                  ))),
        );
      },
    );
  }
}
