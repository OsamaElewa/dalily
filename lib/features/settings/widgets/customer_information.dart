import 'package:dalily/features/calender/full_screen_image.dart';
import 'package:dalily/features/settings/logic/image_profile_cubit/image_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../logic/image_profile_cubit/image_profile_state.dart';

class CustomerInformation extends StatelessWidget {
  const CustomerInformation({super.key});

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
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: IconButton(onPressed: () {
                    ImageProfileCubit.get(context).deleteImage();
                  }, icon: Icon(Icons.delete,size: 25,color: Colors.red,)),
                )
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
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: IconButton(onPressed: () {
                    ImageProfileCubit.get(context).uploadImage();
                  }, icon: Icon(Icons.edit,size: 25,color: Colors.blue,)),
                )
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



