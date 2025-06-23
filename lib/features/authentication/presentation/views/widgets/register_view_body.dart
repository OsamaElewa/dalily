import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:dalily/features/authentication/presentation/views/widgets/register_texts_fields_section.dart';
import 'package:dalily/features/authentication/presentation/views/widgets/title_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/local/cache_helper.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/show_snack_bar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../cubits/register_cubit/register_cubit.dart';
import '../../cubits/register_cubit/register_state.dart';
import 'nanigate_to_login_or_register.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterCreateUserSuccessState){
          CacheHelper.setString(key: 'uId', value: state.uId).then((value) {
            CacheHelper.setBoolean(key: 'isAdmin', value: state.isAdmin);
            Navigator.pushNamedAndRemoveUntil(context, Routes.landingView, (Route<dynamic> route) => false, );
            showSuccessSnackBar(context: context, message: 'تم التحقق بنجاح');
          });

        }else if(state is RegisterCreateUserErrorState){
          showErrorSnackBar(context: context, message: state.error);
        }else if(state is RegisterErrorState){
          showErrorSnackBar(context: context, message: state.error);
        }else if(state is CheckErrorState){
          showSuccessSnackBar(context: context, message: 'من فضبك تفقد بريدك الالكتروني');
        }
        else if(state is RegisterSuccessState){
          showSuccessSnackBar(context: context, message: 'تم ارسال رابط التحقق');
        }
      },
      builder: (context, state) {
        return CustomLoading(
          isLoading: state is RegisterLoadingState || state is CheckLoadingState,
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
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),

                                const TitleAndSubtitle(
                                  subtitle: AppStrings.signUpSubtitle,
                                  title: AppStrings.signUp,
                                ),
                                const SizedBox(height: 30),
                                const RegisterTextsFieldsSection(),
                                GradientButton(
                                  title: Text(
                                    AppStrings.signUp,
                                    style: AppStyles.textStyle18.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (RegisterCubit.get(context)
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      RegisterCubit.get(context).registerData();
                                    }
                                  },
                                ),
                                SizedBox(height: 20.h,),
                                RegisterCubit.get(context).emailSent?
                                GradientButton(
                                  title: Text(
                                    'تحقق إذا تم التفعيل',
                                    style: AppStyles.textStyle18.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    RegisterCubit.get(context).checkIfVerified();
                                  },
                                ) : SizedBox(),
                                NavigateToLoginOrRegister(
                                  textTitle: AppStrings.dontHaveAnAccount,
                                  buttonTitle: AppStrings.signIn,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
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
    );
  }
}








// import 'package:dalily/core/widgets/custom_loading.dart';
// import 'package:dalily/features/authentication/presentation/views/widgets/register_texts_fields_section.dart';
// import 'package:dalily/features/authentication/presentation/views/widgets/title_and_subtitle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../config/local/cache_helper.dart';
// import '../../../../../config/routes/app_routes.dart';
// import '../../../../../core/functions/show_snack_bar.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_constants.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/app_styles.dart';
// import '../../../../../core/widgets/gradient_button.dart';
// import '../../cubits/register_cubit/register_cubit.dart';
// import '../../cubits/register_cubit/register_state.dart';
// import 'nanigate_to_login_or_register.dart';
//
//
// class RegisterViewBody extends StatelessWidget {
//   const RegisterViewBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RegisterCubit, RegisterState>(
//       listener: (context, state) {
//         if(state is RegisterCreateUserSuccessState){
//           CacheHelper.setString(key: 'uId', value: state.uId).then((value) {
//             CacheHelper.setBoolean(key: 'isAdmin', value: state.isAdmin);
//             Navigator.pushNamedAndRemoveUntil(context, Routes.landingView, (Route<dynamic> route) => false, );
//             showSuccessSnackBar(context: context, message: 'تم التحقق بنجاح');
//           });
//
//         }else if(state is RegisterCreateUserErrorState){
//           showErrorSnackBar(context: context, message: state.error);
//         }else if(state is RegisterErrorState){
//           showErrorSnackBar(context: context, message: state.error);
//         }else if(state is CheckErrorState){
//           showSuccessSnackBar(context: context, message: 'من فضبك تفقد بريدك الالكتروني');
//         }
//         else if(state is RegisterSuccessState){
//           showSuccessSnackBar(context: context, message: 'تم ارسال رابط التحقق');
//         }
//       },
//       builder: (context, state) {
//         return CustomLoading(
//           isLoading: state is RegisterLoadingState || state is CheckLoadingState,
//           child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.all(AppConstants.defaultPadding),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const TitleAndSubtitle(
//                       subtitle: AppStrings.signUpSubtitle,
//                       title: AppStrings.signUp,
//                     ),
//                     const RegisterTextsFieldsSection(),
//                     GradientButton(
//                       title: Text(
//                         AppStrings.signUp,
//                         style: AppStyles.textStyle18.copyWith(
//                           color: AppColors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                         if (RegisterCubit.get(context)
//                             .formKey
//                             .currentState!
//                             .validate()) {
//                           RegisterCubit.get(context).registerData();
//                         }
//                       },
//                     ),
//                     SizedBox(height: 20.h,),
//                     RegisterCubit.get(context).emailSent?
//                     GradientButton(
//                       title: Text(
//                         'تحقق إذا تم التفعيل',
//                         style: AppStyles.textStyle18.copyWith(
//                           color: AppColors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                           RegisterCubit.get(context).checkIfVerified();
//                       },
//                     ) : SizedBox(),
//                     NavigateToLoginOrRegister(
//                       textTitle: AppStrings.dontHaveAnAccount,
//                       buttonTitle: AppStrings.signIn,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         );
//
//       },
//     );
//   }
// }
