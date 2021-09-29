import 'package:email_validator/email_validator.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

typedef StringFunction = String Function(String val);

class StandardInput extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets innerPadding;
  final StringFunction validator;
  final ValueSetter<String> onChanged;
  final Color color;
  final String hintText;
  final String initialValue;
  final bool isRequiredInput;
  final bool isObscureText;
  final bool emailFormat;
  final int minLength;

  const StandardInput(
      {Key key,
      @required this.hintText,
      this.validator,
      this.onChanged,
      this.isRequiredInput = false,
      this.isObscureText = false,
      this.minLength = 0,
      this.emailFormat = false,
      this.initialValue = "",
      this.color,
      this.margin,
      this.innerPadding})
      : super(key: key);

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
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hintText,
          ),
          initialValue: initialValue,
          obscureText: isObscureText,
          onChanged: (val) => onChanged(val),
          cursorColor: primaryColor,
          validator: validator != null
              ? (value) => validator(value)
              : (value) {
                  if (isRequiredInput && value.isEmpty) {
                    return TransUtil.trans("error_empty_field");
                  }
                  if (minLength > 0 && value.length < minLength) {
                    if (isObscureText) return TransUtil.trans("error_short_password");
                    return TransUtil.trans("error_min_length_is $minLength");
                  }
                  if (emailFormat && !EmailValidator.validate(value)) {
                    return TransUtil.trans("error_invalid_email_format");
                  }
                  return null;
                },
        ),
      ),
    );
  }
}
