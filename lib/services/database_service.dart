import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/category.dart';
import 'package:faya_clinic/models/date_registered.dart';
import 'package:faya_clinic/models/home_slider.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/product_review.dart';
import 'package:faya_clinic/models/requests/create_order_request.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/requests/product_review_request.dart';
import 'package:faya_clinic/models/response/post_response.dart';
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
  Future fetchAllDatesOn(String formattedDateStr);
  Future fetchOffersList();
  Future fetchMyPreviousOrders();
  Future fetchMyFavoriteProducts(userId);
  Future fetchUserDates(String userId);
  Future getTeamsList();
  Future fetchProductReviews(String productId);
  Future<PostResponse> postProductReview(ProductReviewRequest request);
  Future<PostResponse> createNewOrder(CreateOrderRequest request);

  Future<PostResponse> createNewDate(DateRegisteredRequest request);
}

class DatabaseService implements Database {
  final APIService apiService;

  DatabaseService({@required this.apiService});

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
  fetchUserDates(userId) {
    return apiService.getData<DateRegistered>(
      builder: (data) => DateRegistered.fromJson(data),
      path: APIPath.userDatesList(userId),
    );
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
  Future<PostResponse> createNewDate(DateRegisteredRequest request) {
    return apiService.postData<DateRegisteredRequest>(
      path: APIPath.createDate(),
      body: request.toJson(),
    );
  }

  @override
  Future<List<String>> fetchAllDatesOn(String formattedDateStr) {
    return apiService.getData<String>(
      builder: (data) => data.toString(),
      path: APIPath.allDatesOn(formattedDateStr),
    );
  }

  @override
  Future fetchProductReviews(String productId) {
    return apiService.getData<ProductReview>(
      builder: (data) => ProductReview.fromJson(data),
      path: APIPath.productReviews(productId),
    );
  }

  @override
  Future<PostResponse> postProductReview(ProductReviewRequest request) {
    return apiService.postData<ProductReviewRequest>(
      path: APIPath.postProductReview(),
      body: request.toJson(),
    );
  }

  @override
  Future<PostResponse> createNewOrder(CreateOrderRequest request) {
    return apiService.postData<CreateOrderRequest>(
      path: APIPath.createOrder(),
      body: request.toJson(),
    );
  }
}
