import 'package:flutter/material.dart';

class BuildErrorWidget extends StatelessWidget {
  final String errMessage;

  const BuildErrorWidget({super.key, required this.errMessage});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      
    content: Text(
      errMessage,
      style: const TextStyle(),
    ),
    duration: const Duration(seconds: 3),
  );

  }
}

