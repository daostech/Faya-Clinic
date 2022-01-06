import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/category.dart';
import 'package:faya_clinic/screens/store/store_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class ProductExpandedFilter extends StatelessWidget {
  ProductExpandedFilter({Key key, @required this.controller}) : super(key: key);
  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(
          Icons.filter_alt_outlined,
          color: colorPrimary,
        ),
        title: Text(
          TransUtil.trans("label_filter"),
          style: TextStyle(
            fontSize: fontSizeStandard,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];

    if (controller.categories == null || controller.categories.isEmpty) {
      if (controller.isLoading)
        children = [Container(height: 70, child: Center(child: CircularProgressIndicator()))];
      else
        children = [
          MyErrorWidget(
            onTap: controller.fetchAllCategories,
            error: "Error loading data !",
          )
        ];
    } else
      children = controller.categories.map((element) => _buildCheckBoxTile(element)).toList();

    return children;
  }

  Widget _buildCheckBoxTile(Category category) {
    return CheckboxListTile(
      activeColor: Colors.pink[300],
      dense: true,
      title: new Text(
        category.name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
      value: controller.isSelectedCategory(category),
      onChanged: (_) => controller.toggleCategory(category),
    );
  }
}
