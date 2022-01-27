import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/requests/product_review_request.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsController with ChangeNotifier {
  static const TAG = "ProductDetailsController: ";
  final Database database;
  final Product product;
  // todo add auth repo

  ProductDetailsController({this.product, this.database}) {
    print("$TAG product id: ${product.id}");
    init();
  }

  final reviewTxtController = TextEditingController();

  List _reviews;

  var _loading = true;
  var _postingReview = false;
  var initialRate = 3;
  var _review = "";

  bool get isLoading => _loading;
  bool get postingReview => _postingReview;
  // int get reviewsCount => _comments?.length ?? 0;
  int get reviewsCount => 5;

  List get allReviews => _reviews;

  List get topReviews {
    if (_reviews == null) return null;
    if (_reviews.length < 4)
      return _reviews;
    else
      return _reviews?.sublist(0, 3);
  }

  init() async {
    fetchProductReviews();
  }

  Future<bool> postReview() async {
    updateWith(posting: true);
    print("$TAG postReview: called");
    final request = ProductReviewRequest(
      userId: "bbbf3cfa-6d01-4382-91e1-0c20a2adffad", // ! update it with the actual user id
      productId: product.id,
      text: _review,
      rate: initialRate,
    );
    final result = await database.postProductReview(request).catchError((error) {
      print("$TAG [Error] postReview : $error");
      return false;
    });

    if (result != null) {
      fetchProductReviews();
      reviewTxtController.text = "";
    }
    updateWith(posting: false, review: "");
    return true;
  }

  Future<void> fetchProductReviews() async {
    updateWith(loading: true);
    print("$TAG fetchProductReviews: called");
    // if (_allProducts != null) return _allProducts;
    await Future.delayed(Duration(seconds: 2));
    final result = await database.fetchProductReviews(product.id).catchError((error) {
      print("$TAG [Error] fetchProductReviews : $error");
    });
    updateWith(reviews: result, loading: false);
  }

  void updateWith({bool loading, List reviews, String review, bool posting}) {
    _loading = loading ?? _loading;
    _postingReview = posting ?? _postingReview;
    _reviews = reviews ?? _reviews;
    _review = review ?? _review;
    notifyListeners();
  }
}
