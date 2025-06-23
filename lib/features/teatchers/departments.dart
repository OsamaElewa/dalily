import 'package:dalily/features/teatchers/logic/departments_cubit/departments_cubit.dart';
import 'package:dalily/features/teatchers/logic/departments_cubit/departments_state.dart';
import 'package:dalily/features/teatchers/teatchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../calender/calender_department.dart';
import '../college_details/widgets/department_card.dart';

class Departments extends StatelessWidget {
  const Departments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentsCubit()..getTDepartmentData(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(onPressed: () {
        //     Navigator.pop(context);
        //   }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
        // ),
        body: BlocBuilder<DepartmentsCubit,DepartmentsState>(
          builder: (context, state) {
            if(state is GetDepartmentsSuccessState){
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
                                'الاقسام',
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
                                children: [
                                  Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  ListView.separated(
                                    shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final dep = DepartmentsCubit.get(context).departmentList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            //Navigator.pushNamed(context, Routes.)
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Teachers(departmentId: dep['departmentId']!),));
                                          },
                                          child: DepartmentCard(
                                            icon: departmentIcons[dep['department']]!,
                                            title: dep['department']!,
                                            description: dep['title']!,
                                            color: dep['department'] == 'قسم تكنولوجيا التعليم' ? Color(0xFF4facfe)
                                                : dep['department'] == 'قسم التربية الموسيقية' ? Color(0xFF9b59b6)
                                                : dep['department'] == 'قسم الاقتصاد المنزلي' ? Color(0xFF2ecc71)
                                                : dep['department'] == 'قسم التربية الفنية' ? Color(0xFFe74c3c)
                                                : Color(0xFFf39c12),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                      itemCount: DepartmentsCubit.get(context).departmentList.length
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              );
            }else if(state is GetDepartmentsFailureState){
              return Center(child: Text('something went wrong'),);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
