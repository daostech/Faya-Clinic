import 'dart:async';

import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final AuthController controller;
  const SignUpScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const TAG = "SignUpScreen: ";
  final _key = GlobalKey<FormState>();
  final phoneTxtController = TextEditingController();
  // final dateFormat = new DateFormat('yyyy-MM-dd');

  AuthController get controller => widget.controller;

  DateTime? selectedDate;
  var _name = "";
  var _phone = "";
  var _birthdayString = "";
  var _email = "";

  @override
  void initState() {
    super.initState();
    _phone = controller.authRepository.phoneNumber ?? "";
    phoneTxtController.text = _phone;

    print("SignUpScreen: _phone: $_phone");
    print("SignUpScreen: phoneTxtController.text: ${phoneTxtController.text}");
  }

  void submitForm() {
    print("submitForm: called");
    if (!_key.currentState!.validate()) {
      return;
    }
    if (_birthdayString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TransUtil.trans("error_select_birthday"))));
      return;
    }

    try {
      controller.createUserProfile(_name, _phone, _birthdayString, _email);
    } catch (e) {
      DialogUtil.showAlertDialog(context, e.toString(), null);
    }

    print("$TAG form is valid: name: $_name, _phone: $_phone, birthday: $_birthdayString");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        // _birthdayString = dateFormat.format(picked);
        _birthdayString = MyDateFormatter.toStringDate(picked);
      });

    print("$TAG picked: ${picked?.toIso8601String()}}");
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height - paddingTop;
    final screenWidth = MediaQuery.of(context).size.width - paddingTop;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              // top right vector image
              bottom: screenHeight * 0.75,
              right: screenWidth * 0.78,
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              child: SvgPicture.asset(IMG_AUTH_TOP_LEFT),
            ),
            Positioned(
              // top left vector image
              bottom: screenHeight * 0.7,
              left: screenWidth * 0.7,
              width: screenWidth * 0.5,
              height: screenHeight * 0.4,
              child: SvgPicture.asset(IMG_AUTH_TOP_RIGHT),
            ),
            Positioned(
              // bottom left vector image
              top: screenHeight * 0.78,
              right: screenWidth * 0.84,
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              child: SvgPicture.asset(IMG_AUTH_BOTTOM_LEFT),
            ),
            Positioned(
              // bottom right vector image
              top: screenHeight * 0.72,
              left: screenWidth * 0.75,
              width: screenWidth * 0.5,
              height: screenHeight * 0.4,
              child: SvgPicture.asset(IMG_AUTH_BOTTOM_RIGHT),
            ),
            Positioned(
              // login form container
              top: 50,
              bottom: 50,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(marginLarge),
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IMG_LOGO,
                        width: screenWidth * 0.35,
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Text(
                        TransUtil.trans("sign_up_header"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeLarge,
                        ),
                      ),
                      SizedBox(
                        height: marginSmall,
                      ),
                      Text(
                        TransUtil.trans("sign_up_sub_title"),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_enter_your_name"),
                              isRequiredInput: true,
                              onChanged: (val) => _name = val,
                            ),
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              initialValue: _birthdayString.isEmpty
                                  ? TransUtil.trans("hint_your_birthday")
                                  : MyDateFormatter.toStringDate(selectedDate),
                              isRequiredInput: true,
                              isReadOnly: true,
                              actionIcon: Icons.calendar_today_outlined,
                              onActionTap: () => _selectDate(context),
                              onChanged: (val) => _birthdayString = val,
                              validator: null,
                            ),
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_enter_your_phone"),
                              // isRequiredInput: true,
                              controller: phoneTxtController,
                              isReadOnly: true,
                              initialValue: _phone,
                              onChanged: (val) => _phone = val,
                            ),
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_your_email"),
                              onChanged: (val) => _email = val,
                              emailFormat: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(marginLarge),
                        child: InlineButtons(
                          positiveText: TransUtil.trans("btn_create"),
                          negativeText: TransUtil.trans("btn_cancel"),
                          onNegativeTap: () => Provider.of<AuthController>(context, listen: false).logout(),
                          onPositiveTap: submitForm,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
