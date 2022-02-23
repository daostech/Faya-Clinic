import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/product_review.dart';
import 'package:faya_clinic/models/requests/product_review_request.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsController with ChangeNotifier {
  static const TAG = "ProductDetailsController: ";
  final Database database;
  final Product product;
  final AuthRepositoryBase authRepository;

  ProductDetailsController({@required this.product, @required this.database, @required this.authRepository}) {
    init();
  }

  final reviewTxtController = TextEditingController();

  List<ProductReview> _reviews;

  final topReviewsCount = 3;
  var initialRate = 3;
  var _loading = true;
  var _postingReview = false;
  var _userReview = "";

  bool get isLoading => _loading;
  bool get postingReview => _postingReview;
  bool get showAllReviewsEnabled => _reviews.length > topReviewsCount;

  List get allReviews => _reviews;

  List get topReviews {
    if (_reviews == null) return null;
    if (_reviews.length <= topReviewsCount)
      return _reviews;
    else {
      // get the last 3 reviews
      _reviews.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      return _reviews.sublist(_reviews.length - topReviewsCount, _reviews.length);
    }
  }

  init() async {
    fetchProductReviews();
  }

  Future<bool> postReview() async {
    updateWith(posting: true);
    print("$TAG postReview: called");
    final request = ProductReviewRequest(
      userId: authRepository.userId,
      productId: product.id,
      text: _userReview,
      rate: initialRate,
    );
    final result = await database.postProductReview(request).catchError((error) {
      print("$TAG [Error] postReview : $error");
    });

    if (result != null) {
      fetchProductReviews(true);
      reviewTxtController.text = "";
    }
    updateWith(posting: false, review: "");
    return result.success;
  }

  Future<void> fetchProductReviews([bool ignoreStartLoading = false]) async {
    if (!ignoreStartLoading) updateWith(loading: true);
    print("$TAG fetchProductReviews: called");
    // await Future.delayed(Duration(seconds: 2));
    final result = await database.fetchProductReviews(product.id).catchError((error) {
      print("$TAG [Error] fetchProductReviews : $error");
    });
    updateWith(reviews: result, loading: false);
  }

  void updateWith({bool loading, List reviews, String review, bool posting}) {
    _loading = loading ?? _loading;
    _postingReview = posting ?? _postingReview;
    _reviews = reviews ?? _reviews;
    _userReview = review ?? _userReview;
    notifyListeners();
  }
}
