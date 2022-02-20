import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  final AuthController controller;
  IntroScreen({Key key, @required this.controller}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  AuthController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("intro_description_1"),
        // pathImage: "",
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("intro_description_2"),
        // pathImage: "",
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("intro_description_3"),
        // pathImage: "",
        backgroundColor: colorPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: controller.onFirstOpenDone,
      // onDonePress: () => Navigator.of(context)
      //     .pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => AuthWrapper()), (route) => route.isFirst),
    );
  }
}
