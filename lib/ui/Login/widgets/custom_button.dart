import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final Future<void> Function()? onPressed;
  final bool isSecondary;

  const CustomButton({
    Key? key,
    required this.text,
    required this.width,
    required this.onPressed,
    this.isSecondary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: isSecondary ? Colors.white : Color(0xFF35478E),
        borderRadius: BorderRadius.circular(5),
        border: isSecondary
            ? Border.all(color: Colors.black.withOpacity(0.3))
            : null,
        boxShadow: isSecondary
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isSecondary ? 15 : 16,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSecondary ? Color(0xFF35478E) : Colors.white,
                fontFamily: 'Roboto Mono',
                fontSize: isSecondary ? 13 : 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}