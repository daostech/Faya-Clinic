import 'dart:io';

import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/user_account/user_account_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_label_top.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  UserAccountController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies called");
    controller = context.read<UserAccountController>();
    controller.initForm();
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('pickedFile not null');

      controller.uploadNewImage(pickedFile);
    } else {
      print('No image selected.');
    }
  }

  void handleBackPressed(BuildContext context, UserAccountController controller) {
    if (controller.hasUpdates) {
      DialogUtil.showWarningDialog(context, TransUtil.trans("msg_unsaved_changes"), () {
        Navigator.of(context).pop();
      });
    } else
      Navigator.of(context).pop();
  }

  void handleError(BuildContext context, UserAccountController controller) {
    DialogUtil.showAlertDialog(context, controller.error, null);
    controller.onErrorHandled();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<UserAccountController>(builder: (context, controller, _) {
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
                  title: TransUtil.trans("header_profile"),
                  onBackTap: () => handleBackPressed(context, controller),
                ),
                Container(
                  width: double.infinity,
                  color: colorPrimary,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(marginStandard, 50, marginStandard, 0),
                child: Column(
                  children: [
                    if (controller.loading)
                      Padding(
                        padding: const EdgeInsets.all(marginLarge),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    GestureDetector(
                      onTap: () => imgFromGallery(),
                      child: Container(
                        // user avatar container
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        decoration: BoxDecoration(
                          color: colorGreyLight,
                          borderRadius: BorderRadius.all(
                            Radius.circular(radiusStandard),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: controller.user.imgUrl == null
                            ? SizedBox()
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(radiusStandard),
                                ),
                                child: NetworkCachedImage(
                                  imageUrl: controller.user.imgUrl,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: marginLarge,
                    ),
                    Text(
                      controller.user?.userName ?? TransUtil.trans("label_username"),
                      style: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeLarge,
                      ),
                    ),
                    SizedBox(
                      height: marginSmall,
                    ),
                    Text(
                      TransUtil.trans("label_please_fill_details"),
                    ),
                    SizedBox(
                      height: marginxLarge,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          LabeledInput(
                            controller: controller.userNameTxtController,
                            label: TransUtil.trans("label_name_required"),
                            hintText: TransUtil.trans("hint_your_name"),
                            initialValue: controller.user?.userName ?? "",
                            isRequiredInput: true,
                            onChanged: (_) {},
                          ),
                          LabeledInput(
                            controller: controller.emailTxtController,
                            label: TransUtil.trans("label_email"),
                            hintText: TransUtil.trans("hint_your_email"),
                            initialValue: controller.user?.email ?? "",
                            isRequiredInput: true,
                            onChanged: (_) {},
                          ),
                          LabeledInput(
                            controller: controller.phoneTxtController,
                            label: TransUtil.trans("label_phone"),
                            hintText: TransUtil.trans("hint_your_phone"),
                            initialValue: controller.user?.phoneNumber ?? "",
                            isReadOnly: true,
                            onChanged: (_) {},
                          ),
                          LabeledInput(
                            label: TransUtil.trans("label_birthday"),
                            initialValue: MyDateFormatter.toStringFormatted(controller.user?.dateBirth) ?? "",
                            isReadOnly: true,
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: marginLarge,
                    ),
                    InlineButtons(
                      positiveText: TransUtil.trans("btn_save"),
                      negativeText: TransUtil.trans("btn_cancel"),
                      onPositiveTap: () => controller.submitForm().then((success) {
                        if (success) Navigator.of(context).pop();
                      }),
                      onNegativeTap: () => handleBackPressed(context, controller),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
