import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/gradient_button.dart';
import '../authentication/data/models/user_model.dart';
import 'logic/profile_cubit.dart';
import 'logic/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'logic/update_user_profile_cubit/update_user_profile_state.dart';



class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    UpdateUserProfileCubit.get(context).nameController.text = widget.userModel.userName!;
    if(widget.userModel.userClass !=null){
      UpdateUserProfileCubit.get(context).classController.text = widget.userModel.userClass!;
    }
    if(widget.userModel.userDepartment != null){
      UpdateUserProfileCubit.get(context).departmentController.text = widget.userModel.userDepartment!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UpdateUserProfileCubit,UpdateUserProfileState>(
        builder: (context, state) {
          return CustomLoading(
            isLoading: state is UpdateUserProfileLoadingState,
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
                                'المعلومات الشخصية',
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
                                key: UpdateUserProfileCubit.get(context).formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      textInputType: TextInputType.name,
                                      controller: UpdateUserProfileCubit.get(context).nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل الاسم';
                                        }
                                        return null;
                                      },
                                      title: 'الاسم',
                                      hintText: 'ادخل الاسم',
                                    ),
                                    CustomTextField(
                                      textInputType: TextInputType.text,
                                      controller: UpdateUserProfileCubit.get(context).classController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل الفرقة';
                                        }
                                        return null;
                                      },
                                      title: 'الفرقة',
                                      hintText: 'ادخل الفرقة',
                                    ),
                                    CustomTextField(
                                      textInputType: TextInputType.text,
                                      controller: UpdateUserProfileCubit.get(context).departmentController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل القسم';
                                        }
                                        return null;
                                      },
                                      title: 'القسم',
                                      hintText: 'ادخل القسم',
                                    ),
                                    GradientButton(
                                      onPressed: () {
                                        if(UpdateUserProfileCubit.get(context).formKey.currentState!.validate()){
                                          UpdateUserProfileCubit.get(context).updateUser().then((value) {
                                            ProfileCubit.get(context).getUser();
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      title: Text(
                                        'تحديث البيانات',
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
    );
  }
}







// import 'package:dalily/features/settings/logic/profile_cubit.dart';
// import 'package:dalily/features/settings/logic/update_user_profile_cubit/update_user_profile_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../core/utils/app_colors.dart';
// import '../../core/utils/app_constants.dart';
// import '../../core/utils/app_strings.dart';
// import '../../core/utils/app_styles.dart';
// import '../../core/widgets/custom_text_field.dart';
// import '../../core/widgets/gradient_button.dart';
// import '../authentication/data/models/user_model.dart';
// import 'logic/update_user_profile_cubit/update_user_profile_state.dart';
//
// class UpdateProfile extends StatefulWidget {
//   UpdateProfile({super.key, required this.userModel});
//   final UserModel userModel;
//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }
//
// class _UpdateProfileState extends State<UpdateProfile> {
//   @override
//   @override
//   void initState() {
//     // TODO: implement initState
//     UpdateUserProfileCubit.get(context).nameController.text = widget.userModel.userName!;
//     if(widget.userModel.userClass !=null){
//       UpdateUserProfileCubit.get(context).classController.text = widget.userModel.userClass!;
//     }
//     if(widget.userModel.userDepartment != null){
//       UpdateUserProfileCubit.get(context).departmentController.text = widget.userModel.userDepartment!;
//     }
//     super.initState();
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(onPressed: () {
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         title: Text('تعديل اليانات'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.only(
//           left: AppConstants.padding10h,
//           right: AppConstants.padding10h,
//           bottom: AppConstants.padding10h,
//         ),
//         child: Form(
//           key: UpdateUserProfileCubit.get(context).formKey,
//           child: Column(
//             children: [
//               BlocBuilder<UpdateUserProfileCubit,UpdateUserProfileState>(
//                 builder: (context, state) {
//                   if(state is UpdateUserProfileLoadingState){
//                     return Padding(
//                       padding:  EdgeInsets.only(bottom:AppConstants.padding3h),
//                       child: const LinearProgressIndicator(),
//                     );
//                   }else{
//                     return const SizedBox();
//                   }
//                 },),
//               CustomTextField(
//                 textInputType: TextInputType.name,
//                 controller: UpdateUserProfileCubit.get(context).nameController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'من فضلك ادخل الاسم';
//                   }
//                   return null;
//                 },
//                 title: 'الاسم',
//                 hintText: 'ادخل الاسم',
//               ),
//               CustomTextField(
//                 textInputType: TextInputType.text,
//                 controller: UpdateUserProfileCubit.get(context).classController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'من فضلك ادخل الفرقة';
//                   }
//                   return null;
//                 },
//                 title: 'الفرقة',
//                 hintText: 'ادخل الفرقة',
//               ),
//               CustomTextField(
//                 textInputType: TextInputType.text,
//                 controller: UpdateUserProfileCubit.get(context).departmentController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'من فضلك ادخل القسم';
//                   }
//                   return null;
//                 },
//                 title: 'القسم',
//                 hintText: 'ادخل القسم',
//               ),
//               GradientButton(
//                 onPressed: () {
//                   if(UpdateUserProfileCubit.get(context).formKey.currentState!.validate()){
//                     UpdateUserProfileCubit.get(context).updateUser().then((value) {
//                       ProfileCubit.get(context).getUser();
//                       Navigator.pop(context);
//                     });
//                   }
//                 },
//                 title: Text(
//                   'تحديث البيانات',
//                   style: AppStyles.textStyle16.copyWith(
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
