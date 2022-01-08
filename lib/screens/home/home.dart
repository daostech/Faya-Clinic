import 'package:carousel_slider/carousel_slider.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/home_slider.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/screens/clinic/clinic_offers_details.dart';
import 'package:faya_clinic/screens/clinic/clinic_sub_sections.dart';
import 'package:faya_clinic/screens/home/home_controller.dart';
import 'package:faya_clinic/screens/product_details_screen.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/item_section.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/item_staff.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:faya_clinic/widgets/null_loading_wrapper.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:faya_clinic/widgets/section_horizontal_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._({Key key, @required this.controller}) : super(key: key);
  final HomeController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final favoriteRepo = Provider.of<FavoriteRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(database: database, favoriteRepository: favoriteRepo),
      builder: (ctx, child) {
        return Consumer<HomeController>(
          builder: (context, controller, _) => HomeScreen._(controller: controller),
        );
      },
    );
  }

  void _goTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_home"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSliders(),
            _buildUserPoints(),
            _buildLastOffersSection(context),
            _buildLastProductsSection(context),
            _buildClinicSections(context),
            _buildClinicStaff(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliders() {
    return NullLoadingWrapper<List<HomeSlider>>(
      data: controller.sliders,
      isLoading: controller.isLoading,
      onRetry: controller.fetchHomeSliders,
      child: CarouselSlider(
        items: controller.sliders
            ?.map(
              (e) => Center(
                child: NetworkCachedImage(
                  imageUrl: e.image,
                ),
              ),
            )
            ?.toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {},
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildUserPoints() {
    return Container(
      // user points container
      margin: const EdgeInsets.symmetric(
        horizontal: marginLarge,
        vertical: marginLarge,
      ),
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(marginLarge),
        child: Row(
          children: [
            // SvgPicture.asset(""),
            SizedBox(
              width: marginLarge,
            ),
            Text(
              TransUtil.trans("label_your_points") + " 500",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastProductsSection(context) {
    return NullLoadingWrapper<List<Product>>(
      isLoading: controller.isLoading,
      data: controller.lastProducts,
      onRetry: controller.fetchNewArrivalsProducts,
      child: HorizontalItemsSection(
        sectionHeader: TransUtil.trans("header_new_arrivals"),
        items: controller.lastProducts,
        // moreButtonEnabled: true,
        // maxItems: 5,
        itemBuilder: (_, index) => ProductItem(
          product: controller.lastProducts[index],
          isFavorite: controller.isFavoriteProduct(controller.lastProducts?.elementAt(index)),
          onFavoriteToggle: (product) => controller.toggleFavorite(product),
          onTap: () => _goTo(
            context,
            ProductDetailsScreen(
              product: controller.lastProducts[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastOffersSection(context) {
    return NullLoadingWrapper<List<Offer>>(
      data: controller.lastOffers,
      isLoading: controller.isLoading,
      onRetry: controller.fetchOffers,
      child: HorizontalItemsSection(
        sectionHeader: TransUtil.trans("header_last_offers"),
        items: controller.lastOffers,
        moreButtonEnabled: true,
        maxItems: 2,
        onLoadMore: () {
          print("onLoadMore clicked");
        },
        itemBuilder: (_, index) => SectionItem(
          title: controller.lastOffers[index].title,
          subTitle: controller.lastOffers[index].description,
          image: controller.lastOffers[index].randomImage,
          onTap: () => _goTo(context, ClinicOfferDetailsScreen(offer: controller.lastOffers[index])),
        ),
      ),
    );
  }

  Widget _buildClinicSections(context) {
    return NullLoadingWrapper<List<Section>>(
      data: controller.sectionsList,
      isLoading: controller.isLoading,
      onRetry: controller.fetchSections,
      child: HorizontalItemsSection(
        sectionHeader: TransUtil.trans("header_clinic_sections"),
        items: controller.sectionsList,
        itemBuilder: (_, index) => SectionItem(
          title: controller.sectionsList[index].name,
          subTitle: controller.sectionsList[index].description,
          image: controller.sectionsList[index].image,
          onTap: () => _goTo(context, ClinicSubSectionsScreen(sectionId: controller.sectionsList[index].id)),
        ),
      ),
    );
  }

  Widget _buildClinicStaff() {
    return NullLoadingWrapper<List<Team>>(
      data: controller.teamsList,
      isLoading: controller.isLoading,
      onRetry: controller.fetchTeamsList,
      child: HorizontalItemsSection(
        sectionHeader: TransUtil.trans("header_our_staff"),
        items: controller.teamsList,
        itemBuilder: (_, index) => StaffItem(
          team: controller.teamsList[index],
        ),
      ),
    );
  }
}
