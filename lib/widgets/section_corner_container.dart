import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class SectionCornerContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  const SectionCornerContainer({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLarge),
          topRight: Radius.circular(radiusLarge),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(marginStandard),
            child: Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizexLarge,
              ),
            ),
          ),
          Expanded(child: child!),
        ],
      ),
    );
  }
}
