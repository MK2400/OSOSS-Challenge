import 'package:flutter/material.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';

class CustomShape extends StatelessWidget {
  final VoidCallback onTap;
  final BoxShape boxShape;
  final Radius radius;
  final Color color;

  const CustomShape(
      {super.key,
      required this.onTap,
      required this.color,
       this.radius=const Radius.circular(1.0),
      this.boxShape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primaryColor,
      hoverColor: AppColors.white,
      onTap: onTap,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape:  boxShape,
          borderRadius: (boxShape == BoxShape.circle)?null: BorderRadius.all(
            radius,
          ),
          color: color,
        ),
      ),
    );
  }
}
