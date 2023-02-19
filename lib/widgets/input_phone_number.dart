import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

typedef StringFunction = String Function(String? val);

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final EdgeInsets? innerPadding;
  final StringFunction? validator;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String?>? onCountryCodeChanged;
  final Color? color;
  final String? hintText;
  final String? initialValue;
  final bool isRequiredInput;
  final bool isObscureText;
  final bool emailFormat;
  final bool isReadOnly;
  final int minLength;

  const PhoneNumberInput({
    Key? key,
    this.hintText,
    this.validator,
    this.onChanged,
    this.isRequiredInput = false,
    this.isObscureText = false,
    this.minLength = 0,
    this.emailFormat = false,
    this.initialValue,
    this.color,
    this.margin,
    this.innerPadding,
    this.isReadOnly = false,
    this.controller,
    this.onCountryCodeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: marginLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        color: color != null ? color : colorGrey,
      ),
      child: Padding(
        padding: innerPadding ?? const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginSmall),
        child: isReadOnly
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: marginLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      initialValue!,
                      style: TextStyle(color: Colors.black54, fontSize: fontSizeStandard),
                    ),
                    SizedBox(
                      height: marginSmall,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black45,
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  CountryCodePicker(
                    onChanged: (code) => onCountryCodeChanged!(code.dialCode),
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'IQ',
                    favorite: ['+964', 'IQ'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                  SizedBox(
                    width: marginSmall,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      initialValue: initialValue,
                      obscureText: isObscureText,
                      onChanged: (val) => onChanged!(val),
                      cursorColor: colorPrimary,
                      keyboardType: TextInputType.phone,
                      validator: validator != null
                          ? (value) => validator!(value)
                          : (value) {
                              if (isRequiredInput && value!.isEmpty) {
                                return TransUtil.trans("error_empty_field");
                              }
                              if (minLength > 0 && value!.length < minLength) {
                                if (isObscureText) return TransUtil.trans("error_short_password");
                                return TransUtil.trans("error_min_length_is $minLength");
                              }
                              if (emailFormat && !EmailValidator.validate(value!)) {
                                return TransUtil.trans("error_invalid_email_format");
                              }
                              return null;
                            },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
