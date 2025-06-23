import 'package:dalily/features/settings/logic/profile_state.dart';
import 'package:dalily/features/settings/update_password.dart';
import 'package:dalily/features/settings/update_profile.dart';
import 'package:dalily/features/settings/widgets/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/show_alert_dialoge.dart';
import 'logic/profile_cubit.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit,ProfileState>(
        builder: (context, state) {
          if(state is ProfileSuccessState){
            return Container(
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
                    // Custom App Bar
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

                    // Main Content Container
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
                          child: Column(
                            children: [
                              // Profile Section
                              ProfileSection(userModel: ProfileCubit.get(context).userModel!),
                              const SizedBox(height: 30),

                              // Action Buttons
                              _buildActionButtons(context),
                              const SizedBox(height: 30),

                              // Statistics Card (Bottom Featured)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(state is ProfileErrorState){
            return Center(
              child: Text('خطأ'),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );
  }

  // Widget _buildProfileSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(25),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 15,
  //           offset: const Offset(0, 5),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         // Profile Avatar with gradient border
  //         Container(
  //           width: 100,
  //           height: 100,
  //           decoration: BoxDecoration(
  //             gradient: const LinearGradient(
  //               colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
  //             ),
  //             borderRadius: BorderRadius.circular(50),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: const Color(0xFF4facfe).withOpacity(0.3),
  //                 blurRadius: 20,
  //                 offset: const Offset(0, 10),
  //               ),
  //             ],
  //           ),
  //           child: Container(
  //             margin: const EdgeInsets.all(3),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(47),
  //             ),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(47),
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
  //                   ),
  //                 ),
  //                 child: const Center(
  //                   child: Text(
  //                     'IPG',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //
  //         // User Info
  //         _buildInfoRow(
  //           icon: Icons.person_outline,
  //           label: 'الاسم',
  //           value: 'Osama Ahmed',
  //         ),
  //         const SizedBox(height: 15),
  //         _buildInfoRow(
  //           icon: Icons.email_outlined,
  //           label: 'البريد الالكتروني',
  //           value: 'osamaelewa424@gmail.com',
  //         ),
  //         const SizedBox(height: 15),
  //         _buildInfoRow(
  //           icon: Icons.school_outlined,
  //           label: 'الفرقة',
  //           value: 'الثالثة',
  //         ),
  //         const SizedBox(height: 15),
  //         _buildInfoRow(
  //           icon: Icons.computer_outlined,
  //           label: 'القسم',
  //           value: 'تكنولوجيا التعليم',
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildInfoRow({
  //   required IconData icon,
  //   required String label,
  //   required String value,
  // })
  // {
  //   return Row(
  //     children: [
  //       Container(
  //         width: 40,
  //         height: 40,
  //         decoration: BoxDecoration(
  //           gradient: const LinearGradient(
  //             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //           ),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Icon(
  //           icon,
  //           color: Colors.white,
  //           size: 20,
  //         ),
  //       ),
  //       const SizedBox(width: 15),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               label,
  //               style: TextStyle(
  //                 color: const Color(0xFF2c3e50).withOpacity(0.7),
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const SizedBox(height: 2),
  //             Text(
  //               value,
  //               style: const TextStyle(
  //                 color: Color(0xFF2c3e50),
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildActionButtons(context) {
    return Column(
      children: [
        _buildActionButton(
          title: 'تسجيل الخروج',
          icon: Icons.logout,
          gradient: const LinearGradient(
            colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
          ),
          onTap: () {
            // Handle logout
            showAlertDialog(
              context: context,
              image: 'assets/images/warning.png',
              message: 'هل انت متأكد من انك تريد تسجيل الخروج',
            );
          },
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          title: 'تعديل البيانات',
          icon: Icons.edit_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
          onTap: () {
            // Handle edit profile
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(userModel: ProfileCubit.get(context).userModel!),));
          },
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          title: 'تغيير كلمة السر',
          icon: Icons.lock_outline,
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          onTap: () {
            // Handle change password
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword(),));
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (gradient as LinearGradient).colors.first.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildStatisticsCard() {
//   return Container(
//     padding: const EdgeInsets.all(25),
//     decoration: BoxDecoration(
//       gradient: const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//       ),
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: const Color(0xFF667eea).withOpacity(0.3),
//           blurRadius: 20,
//           offset: const Offset(0, 10),
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         const Text(
//           'إحصائياتك',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             Expanded(
//               child: _buildStatItem(
//                 title: 'المواد المكتملة',
//                 value: '12',
//                 icon: Icons.check_circle_outline,
//               ),
//             ),
//             Container(
//               width: 1,
//               height: 50,
//               color: Colors.white.withOpacity(0.3),
//             ),
//             Expanded(
//               child: _buildStatItem(
//                 title: 'الدرجات',
//                 value: '85%',
//                 icon: Icons.grade_outlined,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
// Widget _buildStatItem({
//   required String title,
//   required String value,
//   required IconData icon,
// }) {
//   return Column(
//     children: [
//       Icon(
//         icon,
//         color: Colors.white,
//         size: 28,
//       ),
//       const SizedBox(height: 8),
//       Text(
//         value,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 4),
//       Text(
//         title,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.white.withOpacity(0.8),
//           fontSize: 12,
//         ),
//       ),
//     ],
//   );
// }
}









// import 'package:dalily/features/settings/update_password.dart';
// import 'package:dalily/features/settings/update_profile.dart';
// import 'package:dalily/features/settings/widgets/customer_information.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
//
// import '../../../../core/utils/app_colors.dart';
// import '../../core/functions/show_alert_dialoge.dart';
// import '../../core/utils/app_assets.dart';
// import '../../core/utils/app_strings.dart';
//
// import '../../core/utils/app_styles.dart';
// import 'logic/profile_cubit.dart';
// import 'logic/profile_state.dart';
//
//
// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(onPressed: () {
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         title: Text('الاعدادات'),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if (state is ProfileLoadingState) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           else if (state is ProfileSuccessState) {
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(15.0.sp),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const CustomerInformation(),
//                       SizedBox(height: 20.h,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: Row(
//                               children: [
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text('الاسم : ',style: AppStyles.textStyle20,)),
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(ProfileCubit.get(context).userModel!.userName!,style: AppStyles.textStyle20,)),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h,),
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: Row(
//                               children: [
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text("البريد الالكتروني : ",style: AppStyles.textStyle20,)),
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(ProfileCubit.get(context).userModel!.userEmail!,style: AppStyles.textStyle20,)),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h,),
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: Row(
//                               children: [
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text("الفرقة : ",style: AppStyles.textStyle20,)),
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(ProfileCubit.get(context).userModel!.userClass ?? '',style: AppStyles.textStyle20,)),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h,),
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: Row(
//                               children: [
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text("القسم : ",style: AppStyles.textStyle20,)),
//                                 FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(ProfileCubit.get(context).userModel!.userDepartment ?? '',style: AppStyles.textStyle20,)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20.h,),
//                       ElevatedButton.icon(onPressed: () {
//                         showAlertDialog(
//                           context: context,
//                           image: 'assets/images/warning.png',
//                           message: 'هل انت متأكد من انك تريد تسجيل الخروج',
//                         );
//                       },
//                         style: ButtonStyle(
//                           foregroundColor: MaterialStateProperty.all(AppColors.white),
//                           backgroundColor: MaterialStateProperty.all(AppColors.redAccent),
//                           iconColor: MaterialStateProperty.all(AppColors.white),
//                         ),
//                         icon: const Icon(Icons.logout),
//                         label: const Text('تسجيل الخروج'),),
//                       SizedBox(height: 20.h,),
//                       ElevatedButton.icon(onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(userModel: ProfileCubit.get(context).userModel!),));
//                       },
//                         style: ButtonStyle(
//                           foregroundColor: WidgetStateProperty.all(AppColors.white),
//                           backgroundColor: WidgetStatePropertyAll(AppColors.primary),
//                           iconColor: WidgetStateProperty.all(AppColors.white),
//                         ),
//                         icon: const Icon(Icons.update),
//                         label: const Text('تعديل البيانات'),),
//                       SizedBox(height: 20.h,),
//                       ElevatedButton.icon(onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword(),));
//                       },
//                         style: ButtonStyle(
//                           foregroundColor: WidgetStateProperty.all(AppColors.white),
//                           backgroundColor: WidgetStatePropertyAll(AppColors.primary),
//                           iconColor: WidgetStateProperty.all(AppColors.white),
//                         ),
//                         icon: const Icon(Icons.change_circle),
//                         label: const Text('تغيير كلمة السر'),)
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//           else {
//             return Center(
//               child: Text('خطأ'),
//             );
//           }
//
//         },
//       ),
//     );
//   }
// }