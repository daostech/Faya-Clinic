import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget {
  final AuthController controller;
  IntroScreen({Key key, @required this.controller}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  final Key doneBtnKey = Key("doneBtnKey");
  final Key prevBtnKey = Key("prevBtnKey");
  final Key nextBtnKey = Key("nextBtnKey");
  final Key skipBtnKey = Key("skipBtnKey");
  List<Slide> slides = [];
  AuthController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        // widgetDescription: Text(
        //   TransUtil.trans("slider_body1"),
        //   style: TextStyle(color: Colors.white),
        // ),
        description: TransUtil.trans("slider_body1"),
        // pathImage: IMG_SLIDER_1,
        // widgetTitle: SvgPicture.asset(IMG_SLIDER_1, color: Colors.white),
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        // widgetDescription: Text(
        //   TransUtil.trans("slider_body2"),
        //   style: TextStyle(color: Colors.white),
        // ),
        description: TransUtil.trans("slider_body2"),
        // pathImage: IMG_SLIDER_2,
        // widgetTitle: SvgPicture.asset(IMG_SLIDER_2),
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        title: "",
        // title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("slider_body3"),
        // widgetDescription: Text(
        //   TransUtil.trans("slider_body3"),
        //   style: TextStyle(color: Colors.white),
        // ),
        // pathImage: IMG_SLIDER_3,
        // widgetTitle: SvgPicture.asset(IMG_SLIDER_3),
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        title: "",
        // title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("slider_body4"),
        // widgetDescription: Text(
        //   TransUtil.trans("slider_body4"),
        //   style: TextStyle(color: Colors.white),
        // ),
        // pathImage: IMG_SLIDER_1,
        // widgetTitle: SvgPicture.asset(IMG_SLIDER_1),
        backgroundColor: colorPrimary,
      ),
    );
    slides.add(
      new Slide(
        title: "",
        // title: TransUtil.trans("header_welcome_to_clinic"),
        description: TransUtil.trans("slider_body5"),
        // widgetDescription: Text(
        //   TransUtil.trans("slider_body5"),
        //   style: TextStyle(color: Colors.white),
        // ),
        // pathImage: IMG_SLIDER_2,
        // widgetTitle: SvgPicture.asset(IMG_SLIDER_2, color: Colors.white),
        backgroundColor: colorPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      doneButtonKey: doneBtnKey,
      nextButtonKey: nextBtnKey,
      prevButtonKey: prevBtnKey,
      skipButtonKey: skipBtnKey,
      showPrevBtn: false,
      showNextBtn: false,
      showSkipBtn: false,
      renderDoneBtn: TextButton(
        key: doneBtnKey,
        onPressed: controller.onFirstOpenDone,
        child: Text(
          TransUtil.trans("btn_done"),
          style: TextStyle(color: Colors.white),
        ),
      ),
      renderPrevBtn: TextButton(
        key: prevBtnKey,
        onPressed: () {},
        child: Text(
          TransUtil.trans("btn_previous"),
          style: TextStyle(color: Colors.white),
        ),
      ),
      renderNextBtn: TextButton(
        key: nextBtnKey,
        onPressed: () {},
        child: Text(
          TransUtil.trans("btn_next"),
          style: TextStyle(color: Colors.white),
        ),
      ),
      renderSkipBtn: TextButton(
        key: skipBtnKey,
        onPressed: () {},
        child: Text(
          TransUtil.trans("btn_skip"),
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDonePress: controller.onFirstOpenDone,
      onSkipPress: controller.onFirstOpenDone,
    );
  }
}
