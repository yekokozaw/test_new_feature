import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorCountryWidget extends StatelessWidget {
  const ErrorCountryWidget({super.key, required this.errorCountry, required this.tryAgain});

  final String  errorCountry;
  final Function() tryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(errorCountry),
        const SizedBox(height: 16),
        FilledButton(
            onPressed: tryAgain, child: const Text('Try Again'))
      ],
    );
  }
}
