import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/screens/clinic/clinic_sub_section_details.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/widgets/item_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicSubSectionsScreen extends StatefulWidget {
  static const ROUTE_NAME = "/ClinicSubSectionsScreen";
  final String sectionId;
  const ClinicSubSectionsScreen({Key key, @required this.sectionId}) : super(key: key);

  @override
  State<ClinicSubSectionsScreen> createState() => _ClinicSubSectionsScreenState();
}

class _ClinicSubSectionsScreenState extends State<ClinicSubSectionsScreen> {
  List<SubSection> subSections = [];
  Database database;
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    database = context.read<Database>();
    getSubSectonsList();
  }

  Future getSubSectonsList() {
    return database.fetchSubSectionsList(widget.sectionId).then((value) {
      subSections = value;
      isLoading = false;
    }).catchError((error) {
      DialogUtil.showAlertDialog(context, error);
      isLoading = false;
    });
  }

  set isLoading(bool isLoading) {
    setState(() {
      loading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Sections"),
      ),
      body: Container(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (loading) return Center(child: CircularProgressIndicator());
    if (subSections.isEmpty) return Center(child: Text("No Data for this Section"));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: marginLarge),
      itemCount: subSections.length,
      itemBuilder: (ctx, index) {
        print("subSections.length: ${subSections.length}");
        return SectionItem(
          image: subSections[index].img1,
          title: subSections[index].name,
          subTitle: subSections[index].description,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => ClinicSubSectionDetailsScreen(
                subSection: subSections[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
