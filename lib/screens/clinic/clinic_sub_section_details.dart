import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/clinic_work.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/auth_required.dart';
import 'package:faya_clinic/screens/dates/dates_screen_global.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/item_clinic_work.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicSubSectionDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = "/ClinicSectionDetailsScreen";
  const ClinicSubSectionDetailsScreen({Key? key, required this.subSection}) : super(key: key);
  final SubSection subSection;

  @override
  State<ClinicSubSectionDetailsScreen> createState() => _ClinicSubSectionDetailsScreenState();
}

class _ClinicSubSectionDetailsScreenState extends State<ClinicSubSectionDetailsScreen> {
  bool loading = true;
  List<ClinicWork> clinicWorks = <ClinicWork>[];

  handleBookDate(BuildContext context, bool isLoggedIn) {
    if (!isLoggedIn) {
      AuthRequiredScreen.show(context, TransUtil.trans("msg_login_to_book_date"));
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => DatesScreenGlobal()));
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final database = Provider.of<Database>(context, listen: false);
    final result = await database.fetchClinicWorksBySectionId(widget.subSection.id.toString());
    setState(() {
      clinicWorks.addAll(result);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final authController = context.read<AuthController>();
    final isLoggedIn = authController.authState!.value == AuthState.LOGGED_IN.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subSection.name ?? TransUtil.trans("header_section_details")),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(marginLarge, marginStandard, marginLarge, 0),
        child: Column(
          children: [
            ClipRRect(
              // image container
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              child: Container(
                // image main container
                width: _size.width,
                height: _size.width,
                child: NetworkCachedImage(
                  imageUrl: widget.subSection.imageUrl,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: marginLarge,
              ),
              child: Text(widget.subSection.description!),
            ),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: marginStandard,
                        crossAxisSpacing: marginStandard,
                      ),
                      itemCount: clinicWorks.length,
                      itemBuilder: (ctx, index) {
                        return ClinicWorkItem(
                          onTap: () => DialogUtil.showStandardDialog(
                              context,
                              ClinicWorkItem(
                                clinicWork: clinicWorks[index],
                              ),
                              padding: const EdgeInsets.all(0)),
                          clinicWork: clinicWorks[index],
                        );
                      },
                    ),
            ),
            StandardButton(
              onTap: () => handleBookDate(context, isLoggedIn),
              text: TransUtil.trans("btn_book_your_date_now"),
              radius: radiusStandard,
            ),
            SizedBox(
              height: marginLarge,
            ),
          ],
        ),
      ),
    );
  }
}
