import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/user_repository.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/screens/checkout/tap_address.dart';
import 'package:faya_clinic/screens/checkout/tap_payment.dart';
import 'package:faya_clinic/screens/checkout/tap_review.dart';
import 'package:faya_clinic/screens/checkout/tap_shipping.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen._({Key key, @required this.controller}) : super(key: key);
  final CheckoutController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final userRepository = Provider.of<UserRepositoryBase>(context, listen: false);
    final addressesRepository = Provider.of<AddressesRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<CheckoutController>(
      create: (_) => CheckoutController(
        database: database,
        userRepository: userRepository,
        addressesRepository: addressesRepository,
      ),
      builder: (ctx, child) {
        return Consumer<CheckoutController>(
          builder: (context, controller, _) => CheckoutScreen._(controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar + tabs container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: "Checkout",
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
                child: Row(
                  children: [
                    _buildTabItem(context, 0, TransUtil.trans("tab_address")),
                    _buildTabItem(context, 1, TransUtil.trans("tab_shipping")),
                    _buildTabItem(context, 2, TransUtil.trans("tab_review")),
                    _buildTabItem(context, 3, TransUtil.trans("tab_payment")),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: currentTab,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index, String title) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => controller.goToTab(index),
      child: Container(
        width: size.width * 0.25,
        padding: const EdgeInsets.all(marginLarge),
        color: controller.isSelectedTab(index) ? Colors.white : colorPrimary,
        child: Center(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: controller.isSelectedTab(index) ? colorPrimary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget get currentTab {
    switch (controller.currentTabIndex) {
      case 0:
        return CheckoutAddressTap(
          controller: controller,
        );
      case 1:
        return CheckoutShippingTap();
      case 2:
        return CheckoutReviewTap();
      case 3:
        return CheckoutPaymentTap();
      default:
        return SizedBox();
    }
  }
}
