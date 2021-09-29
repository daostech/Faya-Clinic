import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const TAG = "SignUpScreen: ";
  final _key = GlobalKey<FormState>();
  final dateFormat = new DateFormat('yyyy-MM-dd');

  DateTime selectedDate;
  var _name = "";
  var _phone = "";
  var _birthdayString = "";
  var _password = "";
  var _rPassword = "";

  void submitForm() {
    if (!_key.currentState.validate()) {
      if (_birthdayString.isEmpty)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TransUtil.trans("error_select_birthday"))));
      return;
    }
    if (_password != _rPassword) {
      print("$TAG error_password_not_match");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TransUtil.trans("error_password_not_match"))));
      return;
    }
    print("$TAG form is valid: name: $_name, _phone: $_phone, birthday: $_birthdayString, password: $_password");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _birthdayString = dateFormat.format(picked);
      });

    print("$TAG picked: ${picked.toIso8601String()}}");
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
                            StandardInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_your_name"),
                              isRequiredInput: true,
                              onChanged: (val) => _name = val,
                            ),
                            StandardInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              initialValue: _birthdayString.isEmpty
                                  ? TransUtil.trans("hint_your_birthday")
                                  : dateFormat.format(selectedDate),
                              isRequiredInput: true,
                              isReadOnly: true,
                              actionIcon: Icons.calendar_today_outlined,
                              onActionTap: () => _selectDate(context),
                              onChanged: (_) {},
                              validator: null,
                            ),
                            StandardInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_your_phone"),
                              isRequiredInput: true,
                              onChanged: (val) => _phone = val,
                            ),
                            StandardInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_your_password"),
                              isRequiredInput: true,
                              isObscureText: true,
                              onChanged: (val) => _password = val,
                            ),
                            StandardInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_repeat_password"),
                              isRequiredInput: true,
                              isObscureText: true,
                              onChanged: (val) => _rPassword = val,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: colorGrey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusStandard),
                                      bottomLeft: Radius.circular(radiusStandard),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(marginStandard),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        TransUtil.trans("btn_cancel").toUpperCase(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: marginStandard,
                            ),
                            Row(
                              children: [],
                            ),
                            SizedBox(
                              width: marginStandard,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: submitForm,
                                radius: radiusStandard,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(radiusStandard),
                                      bottomRight: Radius.circular(radiusStandard),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(marginStandard),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        TransUtil.trans("btn_create").toUpperCase(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
