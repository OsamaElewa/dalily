import 'package:dalily/features/college_details/widgets/department_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../teatchers/logic/departments_cubit/departments_cubit.dart';
import '../teatchers/logic/departments_cubit/departments_state.dart';
import 'department_details.dart';


class CollegeDetails extends StatelessWidget {
  const CollegeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentsCubit()..getTDepartmentData(),
      child: Scaffold(
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

                      // Content
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
                                // Header indicator
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentDetails(seen: dep['seen']!, message: dep['message']!, target: dep['target']!, department: dep['department']!,),));
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
                                          )
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                    itemCount: DepartmentsCubit.get(context).departmentList.length
                                ),
                                // Color(0xFF4facfe)
                                //Color(0xFF9b59b6)
                                //Color(0xFF2ecc71)
                                //Color(0xFFe74c3c)
                                //Color(0xFFf39c12)




                                const SizedBox(height: 30),

                                // Statistics Card
                                // Container(
                                //   width: double.infinity,
                                //   padding: const EdgeInsets.all(25),
                                //   decoration: BoxDecoration(
                                //     gradient: const LinearGradient(
                                //       begin: Alignment.topLeft,
                                //       end: Alignment.bottomRight,
                                //       colors: [
                                //         Color(0xFF667eea),
                                //         Color(0xFF764ba2),
                                //       ],
                                //     ),
                                //     borderRadius: BorderRadius.circular(20),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: const Color(0xFF667eea).withOpacity(0.3),
                                //         blurRadius: 20,
                                //         offset: const Offset(0, 10),
                                //       ),
                                //     ],
                                //   ),
                                //   child: Column(
                                //     children: [
                                //       const Icon(
                                //         Icons.analytics,
                                //         color: Colors.white,
                                //         size: 48,
                                //       ),
                                //       const SizedBox(height: 15),
                                //       const Text(
                                //         'إحصائيات الأقسام',
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       const SizedBox(height: 15),
                                //       Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //         children: [
                                //           _buildStatItem('5', 'أقسام'),
                                //           _buildStatItem('50+', 'أعضاء هيئة تدريس'),
                                //           _buildStatItem('1000+', 'طلاب'),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
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

  // Widget _buildDepartmentCard(
  //     BuildContext context, {
  //       required IconData icon,
  //       required String title,
  //       required String description,
  //       required Color color,
  //       required VoidCallback onTap,
  //     }) {
  //   return Container(
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
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(20),
  //         onTap: onTap,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 70,
  //                 height: 70,
  //                 decoration: BoxDecoration(
  //                   color: color.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(18),
  //                   border: Border.all(
  //                     color: color.withOpacity(0.2),
  //                     width: 2,
  //                   ),
  //                 ),
  //                 child: Icon(
  //                   icon,
  //                   color: color,
  //                   size: 32,
  //                 ),
  //               ),
  //               const SizedBox(width: 20),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: const TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF2c3e50),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       description,
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.grey.shade600,
  //                         height: 1.4,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.all(8),
  //                 decoration: BoxDecoration(
  //                   color: color.withOpacity(0.1),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   Icons.arrow_forward_ios,
  //                   color: color,
  //                   size: 16,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget _buildStatItem(String number, String label) {
  //   return Column(
  //     children: [
  //       Text(
  //         number,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 24,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 5),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: Colors.white.withOpacity(0.8),
  //           fontSize: 14,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Navigation methods

}

Map<String, IconData> departmentIcons = {
  'قسم تكنولوجيا التعليم': Icons.computer,
  'قسم التربية الموسيقية': Icons.music_note,
  'قسم الاقتصاد المنزلي': Icons.home,
  'قسم التربية الفنية': Icons.palette,
  'قسم العلوم التربوية والنفسية': Icons.psychology,
};

// Placeholder pages for each department
class EducationalTechnologyPage extends StatelessWidget {
  const EducationalTechnologyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم تكنولوجيا التعليم'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4facfe),
              Color(0xFFF8F9FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة قسم تكنولوجيا التعليم',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class MusicEducationPage extends StatelessWidget {
  const MusicEducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم التربية الموسيقية'),
        backgroundColor: const Color(0xFF9b59b6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9b59b6),
              Color(0xFFF8F9FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة قسم التربية الموسيقية',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class HomeEconomicsPage extends StatelessWidget {
  const HomeEconomicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم الاقتصاد المنزلي'),
        backgroundColor: const Color(0xFF2ecc71),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2ecc71),
              Color(0xFFF8F9FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة قسم الاقتصاد المنزلي',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ArtEducationPage extends StatelessWidget {
  const ArtEducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم التربية الفنية'),
        backgroundColor: const Color(0xFFe74c3c),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFe74c3c),
              Color(0xFFF8F9FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة قسم التربية الفنية',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class EducationalPsychologyPage extends StatelessWidget {
  const EducationalPsychologyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم العلوم التربوية والنفسية'),
        backgroundColor: const Color(0xFFf39c12),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf39c12),
              Color(0xFFF8F9FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة قسم العلوم التربوية والنفسية',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
















// import 'package:dalily/features/college_details/department_details.dart';
// import 'package:dalily/features/teatchers/logic/departments_cubit/departments_cubit.dart';
// import 'package:dalily/features/teatchers/logic/departments_cubit/departments_state.dart';
// import 'package:dalily/features/teatchers/teatchers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CollegeDetails extends StatelessWidget {
//   const CollegeDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DepartmentsCubit()..getTDepartmentData(),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         ),
//         body: BlocBuilder<DepartmentsCubit,DepartmentsState>(
//           builder: (context, state) {
//             if(state is GetDepartmentsSuccessState){
//               return SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           Text('الاقسام',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           SizedBox(height: 20,),
//                           Expanded(
//                             child: ListView.separated(
//                                 itemBuilder: (context, index) {
//                                   final dep = DepartmentsCubit.get(context).departmentList[index];
//                                   return GestureDetector(
//                                     onTap: () {
//                                       //Navigator.pushNamed(context, Routes.)
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentDetails(seen: dep['seen']!, message: dep['message']!, target: dep['target']!),));
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: ListTile(
//                                           title: Text(dep['department'] ?? '',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                                           // leading: Image(
//                                           //   image: AssetImage(AppAssets.art),height: 50,width: 50,),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) => SizedBox(height: 20.h,),
//                                 itemCount: DepartmentsCubit.get(context).departmentList.length
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }else if(state is GetDepartmentsFailureState){
//               return Center(child: Text('something went wrong'),);
//             }else{
//               return Center(child: CircularProgressIndicator(),);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
