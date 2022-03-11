class APIPath {
  static String sectionsList() => 'api/Section/list';
  static String sectionById(String sectionId) => 'api/Section/$sectionId';
  static String subSectionsList(String sectionId) => 'api/SubSection/$sectionId/list';

  static String clinicsList(String sectionId) => 'api/Clinics/list';
  static String categoriesList() => 'api/Categories/list';

  static String productsList() => 'api/Products/list';
  static String productReviews(String productId) => 'api/Comments/$productId';
  static String postProductReview() => 'api/Comments';
  static String newArrivalsProductsList() => 'api/Products/list';
  static String servicesList(String subSectionId) => 'api/Service/$subSectionId/list';
  static String slidersList() => 'api/Sliders/list';
  static String offersList() => 'api/Offers/list';
  static String teamsList() => 'api/Team/list';
  static String userProfile(String userId) => 'api/UsersMobile/byId/$userId';

  static String userDatesList(String userId) => 'api/DatesRegistered/userDates/$userId';
  static String allDatesOn(String dateTimeStr) => 'api/DatesRegistered/date/$dateTimeStr';
  static String userOrdersList(String sectionId) => 'api/Clinics/list';

  static String createUser() => 'api/UsersMobile';
  static String createOrder() => 'api/Orders';
  static String createDate() => 'api/DatesRegistered';

  static String fetchCoupon(String code) => 'api/Coupons/filter/$code';
}
