import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/null_loading_wrapper.dart';
import 'package:flutter/material.dart';

class HorizontalItemsSection<T> extends StatelessWidget {
  const HorizontalItemsSection({
    Key key,
    @required this.sectionHeader,
    @required this.items,
    @required this.itemBuilder,
    @required this.isLoading,
    this.maxItems,
    this.moreButtonEnabled = false,
    this.onLoadMore,
    this.onRetry,
  }) : super(key: key);
  final String sectionHeader;
  final List<T> items;
  final int maxItems;
  final bool moreButtonEnabled;
  final bool isLoading;
  final Function(BuildContext, int) itemBuilder;
  final Function onLoadMore;
  final Function onRetry;

  int get itemsCountn {
    if (maxItems == null || items == null) return 0;
    return maxItems < items.length ? maxItems : items.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = TransUtil.isArLocale(context);
    final itemsCount = maxItems != null && items != null && maxItems < items?.length ? maxItems : items?.length ?? 0;

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
          alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
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
          child: NullLoadingWrapper(
            isLoading: isLoading,
            data: items,
            onRetry: onRetry,
            child: ListView.builder(
              itemCount: moreButtonEnabled && itemsCount > 1 ? itemsCount + 1 : itemsCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: builder,
            ),
          ),
        ),
      ],
    );
  }
}
