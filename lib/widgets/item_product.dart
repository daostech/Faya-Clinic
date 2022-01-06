import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final ValueSetter<Product> onFavoriteToggle;
  final Function onTap;
  const ProductItem({
    Key key,
    @required this.product,
    this.isFavorite = false,
    this.onFavoriteToggle,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imgWidth = 80.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(
        Radius.circular(radiusStandard),
      ),
      child: Container(
        // main  container
        padding: const EdgeInsets.fromLTRB(0, marginStandard, marginStandard, 0),
        margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radiusStandard),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              // product name and favorite button container
              padding: const EdgeInsets.symmetric(
                horizontal: marginStandard,
                vertical: marginLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        product?.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: marginSmall,
                  ),
                  InkWell(
                    onTap: () => onFavoriteToggle(product),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  // image main container
                  width: _imgWidth,
                  height: _imgWidth,
                  child: CachedNetworkImage(
                    imageUrl: product.randomImage ??
                        "https://retailminded.com/wp-content/uploads/2016/03/EN_GreenOlive-1.jpg",
                    progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    //error image when user have a picture but failed to load it
                    errorWidget: (context, url, error) => Container(
                      padding: EdgeInsets.all(marginStandard),
                      height: _imgWidth,
                      width: _imgWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  // add to cart button container
                  onTap: () {},
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(marginSmall),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusStandard),
                      ),
                    ),
                    child: FittedBox(
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    product.price.toString(),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
