import 'dart:async';

import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutAddressTap extends StatefulWidget {
  final CheckoutController? controller;
  CheckoutAddressTap({Key? key, this.controller}) : super(key: key);

  @override
  State<CheckoutAddressTap> createState() => _CheckoutAddressTapState();
}

class _CheckoutAddressTapState extends State<CheckoutAddressTap> {
  final _addressFormKey = GlobalKey<FormState>();

  final _countryTxtController = TextEditingController();
  final _cityTxtController = TextEditingController();
  final _apartmantTxtController = TextEditingController();
  final _blockTxtController = TextEditingController();
  final _streetTxtController = TextEditingController();
  final _zipTxtController = TextEditingController();

  Address address = Address();
  CheckoutController? get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    if (controller!.selectedAddress != null) {
      // initialize all inputs when navigating back to this tab
      _countryTxtController.text = controller!.selectedAddress!.country!;
      _cityTxtController.text = controller!.selectedAddress!.city!;
      _apartmantTxtController.text = controller!.selectedAddress!.apartment!;
      _blockTxtController.text = controller!.selectedAddress!.block!;
      _streetTxtController.text = controller!.selectedAddress!.street!;
      _zipTxtController.text = controller!.selectedAddress!.zipCode?.toString() ?? "";
    }
  }

  @override
  void dispose() {
    _countryTxtController.dispose();
    _cityTxtController.dispose();
    _apartmantTxtController.dispose();
    _blockTxtController.dispose();
    _streetTxtController.dispose();
    _zipTxtController.dispose();
    super.dispose();
  }

  void saveAddress(BuildContext context, CheckoutController? controller) {
    if (!_addressFormKey.currentState!.validate()) return;
    final saved = controller!.saveAddress(address);
    if (saved)
      DialogUtil.showToastMessage(context, TransUtil.trans("msg_saved_address"));
    else
      DialogUtil.showToastMessage(context, TransUtil.trans("msg_already_saved_address"));
  }

  void pickAddress(BuildContext context, CheckoutController controller) async {
    final Address? result = await (DialogUtil.showBottomSheet(
      context,
      Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SectionCornerContainer(
          title: TransUtil.trans("header_saved_addresses"),
          child: controller.savedAddresses!.isEmpty
              ? Center(
                  child: Text(TransUtil.trans("msg_no_saved_addresses")),
                )
              : ListView.builder(
                  itemCount: controller.savedAddresses!.length,
                  itemBuilder: (ctx, index) {
                    final items = controller.savedAddresses!;
                    return ListTile(
                      title: Text(items[index].label ?? ""),
                      subtitle: Text(items[index].formatted),
                      onTap: () => Navigator.of(context).pop(items[index]),
                    );
                  },
                ),
        ),
      ),
    ) as FutureOr<Address?>);
    if (result == null) return;
    setState(() {
      _countryTxtController.text = result.country!;
      _cityTxtController.text = result.city!;
      _apartmantTxtController.text = result.apartment!;
      _blockTxtController.text = result.block!;
      _streetTxtController.text = result.street!;
      _zipTxtController.text = result.zipCode?.toString() ?? "";
      controller.onAddressSelect(result);
    });
  }

  void nextStep() {
    if (_addressFormKey.currentState!.validate()) {
      controller!.onAddressSelect(address);
      controller!.nextTab();
    } else {
      DialogUtil.showToastMessage(context, TransUtil.trans("msg_please_complete_this_step"));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = context.read<CheckoutController>();
    final authRepo = context.read<AuthRepositoryBase>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                StandardInput(
                  isReadOnly: true,
                  initialValue: authRepo.myUser!.userName ?? "",
                  onChanged: (_) {},
                ),
                // StandardInput(
                //   isReadOnly: true,
                //   initialValue: "Daoud",
                //   onChanged: (_) {},
                // ),
                StandardInput(
                  isReadOnly: true,
                  initialValue: authRepo.myUser!.phoneNumber ?? "",
                  onChanged: (_) {},
                ),
                StandardInput(
                  isReadOnly: authRepo.myUser!.email != null,
                  initialValue: authRepo.myUser!.email ?? "",
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(marginLarge),
            child: InlineButtons(
              positiveText: TransUtil.trans("btn_select_address"),
              negativeText: TransUtil.trans("btn_save_address"),
              sameColor: colorGrey,
              onPositiveTap: () => pickAddress(context, controller!),
              onNegativeTap: () => saveAddress(context, controller),
            ),
          ),
          Form(
            key: _addressFormKey,
            child: Column(
              children: [
                StandardInput(
                  controller: _countryTxtController,
                  isRequiredInput: true,
                  hintText: TransUtil.trans("hint_country"),
                  onChanged: (val) => address.country = val,
                ),
                StandardInput(
                  controller: _cityTxtController,
                  isRequiredInput: true,
                  hintText: TransUtil.trans("hint_city"),
                  onChanged: (val) => address.city = val,
                ),
                StandardInput(
                  controller: _apartmantTxtController,
                  isRequiredInput: true,
                  hintText: TransUtil.trans("hint_apartmant"),
                  onChanged: (val) => address.apartment = val,
                ),
                StandardInput(
                  controller: _blockTxtController,
                  isRequiredInput: true,
                  hintText: TransUtil.trans("hint_block"),
                  onChanged: (val) => address.block = val,
                ),
                StandardInput(
                  controller: _streetTxtController,
                  isRequiredInput: true,
                  hintText: TransUtil.trans("hint_street_name"),
                  onChanged: (val) => address.street = val,
                ),
                StandardInput(
                  controller: _zipTxtController,
                  hintText: TransUtil.trans("hint_zip_code"),
                  onChanged: (val) => address.zipCode = int.tryParse(val),
                ),
              ],
            ),
          ),
          StandardButton(
            onTap: nextStep,
            radius: radiusStandard,
            text: TransUtil.trans("btn_continue"),
          ),
          SizedBox(
            height: marginLarge,
          ),
        ],
      ),
    );
  }
}
