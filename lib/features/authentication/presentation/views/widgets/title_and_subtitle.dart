import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_styles.dart';


class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle(
      {Key? key, required this.subtitle, required this.title})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.textStyle30,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: AppConstants.padding5h, bottom: AppConstants.defaultPadding),
          child: Text(
            subtitle,
            style: AppStyles.textStyle16.copyWith(color: AppColors.grey),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
