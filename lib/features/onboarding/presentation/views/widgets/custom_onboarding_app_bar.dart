import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/local/cache_helper.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/logo_widget.dart';

class CustomOnBoardingAppBar extends StatelessWidget {
  const CustomOnBoardingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LogoWidget(height: 60.h,),
        CustomTextButton(
          title: 'Skip',
          fontSize: 18.sp,
          onPressed: () {
            CacheHelper.setBoolean(key: 'onBoarding', value: true)
                .then((value) {
              Navigator.pushReplacementNamed(context, Routes.loginView);
            });
          },
        ),
      ],
    );
  }
}
