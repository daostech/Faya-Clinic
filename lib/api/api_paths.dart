import 'package:faya_clinic/constants/config.dart';

class APIPath {
  static String sectionsList() => '${AppConfig.API_ENDPATH}Section/list';
  static String sectionById(String sectionId) => '${AppConfig.API_ENDPATH}Section/$sectionId';
  static String subSectionsList(String sectionId) => '${AppConfig.API_ENDPATH}SubSection/$sectionId/list';

  static String clinicsList(String sectionId) => '${AppConfig.API_ENDPATH}Clinics/list';
  static String categoriesList() => '${AppConfig.API_ENDPATH}Categories/list';

  static String productsList() => '${AppConfig.API_ENDPATH}Products/list';
  static String productReviews(String productId) => '${AppConfig.API_ENDPATH}Comments/$productId';
  static String postProductReview() => '${AppConfig.API_ENDPATH}Comments';
  static String newArrivalsProductsList() => '${AppConfig.API_ENDPATH}Products/list';
  static String servicesList(String subSectionId) => '${AppConfig.API_ENDPATH}Service/$subSectionId/list';
  static String slidersList() => '${AppConfig.API_ENDPATH}Sliders/list';
  static String offersList() => '${AppConfig.API_ENDPATH}Offers/list';
  static String teamsList() => '${AppConfig.API_ENDPATH}Team/list';
  static String getUserProfile(String userId) => '${AppConfig.API_ENDPATH}UsersMobile/byId/$userId';
  static String updateUserProfile(String userId) => '${AppConfig.API_ENDPATH}UsersMobile/$userId';

  static String userDatesList(String userId) => '${AppConfig.API_ENDPATH}DatesRegistered/userDates/$userId';
  static String allDatesOn(String dateTimeStr) => '${AppConfig.API_ENDPATH}DatesRegistered/date/$dateTimeStr';
  static String userOrdersList(String userId) => '${AppConfig.API_ENDPATH}Orders/userOrders/$userId';

  static String createUser() => '${AppConfig.API_ENDPATH}UsersMobile';
  static String createOrder() => '${AppConfig.API_ENDPATH}Orders';
  static String createDate() => '${AppConfig.API_ENDPATH}DatesRegistered';

  static String fetchCoupon(String code) => '${AppConfig.API_ENDPATH}Coupons/filter/$code';
}
