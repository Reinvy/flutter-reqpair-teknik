import 'package:flutter/material.dart';

defaultLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
