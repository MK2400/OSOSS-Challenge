import 'dart:async';


import 'package:flutter/material.dart';
import 'package:ososs/core/resources/app_constants.dart';
import 'package:ososs/core/routes/routes.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late Timer _timer;


  _startDelay() {
    _timer = Timer(const Duration(milliseconds: AppConst.splashDelay), _goNext);
  }

  void _goNext() async {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return  Scaffold(
        body: Center(
          child: SizedBox(
              width: size.width*.6,
              height: size.height*.6 ,
              child: const FlutterLogo()),
        ));
  }
}

