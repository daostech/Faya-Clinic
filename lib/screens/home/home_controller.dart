import 'package:faya_clinic/models/home_slider.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  static const TAG = "[HomeController] ";
  static const ERR = "[Error] ";

  HomeController({@required this.favoriteRepository, @required this.database}) {
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  final Database database;
  // final FavoriteProductsProvider favoriteProductsProvider;
  final FavoriteRepositoryBase favoriteRepository;

  static List<HomeSlider> _sliders;
  static List<Offer> _lastOffers;
  static List<Team> _teamsList;
  static List<Section> _sectionsList;
  static List<Product> _lastProducts;
  static List<Product> _favoriteProducts = [];

  var isLoading = true;
  bool _mounted = true;
  bool get mounted => _mounted;

  List<HomeSlider> get sliders => _sliders;
  List<Offer> get lastOffers => _lastOffers;
  List<Product> get lastProducts => _lastProducts;
  List<Team> get teamsList => _teamsList;
  List<Section> get sectionsList => _sectionsList;

  // List get favoriteProducts => favoriteProductsProvider.favoriteProducts;
  List get favoriteProducts => _favoriteProducts;

  void init() async {
    _favoriteProducts?.clear();
    _favoriteProducts.addAll(favoriteRepository.allProducts);
    await fetchHomeSliders();
    await fetchOffers();
    await fetchTeamsList();
    await fetchSections();
    await fetchNewArrivalsProducts();
    // favoriteRepository.deleteAll();
  }

  void toggleFavorite(Product product) {
    print("$TAG toggleFavorite called");
    if (product == null) return;
    if (isFavoriteProduct(product)) {
      _favoriteProducts.removeWhere((element) => element.id == product.id);
    } else
      _favoriteProducts.add(product);
    favoriteRepository.toggleProduct(product);
    if (mounted) notifyListeners();
  }

  Future<void> fetchHomeSliders() async {
    updateWith(loading: true);
    print("$TAG fetchHomeSliders: called");
    final result = await database.getHomeSliders().catchError((error) {
      print("$TAG [Error] fetchHomeSliders : $error");
    });
    updateWith(sliders: result, loading: false);
  }

  Future<void> fetchOffers() async {
    updateWith(loading: true);
    print("$TAG fetchOffers: called");
    final result = await database.fetchOffersList().catchError((error) {
      print("$TAG [Error] fetchOffers : $error");
    });
    updateWith(offers: result, loading: false);
  }

  Future<void> fetchTeamsList() async {
    updateWith(loading: true);
    print("$TAG fetchTeamsList: called");
    final result = await database.getTeamsList().catchError((error) {
      print("$TAG [Error] fetchTeamsList : $error");
    });
    updateWith(teams: result, loading: false);
  }

  Future<void> fetchSections() async {
    updateWith(loading: true);
    print("$TAG fetchSections: called");
    final result = await database.fetchSectionsList().catchError((error) {
      print("$TAG [Error] fetchSections : $error");
    });
    updateWith(sections: result, loading: false);
  }

  Future<void> fetchNewArrivalsProducts() async {
    updateWith(loading: true);
    print("$TAG fetchNewArrivalsProducts: called");
    // todo change the request or filter to get only new arraivals
    final result = await database.fetchProductsList().catchError((error) {
      print("$TAG [Error] fetchNewArrivalsProducts : $error");
    });
    print("fetchNewArrivalsProducts: result lngth ${result?.length}");
    updateWith(newArrivals: result, loading: false);
  }

  bool isFavoriteProduct(Product product) {
    if (product == null) return false;
    return _favoriteProducts.firstWhere((element) => element.id == product.id, orElse: () => null) != null;
  }

  void updateWith({
    bool loading,
    List<HomeSlider> sliders,
    List<Team> teams,
    List<Section> sections,
    List<Offer> offers,
    List<Product> newArrivals,
    List<Product> favoriteProducts,
  }) {
    isLoading = loading ?? isLoading;
    _sliders = sliders ?? _sliders;
    _teamsList = teams ?? _teamsList;
    _sectionsList = sections ?? _sectionsList;
    _lastOffers = offers ?? _lastOffers;
    _lastProducts = newArrivals ?? _lastProducts;
    _favoriteProducts = favoriteProducts ?? _favoriteProducts;
    if (mounted) notifyListeners();
  }
}
