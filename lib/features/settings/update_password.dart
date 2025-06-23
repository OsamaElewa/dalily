import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/icons/icons_broken.dart';
import '../../core/functions/show_snack_bar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/gradient_button.dart';
import 'logic/update_password_cubit/update_password_cubit.dart';
import 'logic/update_password_cubit/update_password_state.dart';



class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: Scaffold(
        body: BlocConsumer<UpdatePasswordCubit,UpdatePasswordState>(
          listener: (context, state) {
            if(state is UpdatePasswordSuccessState){
              showSuccessSnackBar(context: context, message: 'تم تغيير كلمة السر بنجاح');
              Navigator.pop(context);
            }else if(state is UpdatePasswordFailureState){
              showErrorSnackBar(context: context, message: 'فشل في تغيير كلمة السر');
            }
          },
          builder: (context, state) {
            return CustomLoading(
              isLoading: state is UpdatePasswordLoadingState,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667eea),
                      Color(0xFF764ba2),
                    ],
                  ),
                ),
                child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  'تغيير كلمة السر',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 48), // Balance the back button
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(25),
                                child: Form(
                                  key: UpdatePasswordCubit.get(context).formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        textInputType: TextInputType.visiblePassword,
                                        obscureText: UpdatePasswordCubit.get(context).isShowOldPassword,
                                        prefixIcon: const Icon(IconBroken.Lock),
                                        paddingForBottom: AppConstants.padding20h,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            UpdatePasswordCubit.get(context).changeOldPasswordVisibility();
                                          },
                                          child: Icon(
                                            UpdatePasswordCubit.get(context).isShowPassword
                                                ? IconBroken.Hide
                                                : IconBroken.Show,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        controller: UpdatePasswordCubit.get(context).oldPasswordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك ادخل كلمة السر القديمة';
                                          }

                                          return null;
                                        },
                                        title: 'كلمة السر القديمة',
                                        hintText: 'ادخل كلمة السر القديمة',
                                      ),
                                      SizedBox(height: 20.h,),
                                      CustomTextField(
                                        textInputType: TextInputType.visiblePassword,
                                        obscureText: UpdatePasswordCubit.get(context).isShowPassword,
                                        prefixIcon: const Icon(IconBroken.Lock),
                                        paddingForBottom: AppConstants.padding20h,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            UpdatePasswordCubit.get(context).changePasswordVisibility();
                                          },
                                          child: Icon(
                                            UpdatePasswordCubit.get(context).isShowPassword
                                                ? IconBroken.Hide
                                                : IconBroken.Show,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        controller: UpdatePasswordCubit.get(context).passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك ادخل كلمة السر الجديدة';
                                          }

                                          return null;
                                        },
                                        title: 'كلمة السر الجديدة',
                                        hintText: 'ادخل كلمة السر الجديدة',
                                      ),
                                      SizedBox(height: 20.h,),
                                      GradientButton(
                                        onPressed: () {
                                          if(UpdatePasswordCubit.get(context).formKey.currentState!.validate()){
                                            UpdatePasswordCubit.get(context).changePassword();
                                          }
                                        },
                                        title: Text(
                                          'تغيير كلمة السر',
                                          style: AppStyles.textStyle16.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        )
                      ],
                    )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}









// import 'package:dalily/core/functions/show_snack_bar.dart';
// import 'package:dalily/core/widgets/custom_loading.dart';
// import 'package:dalily/features/settings/logic/update_password_cubit/update_password_cubit.dart';
// import 'package:dalily/features/settings/logic/update_password_cubit/update_password_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../config/icons/icons_broken.dart';
// import '../../core/utils/app_colors.dart';
// import '../../core/utils/app_constants.dart';
// import '../../core/utils/app_styles.dart';
// import '../../core/widgets/custom_text_field.dart';
// import '../../core/widgets/gradient_button.dart';
//
// class UpdatePassword extends StatelessWidget {
//   const UpdatePassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UpdatePasswordCubit(),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//           title: Text('تغيير كلمة السر'),
//           centerTitle: true,
//         ),
//         body: BlocConsumer<UpdatePasswordCubit,UpdatePasswordState>(
//           listener: (context, state) {
//             if(state is UpdatePasswordSuccessState){
//               showSuccessSnackBar(context: context, message: 'تم تغيير كلمة السر بنجاح');
//               Navigator.pop(context);
//             }else if(state is UpdatePasswordFailureState){
//               showErrorSnackBar(context: context, message: 'فشل في تغيير كلمة السر');
//             }
//           },
//           builder: (context, state) {
//             return CustomLoading(
//               isLoading: state is UpdatePasswordLoadingState,
//               child: Form(
//                 key: UpdatePasswordCubit.get(context).formKey,
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0.sp),
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         textInputType: TextInputType.visiblePassword,
//                         obscureText: UpdatePasswordCubit.get(context).isShowOldPassword,
//                         prefixIcon: const Icon(IconBroken.Lock),
//                         paddingForBottom: AppConstants.padding20h,
//                         suffixIcon: InkWell(
//                           onTap: () {
//                             UpdatePasswordCubit.get(context).changeOldPasswordVisibility();
//                           },
//                           child: Icon(
//                             UpdatePasswordCubit.get(context).isShowPassword
//                                 ? IconBroken.Hide
//                                 : IconBroken.Show,
//                             color: AppColors.grey,
//                           ),
//                         ),
//                         controller: UpdatePasswordCubit.get(context).oldPasswordController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'من فضلك ادخل كلمة السر القديمة';
//                           }
//
//                           return null;
//                         },
//                         title: 'كلمة السر القديمة',
//                         hintText: 'ادخل كلمة السر القديمة',
//                       ),
//                       SizedBox(height: 20.h,),
//                       CustomTextField(
//                         textInputType: TextInputType.visiblePassword,
//                         obscureText: UpdatePasswordCubit.get(context).isShowPassword,
//                         prefixIcon: const Icon(IconBroken.Lock),
//                         paddingForBottom: AppConstants.padding20h,
//                         suffixIcon: InkWell(
//                           onTap: () {
//                             UpdatePasswordCubit.get(context).changePasswordVisibility();
//                           },
//                           child: Icon(
//                             UpdatePasswordCubit.get(context).isShowPassword
//                                 ? IconBroken.Hide
//                                 : IconBroken.Show,
//                             color: AppColors.grey,
//                           ),
//                         ),
//                         controller: UpdatePasswordCubit.get(context).passwordController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'من فضلك ادخل كلمة السر الجديدة';
//                           }
//
//                           return null;
//                         },
//                         title: 'كلمة السر الجديدة',
//                         hintText: 'ادخل كلمة السر الجديدة',
//                       ),
//                       SizedBox(height: 20.h,),
//                       GradientButton(
//                         onPressed: () {
//                           if(UpdatePasswordCubit.get(context).formKey.currentState!.validate()){
//                             UpdatePasswordCubit.get(context).changePassword();
//                           }
//                         },
//                         title: Text(
//                           'تغيير كلمة السر',
//                           style: AppStyles.textStyle16.copyWith(
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
