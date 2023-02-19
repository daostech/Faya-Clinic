import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/screens/checkout/tap_address.dart';
import 'package:faya_clinic/screens/checkout/tap_payment.dart';
import 'package:faya_clinic/screens/checkout/tap_review.dart';
import 'package:faya_clinic/screens/checkout/tap_shipping.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen._({Key? key, required this.controller}) : super(key: key);
  final CheckoutController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    // final userRepository = Provider.of<UserRepositoryBase>(context, listen: false);
    final addressesRepository = Provider.of<AddressesRepositoryBase>(context, listen: false);
    final authRepository = Provider.of<AuthRepositoryBase>(context, listen: false);
    final cartController = Provider.of<CartController>(context, listen: false);

    final coupon = cartController.appliedCoupon;
    final orderItems = cartController.allItems;
    return ChangeNotifierProvider<CheckoutController>(
      create: (_) => CheckoutController(
        database: database,
        authRepository: authRepository,
        addressesRepository: addressesRepository,
        appliedCoupon: coupon,
        orderItems: orderItems,
      ),
      builder: (ctx, child) {
        return Consumer<CheckoutController>(
          builder: (context, controller, _) => CheckoutScreen._(controller: controller),
        );
      },
    );
  }

  handleError(context, controller) {
    DialogUtil.showAlertDialog(context, controller.error, null);
    controller.onErrorHandled();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(builder: (context, controller, _) {
      if (controller.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("addPostFrameCallback called");
          handleError(context, controller);
        });
      }
      return Scaffold(
        body: Column(
          children: [
            Column(
              // app bar + tabs container
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBarStandard(
                  title: TransUtil.trans("header_checkout"),
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
    });
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
