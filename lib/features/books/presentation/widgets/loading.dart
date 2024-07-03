import 'package:flutter/material.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
