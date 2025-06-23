import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)...{
          Container(
            color: AppColors.black.withOpacity(0.7),
          ),
          const Center(
            child: CircularProgressIndicator(color: AppColors.primary,),
          ),
          }
      ],
    );
  }
}
