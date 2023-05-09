import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:health_connection/utils/formatters/time_formatter.dart';

class CustomButtons {
  static Widget customOutLinedButton(
      {Function()? onTap,
      required Widget widget,
      Color? borderColor,
      BorderRadiusGeometry? borderRadius}) {
    return OutlinedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor ?? AppColors.lightGreyColor),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(0.0),
        ),
      ),
      child: widget,
    );
  }

  static Widget customElevatedButton(
      {Function()? onTap,
      required Widget widget,
      Color? buttonColor,
      BorderRadiusGeometry? borderRadius}) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(buttonColor ?? AppColors.appColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(5.0),
            ))),
        onPressed: onTap,
        child: widget);
  }

  static Widget customPopUpButton(
      {required List<PopupMenuEntry<int>> popUpItem, Color? iconColor}) {
    return PopupMenuButton<int>(
      icon: Icon(
        Icons.more_vert_rounded,
        color: iconColor ?? Colors.white,
      ),
      itemBuilder: (context) => popUpItem,
      offset: const Offset(0, 50),
      elevation: 2,
    );
  }

  static Widget customCountDownElevatedButton(
      {Function()? onTap,
      required String text,
      Color? buttonActiveColor,
      Color? buttonDisableColor,
      required int duration}) {
    return CountdownButton(
      color: buttonActiveColor,
      disabledColor: buttonDisableColor,
      duration: duration,
      onPressed: onTap,
      text: text,
    );
  }
}

class CountdownButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? disabledColor;
  final int duration;
  final Function()? onPressed;

  const CountdownButton({
    Key? key,
    required this.text,
    this.color,
    this.disabledColor,
    required this.duration,
    this.onPressed,
  }) : super(key: key);

  @override
  CountdownButtonState createState() => CountdownButtonState();
}

class CountdownButtonState extends State<CountdownButton> {
  late Timer _timer;
  int _timeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimerTick(Timer timer) {
    setState(() {
      if (_timeRemaining > 0) {
        _timeRemaining--;
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value:
                  _timeRemaining.toDouble() / widget.duration, // percent filled
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.appColor),
              backgroundColor: widget.disabledColor ?? AppColors.appLightColor,
            ),
          ),
        ),
        Positioned(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.text}  ${TimeFormatter.formattedTime(timeInSecond: _timeRemaining)}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.whiteColor),
              textAlign: TextAlign.center,
            ),
          ),
        )),
      ],
    );
  }
}
