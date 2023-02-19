import 'dart:async';

import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/utils/url_launcher_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClinicFindUsTab extends StatefulWidget {
  const ClinicFindUsTab({Key? key}) : super(key: key);

  @override
  State<ClinicFindUsTab> createState() => _ClinicFindUsTabState();
}

class _ClinicFindUsTabState extends State<ClinicFindUsTab> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: AppConfig.MAP_LATLNG,
    zoom: 16,
  );

  final Set<Marker> _shopLocationMarker = {
    Marker(
      markerId: MarkerId("id"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      position: AppConfig.MAP_LATLNG,
    )
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  rotateGesturesEnabled: false,
                  markers: _shopLocationMarker,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  bottom: marginLarge,
                  child: StandardButton(
                    radius: radiusStandard,
                    text: TransUtil.trans("btn_get_directions"),
                    onTap: () {
                      try {
                        UrlLauncherUtil.openMap(AppConfig.MAP_LATLNG);
                      } catch (error) {
                        DialogUtil.showAlertDialog(context, TransUtil.trans(error.toString()), null);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text(TransUtil.trans("clinic_formatted_address")),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(AppConfig.CONTACT_PHONE_FORMATTED),
            onTap: () => UrlLauncherUtil.openDialNumberFor(AppConfig.CONTACT_PHONE_FORMATTED).catchError((error) {
              DialogUtil.showToastMessage(context, TransUtil.trans(error));
            }),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(AppConfig.CONTACT_PHONE_FORMATTED2),
            onTap: () => UrlLauncherUtil.openDialNumberFor(AppConfig.CONTACT_PHONE_FORMATTED2).catchError((error) {
              DialogUtil.showToastMessage(context, TransUtil.trans(error));
            }),
          ),
        ],
      ),
    );
  }
}
