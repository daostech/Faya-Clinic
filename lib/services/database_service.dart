import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/category.dart';
import 'package:faya_clinic/models/home_slider.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:flutter/material.dart';

abstract class Database {
  Future getHomeSliders();
  Future getLastOffers();
  Future fetchProductsList();
  Future fetchSectionsList();
  Future fetchSubSectionsList(String sectionId);
  Future fetchServicesList(String subSectionId);
  Future fetchProductCategories();
  Future getClinicsList();
  Future fetchOffersList();
  Future fetchMyPreviousOrders();
  Future fetchMyFavoriteProducts(userId);
  Future fetchMyDates(userId);
  Future getTeamsList();

  Future createNewDate(DateRegisteredRequest request);
}

class DatabaseService implements Database {
  final APIService apiService;

  DatabaseService({@required this.apiService});

  @override
  getClinicsList() {
    // TODO: implement getClinicsList
    throw UnimplementedError();
  }

  @override
  getHomeSliders() {
    return apiService.getData<HomeSlider>(
      builder: (data) => HomeSlider.fromJson(data),
      path: APIPath.slidersList(),
    );
  }

  @override
  getLastOffers() {
    // TODO: implement getLastOffers
    throw UnimplementedError();
  }

  @override
  fetchMyDates(userId) {
    // TODO: implement getMyDates
    throw UnimplementedError();
  }

  @override
  fetchMyFavoriteProducts(userId) {
    // TODO: implement getMyFavoriteProducts
    throw UnimplementedError();
  }

  @override
  fetchMyPreviousOrders() {
    // TODO: implement getMyPreviousOrders
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchProductsList() {
    return apiService.getData<Product>(
      path: APIPath.productsList(),
      builder: (data) => Product.fromJson(data),
    );
  }

  @override
  Future fetchProductCategories() {
    return apiService.getData<Category>(
      path: APIPath.categoriesList(),
      builder: (data) => Category.fromJson(data),
    );
  }

  @override
  Future fetchSectionsList() {
    return apiService.getData<Section>(
      path: APIPath.sectionsList(),
      builder: (data) => Section.fromJson(data),
    );
  }

  @override
  Future fetchSubSectionsList(String sectionId) {
    return apiService.getData<SubSection>(
      builder: (data) => SubSection.fromJson(data),
      path: APIPath.subSectionsList(sectionId),
    );
  }

  @override
  Future fetchServicesList(String subSectionId) {
    return apiService.getData<ClinicService>(
      builder: (data) => ClinicService.fromJson(data),
      path: APIPath.servicesList(subSectionId),
    );
  }

  @override
  Future getTeamsList() {
    return apiService.getData<Team>(
      builder: (data) => Team.fromJson(data),
      path: APIPath.teamsList(),
    );
  }

  @override
  Future fetchOffersList() {
    return apiService.getData<Offer>(
      builder: (data) => Offer.fromJson(data),
      path: APIPath.offersList(),
    );
  }

  @override
  Future createNewDate(DateRegisteredRequest request) {
    return apiService.postData<DateRegisteredRequest>(
      // builder: (data) => Offer.fromJson(data),
      path: APIPath.createDate(),
      body: request.toJson(),
    );
  }
}
