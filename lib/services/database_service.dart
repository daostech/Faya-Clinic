import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/category.dart';
import 'package:faya_clinic/models/clinic_work.dart';
import 'package:faya_clinic/models/home_slider.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/product_review.dart';
import 'package:faya_clinic/models/requests/create_order_request.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/requests/product_review_request.dart';
import 'package:faya_clinic/models/response/post_response.dart';
import 'package:faya_clinic/models/user_order.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:faya_clinic/models/user_date/user_date.dart';

abstract class Database {
  Future getHomeSliders();
  Future getLastOffers();
  Future fetchProductsList();
  Future fetchSectionsList();
  Future fetchSubSectionsList();
  Future fetchSubSectionsListBySectionId(String? sectionId);
  Future fetchServicesList(String? subSectionId);
  Future fetchProductCategories();
  Future fetchAllDatesForService(String? serviceId, String formattedDateStr);
  Future fetchOffersList();
  Future<List<UserOrder>> fetchUserPreviousOrders(userId);
  Future fetchMyFavoriteProducts(userId);
  Future<List<UserDate2>> fetchUserDates(userId);
  Future getTeamsList();
  Future fetchProductReviews(String? productId);
  Future fetchClinicWorksList();
  Future fetchClinicWorksBySectionId(String sectionId);
  Future<PostResponse> postProductReview(ProductReviewRequest request);
  Future<PostResponse> updateUserProfile(ProductReviewRequest request, String userId);
  Future<PostResponse> createNewOrder(CreateOrderRequest request);

  Future<PostResponse> createNewDate(DateRegisteredRequest request);
}

class DatabaseService implements Database {
  final APIService apiService;

  DatabaseService({required this.apiService});

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
  Future<List<UserDate2>> fetchUserDates(userId) async {
    final result = await apiService.getData<UserDate2>(
      builder: (data) => UserDate2.fromJson(data),
      path: APIPath.userDatesList(userId),
    );
    return result;
  }

  @override
  fetchMyFavoriteProducts(userId) {
    // TODO: implement getMyFavoriteProducts
    throw UnimplementedError();
  }

  @override
  Future<List<UserOrder>> fetchUserPreviousOrders(userId) {
    return apiService.getData<UserOrder>(
      path: APIPath.userOrdersList(userId),
      builder: (data) => UserOrder.fromJson(data),
    );
  }

  // @override
  // Future<UserOrder> fetchUserPreviousOrders(userId) {
  //   return apiService.getObject<UserOrder>(
  //     path: APIPath.userOrdersList(userId),
  //     builder: (data) => UserOrder.fromJson(data),
  //   );
  // }

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
  Future fetchSubSectionsList() {
    return apiService.getData<SubSection>(
      builder: (data) => SubSection.fromJson(data),
      path: APIPath.subSectionsList(),
    );
  }

  @override
  Future fetchSubSectionsListBySectionId(String? sectionId) {
    return apiService.getData<SubSection>(
      builder: (data) => SubSection.fromJson(data),
      path: APIPath.subSectionsListBySectionId(sectionId),
    );
  }

  @override
  Future fetchServicesList(String? subSectionId) {
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
  Future<List<String>> fetchAllDatesForService(String? serviceId, String formattedDateStr) {
    return apiService.getData<String>(
      builder: (data) => data.toString(),
      path: APIPath.allDatesForService(serviceId, formattedDateStr),
    );
  }

  @override
  Future fetchProductReviews(String? productId) {
    return apiService.getData<ProductReview>(
      builder: (data) => ProductReview.fromJson(data),
      path: APIPath.productReviews(productId),
    );
  }

  @override
  Future fetchClinicWorksList() {
    return apiService.getData<ClinicWork>(
      builder: (data) => ClinicWork.fromJson(data),
      path: APIPath.clinicWorksList(),
    );
  }

  @override
  Future fetchClinicWorksBySectionId(String sectionId) {
    return apiService.getData<ClinicWork>(
      builder: (data) => ClinicWork.fromJson(data),
      path: APIPath.clinicWorksListById(sectionId),
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

  @override
  Future<PostResponse> updateUserProfile(ProductReviewRequest request, String userId) {
    return apiService.putObject<CreateOrderRequest>(
      path: APIPath.updateUserProfile(userId),
      body: request.toJson(),
    );
  }
}
