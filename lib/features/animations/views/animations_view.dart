import 'package:flutter/material.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';
import 'package:ososs/core/shared_widgets/custom_shape.dart';
import 'package:ososs/features/animations/models/animtion_model.dart';

class AnimationsView extends StatelessWidget {
  final String name;

  AnimationsView({super.key, required this.name});

  final ValueNotifier<AnimationModel> animateNotifier =
      ValueNotifier(AnimationModel(
          borderRadius: const BorderRadius.all(
            Radius.circular(1.0),
          ),
          color: AppColors.darkPurple));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: const Text('Animations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Center(
              child: ValueListenableBuilder<AnimationModel>(
                  valueListenable: animateNotifier,
                  builder: (context, val, child) {
                    return AnimatedContainer(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        color: val.color,
                        borderRadius: val.borderRadius,
                      ),
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  }),
            ),
            const Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomShape(
                    onTap: () {
                      animateNotifier.value = _getAnimationModel(1);
                    },
                    color: AppColors.darkPurple,
                    radius: const Radius.circular(1.0),
                  ),
                  CustomShape(
                    onTap: () {
                      animateNotifier.value = _getAnimationModel(2);
                    },
                    color: AppColors.lightCyan,
                    radius: const Radius.circular(15.0),
                  ),
                  CustomShape(
                    onTap: () {
                      animateNotifier.value = _getAnimationModel(3);
                    },
                    boxShape: BoxShape.circle,
                    color: AppColors.lightRed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimationModel _getAnimationModel(int numberOfShape) {
    switch (numberOfShape) {
      case 1:
        return AnimationModel(
            borderRadius: const BorderRadius.all(
              Radius.circular(1.0),
            ),
            color: AppColors.darkPurple);

      case 2:
        return AnimationModel(
            borderRadius: const BorderRadius.all(
              Radius.circular(40.0),
            ),
            color: AppColors.lightCyan);
      case 3:
        return AnimationModel(
            borderRadius: BorderRadius.circular(156),
            color: AppColors.lightRed);
      default:
        return AnimationModel(
            borderRadius: const BorderRadius.all(
              Radius.circular(1.0),
            ),
            color: AppColors.darkPurple);
    }
  }
}
