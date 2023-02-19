import 'dart:async';

import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplash> {
  var _appVersion = "";
  @override
  void initState() {
    _initPackageInfo();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, (MaterialPageRoute(builder: (context) => AfterSplash())));
    });
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(TransUtil.trans("app_name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("V " + _appVersion),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  const AfterSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("After Splash"),
      ),
    );
  }
}
