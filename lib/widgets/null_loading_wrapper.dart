import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class NullLoadingWrapper<T> extends StatelessWidget {
  const NullLoadingWrapper({
    Key? key,
    this.data,
    this.errorWidget,
    this.loadingWidget,
    required this.child,
    this.isLoading,
    this.onRetry,
    this.errorMessage,
  }) : super(key: key);
  final T? data;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget child;
  final Function? onRetry;
  final bool? isLoading;
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildContent(),
    );
  }

  Widget buildContent() {
    // final items = [data];
    if (data == null) {
      if (isLoading!)
        return loadingWidget ??
            Container(
              height: 220,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
      return errorWidget ??
          MyErrorWidget(
            onTap: onRetry,
            error: errorMessage ?? "Error loading data !",
          );
    }
    return child;
  }
}
