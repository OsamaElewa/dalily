import 'package:dalily/features/calender/full_screen_image.dart';
import 'package:dalily/features/settings/logic/image_profile_cubit/image_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../settings/logic/image_profile_cubit/image_profile_state.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageProfileCubit()..getImageUrl(),
      child: BlocBuilder <ImageProfileCubit, ImageProfileState>(
        builder: (context, state) {
          if (state is GetImageSupabaseSuccessState) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imagePath: state.url),)),
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary,width: 3),
                        image: DecorationImage(
                            image: NetworkImage(state.url),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
              ],
            );
          }
          else if (state is GetImageSupabaseFailureState) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary,width: 3),
                      image: DecorationImage(
                          image: AssetImage('assets/images/graduated.png'),
                          fit: BoxFit.fill
                      )
                  ),
                ),

              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



