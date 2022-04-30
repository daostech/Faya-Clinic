import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:toast/toast.dart';

class DialogUtil {
  static const TAG = "DialogUtil:";

  static Future<void> showAlertDialog(BuildContext context, String error, Function onSubmit) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TransUtil.trans('label_error')),
          content: SingleChildScrollView(
            child: Text(error),
          ),
          actions: <Widget>[
            // if there is no action no need to show the negative button
            if (onSubmit != null)
              TextButton(
                child: Text(TransUtil.trans('btn_cancel')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(TransUtil.trans('btn_ok')),
              onPressed: () {
                Navigator.of(context).pop();
                if (onSubmit != null) onSubmit();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showWarningDialog(BuildContext context, String error, Function onSubmit) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TransUtil.trans('label_warning')),
          content: SingleChildScrollView(
            child: Text(error),
          ),
          actions: <Widget>[
            // if there is no action no need to show the negative button
            if (onSubmit != null)
              TextButton(
                child: Text(TransUtil.trans('btn_cancel')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(TransUtil.trans('btn_ok')),
              onPressed: () {
                Navigator.of(context).pop();
                if (onSubmit != null) onSubmit();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDeleteWarningDialog(BuildContext context, Function onDeleteClick) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TransUtil.trans('label_error')),
          content: SingleChildScrollView(
            child: Text("Are you sure you want to delete this item ?"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                TransUtil.trans('btn_delete'),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onDeleteClick();
              },
            ),
            TextButton(
              child: Text(TransUtil.trans('btn_cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<DateTime> showYearMonthPickerDialog(BuildContext context) {
    final now = DateTime.now();
    return showMonthYearPicker(
      context: context,
      initialDate: now,
      locale: TransUtil.getCurrentLocale(context),
      firstDate: DateTime(now.year - 20),
      lastDate: DateTime(now.year + 20),
    );
  }

  static Future<dynamic> showBottomSheet(BuildContext context, Widget body) {
    print("$TAG showing bottom sheet");
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => body,
    );
  }

  static void showToastMessage(BuildContext context, String message) {
    final toastContext = ToastContext();
    toastContext.init(context);
    Toast.show(message, duration: 1, gravity: 0);
  }
}
