import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/screens/clinic/tabs/tab_offers.dart';
import 'package:faya_clinic/screens/clinic/tabs/tab_sections.dart';
import 'package:faya_clinic/screens/clinic/tabs/tab_team.dart';
import 'package:faya_clinic/screens/clinic/tabs/tab_find_us.dart';

class ClinicController with ChangeNotifier {
  static const TAG = "ClinicController: ";
  final Database database;
  ClinicController({this.database}) {
    fetchTeamsList();
  }

  var currentTabIndex = 0;
  var isLoading = false;

  List<Team> _teamsList;
  List<Section> _sectionsList;
  List<Offer> _offersList;

  List<Team> get teamsList => _teamsList;
  List<Section> get sectionsList => _sectionsList;
  List<dynamic> get offersList => _offersList;

  Future<void> fetchTeamsList() async {
    updateWith(loading: true);
    print("$TAG fetchTeamsList: called");
    final result = await database.getTeamsList().catchError((error) {
      print("$TAG [Error] fetchTeamsList : $error");
    });
    updateWith(teams: result, loading: false);
  }

  Future<void> fetchSections() async {
    updateWith(loading: true);
    print("$TAG fetchSections: called");
    final result = await database.fetchSectionsList().catchError((error) {
      print("$TAG [Error] fetchSections : $error");
    });
    updateWith(sections: result, loading: false);
  }

  Future<void> fetchOffers() async {
    updateWith(loading: true);
    print("$TAG fetchOffers: called");
    final result = await database.fetchOffersList().catchError((error) {
      print("$TAG [Error] fetchOffers : $error");
    });
    updateWith(offers: result, loading: false);
  }

  void onTabChanged(int index) {
    switch (index) {
      case 0:
        if (_teamsList == null) fetchTeamsList();
        break;
      case 1:
        if (_sectionsList == null) fetchSections();
        break;
      case 2:
        if (_offersList == null) fetchOffers();
        break;
    }
    updateWith(selectedTabIndex: index);
  }

  Widget get currentTab {
    switch (currentTabIndex) {
      case 0:
        return ClinicTeamTab();
        break;
      case 1:
        return ClinicSectionsTab();
        break;
      case 2:
        return ClinicOffersTab();
        break;
      case 3:
        return ClinicFindUsTab();
        break;
      default:
        return Container();
    }
  }

  void updateWith({
    bool loading,
    int selectedTabIndex,
    List<Team> teams,
    List<Section> sections,
    List<Offer> offers,
  }) {
    isLoading = loading ?? isLoading;
    currentTabIndex = selectedTabIndex ?? currentTabIndex;
    _teamsList = teams ?? _teamsList;
    _sectionsList = sections ?? _sectionsList;
    _offersList = offers ?? _offersList;
    notifyListeners();
  }
}
