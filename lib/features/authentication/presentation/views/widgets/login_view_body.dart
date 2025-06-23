import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:dalily/features/authentication/presentation/cubits/login_cubit/login_state.dart';
import 'package:dalily/features/authentication/presentation/views/widgets/title_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/local/cache_helper.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/show_snack_bar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import 'login_texts_fields_section.dart';
import 'nanigate_to_login_or_register.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.setString(key: 'uId', value: state.uId).then((value) {
            print('////////////////////');
            print(CacheHelper.getBoolean(key: 'isAdmin'));
            print('////////////////////');
            Navigator.pushNamedAndRemoveUntil(context, Routes.landingView, (Route<dynamic> route) => false, );
            showSuccessSnackBar(
                context: context, message: 'تم تسجيل الدخول بنجاح');
          });

        } else if (state is LoginFailureState) {
          print(state.error);
          showErrorSnackBar(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return CustomLoading(
          isLoading: state is LoginLoadingState,
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
                                  subtitle: AppStrings.signInSubtitle,
                                  title: AppStrings.signIn,
                                ),
                                const SizedBox(height: 30),
                                const LoginTextsFieldsSection(),
                                GradientButton(
                                  onPressed: () {
                                    if (LoginCubit.get(context)
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      LoginCubit.get(context).userLogin();
                                    }
                                  },
                                  title: Text(
                                    AppStrings.signIn,
                                    style: AppStyles.textStyle18.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                NavigateToLoginOrRegister(
                                  textTitle: AppStrings.alreadyHaveAnAccount,
                                  buttonTitle: AppStrings.signUp,
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.registerView);
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
// import 'package:dalily/features/authentication/presentation/views/widgets/title_and_subtitle.dart';
// import 'package:dalily/features/home/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../config/local/cache_helper.dart';
// import '../../../../../config/routes/app_routes.dart';
// import '../../../../../core/functions/show_snack_bar.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_constants.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/app_styles.dart';
// import '../../../../../core/widgets/gradient_button.dart';
// import '../../cubits/login_cubit/login_cubit.dart';
// import '../../cubits/login_cubit/login_state.dart';
// import 'login_texts_fields_section.dart';
// import 'nanigate_to_login_or_register.dart';
//
//
// class LoginViewBody extends StatelessWidget {
//   const LoginViewBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginCubit, LoginState>(
//       listener: (context, state) {
//         if (state is LoginSuccessState) {
//           CacheHelper.setString(key: 'uId', value: state.uId).then((value) {
//             print('////////////////////');
//             print(CacheHelper.getBoolean(key: 'isAdmin'));
//             print('////////////////////');
//             Navigator.pushNamedAndRemoveUntil(context, Routes.landingView, (Route<dynamic> route) => false, );
//             showSuccessSnackBar(
//                 context: context, message: 'تم تسجيل الدخول بنجاح');
//           });
//
//         } else if (state is LoginFailureState) {
//           print(state.error);
//           showErrorSnackBar(context: context, message: state.error);
//         }
//       },
//       builder: (context, state) {
//         return CustomLoading(
//           isLoading: state is LoginLoadingState,
//           child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.all(AppConstants.defaultPadding),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const TitleAndSubtitle(
//                       subtitle: AppStrings.signInSubtitle,
//                       title: AppStrings.signIn,
//                     ),
//                     const LoginTextsFieldsSection(),
//                     GradientButton(
//                       onPressed: () {
//                         if (LoginCubit.get(context)
//                             .formKey
//                             .currentState!
//                             .validate()) {
//                           LoginCubit.get(context).userLogin();
//                         }
//                       },
//                       title: Text(
//                         AppStrings.signIn,
//                         style: AppStyles.textStyle18.copyWith(
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                     NavigateToLoginOrRegister(
//                       textTitle: AppStrings.alreadyHaveAnAccount,
//                       buttonTitle: AppStrings.signUp,
//                       onPressed: () {
//                         Navigator.pushNamed(context, Routes.registerView);
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
