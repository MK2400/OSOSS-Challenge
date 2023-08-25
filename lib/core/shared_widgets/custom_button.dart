import 'package:flutter/material.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final String? title;
  final bool? isRounded;
  final Widget? child;
  final double? height;

  const CustomButton(
      {Key? key,
      this.backgroundColor,
      this.height,
      this.child,
      this.isRounded = true,
      required this.onPressed,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 400
      ),
      height: height,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.zero,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
            padding:  const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isRounded! ? 10 : 0)),
          ),
          onPressed: onPressed,
          child: child ??
              Text(
                title ?? '',
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
        ),
      ),
    );
  }
}
