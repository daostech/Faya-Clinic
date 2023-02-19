import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_label_top.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentTap extends StatelessWidget {
  CheckoutPaymentTap({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  submitOrder(BuildContext context, CheckoutController controller) {
    controller.placeOrder().then((value) {
      if (value) {
        context.read<CartController>().onOrderCreated();
        DialogUtil.showToastMessage(context, TransUtil.trans("msg_order_created_successfully"));
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutController>();
    final selectedMethod =
        context.select<CheckoutController, PaymentMethod?>((controller) => controller.selectedPaymentMethod);

    return Container(
      padding: const EdgeInsets.all(marginLarge),
      child: Column(
        children: [
          Align(
            // header
            alignment: Alignment.centerLeft,
            child: Text(
              TransUtil.trans("header_shipping_methods"),
              style: TextStyle(
                color: Colors.black87,
                fontSize: fontSizeLarge,
              ),
            ),
          ),
          ListView.separated(
            itemCount: controller.paymentMethods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return RadioListTile<PaymentMethod>(
                value: controller.paymentMethods[index],
                groupValue: selectedMethod,
                title: Text(TransUtil.trans(controller.paymentMethods[index].method)),
                activeColor: colorPrimary,
                contentPadding: const EdgeInsets.all(0),
                selected: controller.isSelectedPayment(index),
                onChanged: (method) => controller.updateWith(paymentMethod: method),
              );
            },
            separatorBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: marginSmall,
                  horizontal: marginStandard,
                ),
                child: Divider(
                  color: Colors.black45,
                  height: 1.0,
                  thickness: 1.0,
                ),
              );
            },
          ),
          buildBankCardSection(context, controller),
          buildButtonsSection(context, controller),
        ],
      ),
    );
  }

  Widget buildButtonsSection(BuildContext context, CheckoutController controller) {
    if (controller.isLaoding)
      return Padding(
        padding: const EdgeInsets.all(marginxLarge),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return InlineButtons(
      positiveText: TransUtil.trans("btn_place_order"),
      negativeText: TransUtil.trans("btn_go_back"),
      onPositiveTap: () {
        if (controller.hasPayment) {
          // if the order has payment check the bank card info
          if (_formKey.currentState!.validate()) {
            submitOrder(context, controller);
          }
        } else {
          submitOrder(context, controller);
        }
      },
      onNegativeTap: () => controller.previousTab(),
    );
  }

  Widget buildBankCardSection(BuildContext context, CheckoutController controller) {
    if (controller.selectedPaymentMethod?.id != "3") return SizedBox();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabeledInput(
            label: TransUtil.trans("label_card_number_required"),
            hintText: "XXXX XXXX XXXX XXXX",
            onChanged: (value) => controller.bankCard.cardNumber = value,
            isRequiredInput: true,
          ),
          Row(
            children: [
              Expanded(
                child: LabeledInput(
                  // isReadOnly: true,
                  isRequiredInput: true,
                  // maxLength: 5,
                  label: TransUtil.trans("label_card_expiry_date_required"),
                  // initialValue: TransUtil.trans("hint_card_expiry_date"),
                  hintText: TransUtil.trans("hint_card_expiry_date"),

                  onChanged: (value) {},
                  // onTap: () async =>
                  // controller.onBankCardExpiryDateSelected(await DialogUtil.showYearMonthPickerDialog(context)),
                ),
              ),
              SizedBox(width: marginStandard),
              Expanded(
                child: LabeledInput(
                  label: TransUtil.trans("label_card_cvv_required"),
                  onChanged: (value) => controller.bankCard.expiryMonth = value,
                  isRequiredInput: true,
                  isObscureText: true,
                  hintText: "CVV",
                ),
              ),
            ],
          ),
          LabeledInput(
            label: TransUtil.trans("label_card_holder_name_required"),
            hintText: TransUtil.trans("hint_card_holder_name"),
            onChanged: (value) => controller.bankCard.cardNumber = value,
            isRequiredInput: true,
          ),
        ],
      ),
    );
  }
}
