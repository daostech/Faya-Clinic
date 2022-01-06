import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class HorizontalItemsSection<T> extends StatelessWidget {
  const HorizontalItemsSection({
    Key key,
    this.sectionHeader,
    this.items,
    this.itemBuilder,
    this.maxItems,
    this.moreButtonEnabled = false,
    this.onLoadMore,
  }) : super(key: key);
  final String sectionHeader;
  final List<T> items;
  final int maxItems;
  final bool moreButtonEnabled;
  final Function(BuildContext, int) itemBuilder;
  final Function onLoadMore;

  @override
  Widget build(BuildContext context) {
    final itemsCount = maxItems != null && maxItems < items?.length ? maxItems : items?.length ?? 0;

    Widget builder(BuildContext context, int indx) {
      if (moreButtonEnabled && indx == itemsCount && itemsCount > 1) {
        return Container(
          width: 200,
          child: IconButton(
            onPressed: onLoadMore,
            icon: Icon(Icons.arrow_forward_ios_outlined),
          ),
        );
      }
      return itemBuilder(context, indx);
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: marginLarge),
            child: Text(
              sectionHeader,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: marginLarge),
          child: Divider(
            thickness: 0.5,
            color: Colors.black87,
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: moreButtonEnabled && itemsCount > 1 ? itemsCount + 1 : itemsCount,
            scrollDirection: Axis.horizontal,
            itemBuilder: builder,
          ),
        ),
      ],
    );
  }
}
