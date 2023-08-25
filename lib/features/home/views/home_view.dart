import 'package:flutter/material.dart';
import 'package:ososs/core/resources/app_strings.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';
import 'package:ososs/core/shared_widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: AppStrings.enterYourName,
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  _nameController.text.isEmpty
                      ? AppStrings.yourName
                      : _nameController.text,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const Spacer(flex: 5,),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _nameController.clear();
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppColors.warning,
                      ),
                      Text(
                        AppStrings.clearText,
                        style: TextStyle(color: AppColors.warning),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SimpleButton(
                onPressed: () {},
              backgroundColor: AppColors.accentColor,
                title:AppStrings.goToPage1 ,),
            const SizedBox(height: 15,),
            SimpleButton(
              onPressed: () {},
              title: AppStrings.goToPage1,
            ),
          ],
        ),
      ),
    );
  }
}
