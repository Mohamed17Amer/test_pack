import 'package:flutter/material.dart';


 buildErrorWidget(String errMessage) {
   SnackBar(
    content: Text(
      errMessage,
      style: const TextStyle(),
    ),
    duration: const Duration(seconds: 3),
  );
}
