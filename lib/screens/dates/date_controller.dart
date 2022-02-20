import 'package:faya_clinic/constants/clinic_dates.dart';
import 'package:faya_clinic/models/clinic_date.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateScreenController with ChangeNotifier {
  static const TAG = "DateScreenController: ";
  final Database database;
  final AuthRepositoryBase authRepository;
  DateScreenController({@required this.authRepository, @required this.database}) {
    init();
    // fetchAvailableDates(DateTime(2022, 01, 09));
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  static List<Section> _sections;
  static List<SubSection> _subSections;
  static List<ClinicService> _services;

  List<ClinicService> _selectedServices = [];
  List<ClinicDate> _availableDates = [];

  Section selectedSection;
  SubSection selectedSubSection;
  DateTime _pickedDateTime;
  ClinicDate pickedClinicDate;

  var isLoading = true;
  bool _mounted = true;

  List<Section> get sectionsList => _sections;
  List<SubSection> get subSectionsList => _subSections;
  List<ClinicService> get servicesList => _services;
  List<ClinicService> get selectedServices => _selectedServices;
  List<ClinicDate> get availableDates => _availableDates;
  DateTime get pickedDateTime => _pickedDateTime;
  bool get mounted => _mounted;

  init() async {
    fetchSections();
  }

  Future<void> fetchSections() async {
    updateWith(loading: true);
    print("$TAG fetchSections: called");
    final result = await database.fetchSectionsList().catchError((error) {
      print("$TAG [Error] fetchSections : $error");
    });
    updateWith(sections: result, loading: false);
  }

  Future<void> fetchSubSections(String sectionId) async {
    updateWith(loading: true);
    print("$TAG fetchSubSections: called");
    final result = await database.fetchSubSectionsList(sectionId).catchError((error) {
      print("$TAG [Error] fetchSubSections : $error");
    });
    updateWith(subSections: result, loading: false);
  }

  Future<void> fetchServices(String subSectionId) async {
    updateWith(loading: true);
    print("$TAG fetchServices: called");
    final result = await database.fetchServicesList(subSectionId).catchError((error) {
      print("$TAG [Error] fetchServices : $error");
    });
    updateWith(services: result, loading: false);
  }

  Future<void> fetchAvailableDates(DateTime dateTime) async {
    updateWith(loading: true);
    print("$TAG fetchAvailableDates: called");
    final formattedDate =
        MyDateFormatter.toStringDate(dateTime); // todo add new format to match the server format if needed
    final List<String> allDates = await database.fetchAllDatesOn(formattedDate).catchError((error) {
      print("$TAG [Error] fetchAvailableDates : $error");
    });
    final avClinicDates = getAvailableDates(allDates);
    updateWith(loading: false, availableDates: avClinicDates);
  }

  List<ClinicDate> getAvailableDates(List<String> reserevedDate) {
    List<ClinicDate> standardClinicDates = [...ClinicDates.standardDates];
    reserevedDate.forEach((reserved) {
      standardClinicDates.removeWhere((standard) => standard.startTimeFormatted24H == reserved);
    });
    return standardClinicDates;
  }

  void onSectionSelected(Section section) {
    if (section == null) return;
    _subSections?.clear();
    _selectedServices?.clear();
    updateWith(pickedSection: section, subSections: _subSections, selectedServices: _selectedServices);
    // filterSubSections(section);
    fetchSubSections(section.id);
  }

  void onSubSectionSelected(SubSection subSection) {
    if (subSection == null) return;
    updateWith(pickedSubSection: subSection);
    fetchServices(subSection.id);
  }

  bool isSelectedService(ClinicService service) {
    if (service == null) return false;
    return selectedServices.firstWhere((element) => element.id == service.id, orElse: () => null) != null;
  }

  void toggleService(ClinicService service) {
    if (service == null) return;
    if (isSelectedService(service)) {
      _selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      _selectedServices.add(service);
    }
    updateWith(selectedServices: _selectedServices);
  }

  void onDateTimeChanged(DateRangePickerSelectionChangedArgs args) {
    _pickedDateTime = args.value;
    fetchAvailableDates(_pickedDateTime);
    print("onDateTimeChanged: pickedDateTime: ${_pickedDateTime.toString()}");
  }

  void onClinicDateSelected(ClinicDate date) {
    updateWith(pickedDate: date);
  }

  Future<bool> createNewDate() async {
    print("$TAG createNewDate: request ${request.toJson()}");
    updateWith(loading: true);
    final result = await database.createNewDate(request).catchError((error) {
      print("$TAG [Error] createNewDate: ${error.toString()}");
    });
    if (result != null && result.success) {
      resetForm();
    }
    updateWith(loading: false);
    return result?.success ?? false;
  }

  bool get isFormReady {
    return selectedSection != null &&
        selectedSubSection != null &&
        _pickedDateTime != null &&
        pickedClinicDate != null &&
        _selectedServices.isNotEmpty;
  }

  DateRegisteredRequest get request {
    final now = DateTime.now();

    final registeredDate = DateTime(
      now.year,
      now.month,
      now.day,
      pickedClinicDate.startHour,
      pickedClinicDate.startMinutes,
    );

    return DateRegisteredRequest(
      userId: authRepository.userId,
      sectionId: selectedSection.id,
      subSectionId: selectedSubSection.id,
      dateTime: registeredDate,
      timeStr: pickedClinicDate.startTimeFormatted24H,
      services: _selectedServices,
    );
  }

  void resetForm() {
    isLoading = false;
    _subSections = null;
    _services = null;
    selectedSection = null;
    selectedSubSection = null;
    _availableDates = [];
    _selectedServices = [];
    _pickedDateTime = null;
    pickedClinicDate = null;
    if (mounted) notifyListeners();
  }

  updateWith({
    bool loading,
    List<Section> sections,
    List<SubSection> subSections,
    List<ClinicService> services,
    List<ClinicService> selectedServices,
    List<ClinicDate> availableDates,
    Section pickedSection,
    SubSection pickedSubSection,
    DateTime pickedDateTime,
    ClinicDate pickedDate,
  }) {
    isLoading = loading ?? isLoading;
    _sections = sections ?? _sections;
    _subSections = subSections ?? _subSections;
    _services = services ?? _services;
    selectedSection = pickedSection ?? selectedSection;
    selectedSubSection = pickedSubSection ?? selectedSubSection;
    _availableDates = availableDates ?? _availableDates;
    _selectedServices = selectedServices ?? _selectedServices;
    _pickedDateTime = pickedDateTime ?? _pickedDateTime;
    pickedClinicDate = pickedDate ?? pickedClinicDate;
    if (mounted) notifyListeners();
  }
}
