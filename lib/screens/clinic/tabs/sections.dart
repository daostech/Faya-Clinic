import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/widgets/item_section.dart';
import 'package:flutter/material.dart';

class ClinicSectionsTab extends StatelessWidget {
  const ClinicSectionsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return SectionItem(
            imgUrl:
                "https://images.squarespace-cdn.com/content/v1/5c76eb2011f78474bf7cd0f4/1578516048181-1VW6N4LSXZ466I8CS5I1/AS-0849.JPG",
          );
        },
      ),
    );
  }
}
