import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dalily/config/local/cache_helper.dart';
import 'package:dalily/config/routes/app_routes.dart';
import 'package:dalily/core/utils/app_constants.dart';
import 'package:dalily/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigateToOnBoardingView();
    super.initState();
  }

  void navigateToOnBoardingView() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (CacheHelper.getBoolean(key: 'onBoarding') ?? false) {
        if (CacheHelper.getString(key: 'uId') != null) {
          return Navigator.pushReplacementNamed(context, Routes.landingView);
        } else {
          return Navigator.pushReplacementNamed(context, Routes.loginView);
        }
      } else {
        return Navigator.pushReplacementNamed(context, Routes.onBoardingView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppConstants.systemUiOverlayStyleDark,
        child: SplashViewBody(),
      ),
    );
  }
}
