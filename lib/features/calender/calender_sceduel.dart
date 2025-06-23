import 'package:dalily/features/calender/full_screen_image.dart';
import 'package:dalily/features/calender/logic/calender_department_cubit/calender_department_cubit.dart';
import 'package:dalily/features/calender/logic/calender_department_cubit/calender_department_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/local/cache_helper.dart';
import '../settings/logic/profile_cubit.dart';

class CalenderSceduel extends StatelessWidget {
  const CalenderSceduel({super.key, required this.classId, required this.departmentId});
  final int classId , departmentId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalenderDepartmentCubit()..getImageUrl(classId: classId, departmentId: departmentId),),
        //BlocProvider(create: (context) => ProfileCubit()..getUser(),)
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
          title: Text('الجدول الدراسي'),
          backgroundColor: const Color(0xFF4facfe),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<CalenderDepartmentCubit, CalenderDepartmentState>(
          builder: (context, state) {
            if (state is GetImageSupabaseSuccessState) {
              var cubit = ProfileCubit.get(context).userModel!;
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
                      stops: [0.0, 0.3],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imagePath: state.url),));
                            },
                            child: Image.network(
                              state.url,
                              height: 250.h,
                              width: 250.w,
                              fit: BoxFit.cover,
                              // errorBuilder: (context, error, stackTrace) => Center(
                              //   child: Column(
                              //     children: [
                              //       Text('لا توجد صورة'),
                              //       TextButton(
                              //         onPressed: () {
                              //           CalenderDepartmentCubit.get(context)
                              //               .uploadImage(classId: classId, departmentId: departmentId);
                              //         },
                              //         child: const Text('رفع صورة'),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // loadingBuilder: (context, child, loadingProgress) {
                              //   if (loadingProgress == null) return child;
                              //   return const CircularProgressIndicator();
                              // },
                            ),
                          ),
                          cubit.isAdmin! ?
                          IconButton(onPressed: () {
                            CalenderDepartmentCubit.get(context)
                                .deleteImage(classId: classId, departmentId: departmentId);
                          }, icon: Icon(Icons.delete,color: Colors.red,size: 25,)) :
                              SizedBox()
                        ],
                      ),
                    ),
                  ),
                );
            }
            else if (state is GetImageSupabaseFailureState) {
              var cubit = ProfileCubit.get(context).userModel!;
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
                    stops: [0.0, 0.3],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('لا يوجد جدول دراسي بعد'),
                      cubit.isAdmin! ?
                      TextButton(
                        onPressed: () {
                          CalenderDepartmentCubit.get(context)
                              .uploadImage(classId: classId, departmentId: departmentId);
                        },
                        child: const Text('رفع الصورة'),
                      ) :
                      SizedBox(),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
