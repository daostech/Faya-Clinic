import 'package:email_validator/email_validator.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

typedef StringFunction = String Function(String? val);

class LabeledInput extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final EdgeInsets? innerPadding;
  final StringFunction? validator;
  final Function? onTap;
  final Function? onActionTap;
  final ValueSetter<String>? onChanged;
  final Widget? actionIcon;
  final Color? color;
  final String? hintText;
  final String initialValue;
  final String? label;
  final bool isRequiredInput;
  final bool isObscureText;
  final bool emailFormat;
  final bool isReadOnly;
  final int minLength;
  final int? maxLength;

  const LabeledInput({
    Key? key,
    this.hintText,
    this.validator,
    this.onChanged,
    this.isRequiredInput = false,
    this.isObscureText = false,
    this.minLength = 0,
    this.maxLength,
    this.emailFormat = false,
    this.initialValue = "",
    this.color,
    this.margin,
    this.innerPadding,
    this.isReadOnly = false,
    this.onTap,
    this.actionIcon,
    this.onActionTap,
    this.label,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: label != null,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(label!),
          ),
        ),
        SizedBox(
          height: marginStandard,
        ),
        Container(
          margin: margin ?? const EdgeInsets.only(bottom: marginLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radiusStandard),
            ),
            border: Border.all(
              color: Colors.black87,
              width: 0.5,
            ),
            color: color != null ? color : Colors.white,
          ),
          child: InkWell(
            onTap: onTap as void Function()?,
            child: Padding(
              padding: innerPadding ?? const EdgeInsets.symmetric(horizontal: marginLarge, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    child: FocusScope(
                      node: FocusScopeNode(
                        canRequestFocus: !isReadOnly,
                      ),
                      child: isReadOnly
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: marginLarge,
                              ),
                              child: Text(
                                initialValue,
                                style: TextStyle(color: Colors.black54, fontSize: fontSizeSmall),
                              ),
                            )
                          : TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: hintText,
                              ),
                              // initialValue: initialValue,
                              maxLength: maxLength,
                              obscureText: isObscureText,
                              onChanged: (val) => onChanged!(val),
                              cursorColor: colorPrimary,
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
                  ),
                  Visibility(
                    visible: actionIcon != null,
                    child: InkWell(
                      onTap: onActionTap as void Function()?,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: actionIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
