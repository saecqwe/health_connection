import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String message;
  final String imageUrl;

  const NoDataFoundWidget({
    super.key,
    required this.message,
    this.imageUrl = 'https://www.gitaa.in/img/NoRecordFound.png',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 120.0,
            width: 120.0,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
