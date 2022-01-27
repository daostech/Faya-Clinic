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
  static String userProfile() => 'api/user/list';

  static String userDatesList(String userId) => 'api/DatesRegistered/userDates/$userId';
  static String allDatesOn(String dateTimeStr) => 'api/DatesRegistered/$dateTimeStr';
  static String userOrdersList(String sectionId) => 'api/Clinics/list';

  static String createUser() => 'api/User';
  static String createOrder() => 'api/Order';
  static String createDate() => 'api/DatesRegistered';
}
