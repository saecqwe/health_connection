import 'package:flutter/material.dart';

class DottedSeperatorView extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const DottedSeperatorView({Key? key, this.width, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 8.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 1000,
        itemBuilder: (context, index) => ClipOval(
          child: Container(
            margin: const EdgeInsets.all(3.0),
            width: width ?? 1.0,
            color: color ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}
