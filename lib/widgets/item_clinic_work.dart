import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/clinic_work.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ClinicWorkItem extends StatelessWidget {
  final ClinicWork clinicWork;
  final Function()? onTap;
  const ClinicWorkItem({
    Key? key,
    required this.clinicWork,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(
        Radius.circular(radiusxSmall),
      ),
      child: Container(
        // main  container
        margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
        width: 200,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radiusxSmall),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(radiusxSmall),
          ),
          child: NetworkCachedImage(
            fit: BoxFit.fill,
            imageUrl: clinicWork.hasImages ? clinicWork.images[0] : "",
          ),
        ),
      ),
    );
  }
}
