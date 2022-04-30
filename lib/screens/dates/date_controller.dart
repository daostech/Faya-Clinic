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

  List<ClinicDate> _availableDates = [];
  List<ClinicService> _selectedServices = [];

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

  Future<void> fetchAvailableDates() async {
    // the request can not be made without both date and at least one service
    // if one of them is null or empty ignore the request
    final selectedServicesId = _selectedServices.map((e) => e.id).toList() ?? <String>[];
    if (selectedServicesId.isEmpty || _pickedDateTime == null) {
      return;
    }
    // emit loading state and re init the clinic date list to be filtered again
    // according to the selected date and services
    updateWith(loading: true, availableDates: <ClinicDate>[]);
    print("$TAG fetchAvailableDates: called");
    // get the server date format to be sent and get the reserved dates according to the selected datetime
    final formattedDate = MyDateFormatter.toStringDate(_pickedDateTime);

    final allDates = <String>[];
    for (String serviceId in selectedServicesId) {
      final result = await database.fetchAllDatesForService(serviceId, formattedDate).catchError((error) {
        print("$TAG [Error] fetchAvailableDates : $error");
      });
      allDates.addAll(result);
    }
    // remove any duplicated dates if exist
    final datesSet = allDates.toSet().toList();
    // last step send the datesSet to the getAvailableDates function
    // to filter the standard clinic dates according to the available dates in the server
    final avClinicDates = getAvailableDates(datesSet);
    updateWith(loading: false, availableDates: avClinicDates);
  }

  List<ClinicDate> getAvailableDates(List<String> reservedDate) {
    // the standard available clinic times list starts from 10:00 AM to 10:00 PM
    List<ClinicDate> standardClinicDates = [...ClinicDates.standardDates];

    // all the reserved and past times will be added to this list to be removed later
    final toBeRemoved = <ClinicDate>[];
    for (ClinicDate clinicDate in standardClinicDates) {
      // if the current clinicDate in the past add it to the list to be removed
      if (!MyDateFormatter.isValidClinicTime(clinicDate.startTimeFormatted24H)) {
        toBeRemoved.add(clinicDate);
      }
      // if the response from the server contains any reserved dates exclude them as well
      if (reservedDate != null && reservedDate.contains(clinicDate.startTimeFormatted24H)) {
        toBeRemoved.add(clinicDate);
      }
    }

    toBeRemoved.forEach((_toBeRemoved) {
      standardClinicDates.remove(_toBeRemoved);
    });
    // reserevedDate.forEach((reserved) {
    //   standardClinicDates.removeWhere((standard) => standard.startTimeFormatted24H == reserved);
    // });
    return standardClinicDates;
  }

  void onSectionSelected(Section section) {
    if (section == null) return;
    _subSections?.clear();
    _selectedServices?.clear();
    updateWith(
      pickedSection: section,
      subSections: <SubSection>[],
      selectedServices: <ClinicService>[],
      services: <ClinicService>[],
    );
    // filterSubSections(section);
    fetchSubSections(section.id);
  }

  void onSubSectionSelected(SubSection subSection) {
    if (subSection == null) return;
    updateWith(
      pickedSubSection: subSection,
      selectedServices: <ClinicService>[],
      services: <ClinicService>[],
    );
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
    fetchAvailableDates();
  }

  void onDateTimeChanged(DateRangePickerSelectionChangedArgs args) {
    _pickedDateTime = args.value;
    // fetchAvailableDates(_pickedDateTime);
    fetchAvailableDates();
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
    final _serviciesIds = _selectedServices.map((service) => service.id).toList();

    final registeredDate = DateTime(
      pickedDateTime.year,
      pickedDateTime.month,
      pickedDateTime.day,
      pickedClinicDate.startHour,
      pickedClinicDate.startMinutes,
    );

    return DateRegisteredRequest(
      userId: authRepository.userId,
      dateSectionId: selectedSection.id,
      subSectionId: selectedSubSection.id,
      registeredDate: registeredDate,
      time: pickedClinicDate.startTimeFormatted24H,
      serviceIds: _serviciesIds,
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
