import 'package:dalily/features/teatchers/widgets/specialaization_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/teachers_cubit/teachers_cubit.dart';
import 'logic/teachers_cubit/teachers_state.dart';



class Teachers extends StatelessWidget {
  const Teachers({Key? key, required this.departmentId}) : super(key: key);
  final String departmentId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeachersCubit()..getTeachersData(departmentId: departmentId),
      child: Scaffold(
        body: BlocBuilder<TeachersCubit,TeachersState>(
          builder: (context, state) {
            if(state is GetTeachersSuccessState){
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
                                'الدكاترة',
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
                                // Faculty List
                                ListView.separated(
                                  shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final teacher = TeachersCubit.get(context).teachersList[index];
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 15,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // Avatar with gradient background
                                                // Container(
                                                //   width: 70,
                                                //   height: 70,
                                                //   decoration: BoxDecoration(
                                                //     gradient: member.isHead
                                                //         ? const LinearGradient(
                                                //       colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
                                                //     )
                                                //         : const LinearGradient(
                                                //       colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                                                //     ),
                                                //     borderRadius: BorderRadius.circular(20),
                                                //     boxShadow: [
                                                //       BoxShadow(
                                                //         color: (member.isHead
                                                //             ? const Color(0xFFff6b6b)
                                                //             : const Color(0xFF4facfe)).withOpacity(0.3),
                                                //         blurRadius: 15,
                                                //         offset: const Offset(0, 8),
                                                //       ),
                                                //     ],
                                                //   ),
                                                //   child: Center(
                                                //     child: Text(
                                                //       member.avatar,
                                                //       style: const TextStyle(
                                                //         color: Colors.white,
                                                //         fontSize: 18,
                                                //         fontWeight: FontWeight.bold,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),

                                                // Faculty Info
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // Name with head indicator
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              teacher['name']!,
                                                              style: const TextStyle(
                                                                color: Color(0xFF2c3e50),
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          // if (member.isHead)
                                                          //   Container(
                                                          //     padding: const EdgeInsets.symmetric(
                                                          //       horizontal: 8,
                                                          //       vertical: 4,
                                                          //     ),
                                                          //     decoration: BoxDecoration(
                                                          //       gradient: const LinearGradient(
                                                          //         colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
                                                          //       ),
                                                          //       borderRadius: BorderRadius.circular(12),
                                                          //     ),
                                                          //     child: const Text(
                                                          //       'رئيس القسم',
                                                          //       style: TextStyle(
                                                          //         color: Colors.white,
                                                          //         fontSize: 10,
                                                          //         fontWeight: FontWeight.bold,
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),

                                                      // Position
                                                      Text(
                                                        teacher['title']!,
                                                        style: TextStyle(
                                                          color: const Color(0xFF2c3e50).withOpacity(0.7),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),

                                            // Additional Info Row
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8F9FA),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // _buildInfoItem(
                                                  //   icon: Icons.school_outlined,
                                                  //   label: 'الرتبة',
                                                  //   value: member.rank,
                                                  // ),
                                                  // Container(
                                                  //   width: 1,
                                                  //   height: 30,
                                                  //   color: const Color(0xFF2c3e50).withOpacity(0.1),
                                                  // ),
                                                  SpecialaizationInfo(
                                                      icon: Icons.business_outlined,
                                                      label: 'التخصص',
                                                      value: teacher['specialization']!
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),

                                            // Action Buttons
                                            // Row(
                                            //   children: [
                                            //     Expanded(
                                            //       child: _buildActionButton(
                                            //         title: 'التواصل',
                                            //         icon: Icons.message_outlined,
                                            //         gradient: const LinearGradient(
                                            //           colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                                            //         ),
                                            //         onTap: () {
                                            //           // Handle contact
                                            //         },
                                            //       ),
                                            //     ),
                                            //     const SizedBox(width: 10),
                                            //     Expanded(
                                            //       child: _buildActionButton(
                                            //         title: 'المواد',
                                            //         icon: Icons.book_outlined,
                                            //         gradient: const LinearGradient(
                                            //           colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                            //         ),
                                            //         onTap: () {
                                            //           // Handle subjects
                                            //         },
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                    itemCount: TeachersCubit.get(context).teachersList.length
                                ),
                                const SizedBox(height: 30),

                                // Department Statistics (Bottom Featured Card)

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else if(state is GetTeachersFailureState){
              return Center(
                child: Text('Some Thing went wrong'),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          },
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'الدكاترة',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyList() {
    final facultyMembers = [
      FacultyMember(
        name: 'أ.د / أمل كرم خليفة',
        position: 'أستاذ والقائم بعمل رئيس مجلس القسم',
        rank: 'أستاذ',
        department: 'تكنولوجيا التعليم',
        avatar: 'AK',
        isHead: true,
      ),
      FacultyMember(
        name: 'د / حسن على',
        position: 'مدرس تكنولوجيا التعليم',
        rank: 'مدرس',
        department: 'تكنولوجيا التعليم',
        avatar: 'HA',
        isHead: false,
      ),
      FacultyMember(
        name: 'أ.م.د / محمد وحيد محمد سليمان',
        position: 'أستاذ مساعد تكنولوجيا التعليم',
        rank: 'أستاذ مساعد',
        department: 'تكنولوجيا التعليم',
        avatar: 'MW',
        isHead: false,
      ),
      FacultyMember(
        name: 'أ / الاء سعد',
        position: 'مدرس مساعد',
        rank: 'مدرس مساعد',
        department: 'تكنولوجيا التعليم',
        avatar: 'AS',
        isHead: false,
      ),
    ];

    return Column(
      children: facultyMembers.map((member) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildFacultyCard(member),
      )).toList(),
    );
  }

  Widget _buildFacultyCard(FacultyMember member) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar with gradient background
              // Container(
              //   width: 70,
              //   height: 70,
              //   decoration: BoxDecoration(
              //     gradient: member.isHead
              //         ? const LinearGradient(
              //       colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
              //     )
              //         : const LinearGradient(
              //       colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
              //     ),
              //     borderRadius: BorderRadius.circular(20),
              //     boxShadow: [
              //       BoxShadow(
              //         color: (member.isHead
              //             ? const Color(0xFFff6b6b)
              //             : const Color(0xFF4facfe)).withOpacity(0.3),
              //         blurRadius: 15,
              //         offset: const Offset(0, 8),
              //       ),
              //     ],
              //   ),
              //   child: Center(
              //     child: Text(
              //       member.avatar,
              //       style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),

              // Faculty Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name with head indicator
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            member.name,
                            style: const TextStyle(
                              color: Color(0xFF2c3e50),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // if (member.isHead)
                        //   Container(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 8,
                        //       vertical: 4,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       gradient: const LinearGradient(
                        //         colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
                        //       ),
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     child: const Text(
                        //       'رئيس القسم',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Position
                    Text(
                      member.position,
                      style: TextStyle(
                        color: const Color(0xFF2c3e50).withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Additional Info Row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _buildInfoItem(
                //   icon: Icons.school_outlined,
                //   label: 'الرتبة',
                //   value: member.rank,
                // ),
                // Container(
                //   width: 1,
                //   height: 30,
                //   color: const Color(0xFF2c3e50).withOpacity(0.1),
                // ),
                _buildInfoItem(
                  icon: Icons.business_outlined,
                  label: 'التخصص',
                  value: member.department,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Action Buttons
          // Row(
          //   children: [
          //     Expanded(
          //       child: _buildActionButton(
          //         title: 'التواصل',
          //         icon: Icons.message_outlined,
          //         gradient: const LinearGradient(
          //           colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          //         ),
          //         onTap: () {
          //           // Handle contact
          //         },
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     Expanded(
          //       child: _buildActionButton(
          //         title: 'المواد',
          //         icon: Icons.book_outlined,
          //         gradient: const LinearGradient(
          //           colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          //         ),
          //         onTap: () {
          //           // Handle subjects
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF667eea),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF2c3e50).withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF2c3e50),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15),
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
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentStats() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'إحصائيات القسم',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  title: 'إجمالي الأساتذة',
                  value: '4',
                  icon: Icons.groups_outlined,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  title: 'المواد المطروحة',
                  value: '15',
                  icon: Icons.menu_book_outlined,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  title: 'الطلاب المسجلين',
                  value: '250',
                  icon: Icons.school_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Data Model
class FacultyMember {
  final String name;
  final String position;
  final String rank;
  final String department;
  final String avatar;
  final bool isHead;

  FacultyMember({
    required this.name,
    required this.position,
    required this.rank,
    required this.department,
    required this.avatar,
    required this.isHead,
  });
}




// import 'package:dalily/features/teatchers/logic/teachers_cubit/teachers_cubit.dart';
// import 'package:dalily/features/teatchers/widgets/specialaization_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../core/utils/app_assets.dart';
// import 'logic/teachers_cubit/teachers_state.dart';
//
// class Teachers extends StatelessWidget {
//   const Teachers({super.key, required this.departmentId});
//
//   final String departmentId;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TeachersCubit()..getTeachersData(departmentId: departmentId),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         ),
//         body: BlocBuilder<TeachersCubit,TeachersState>(
//           builder: (context, state) {
//             if(state is GetTeachersSuccessState){
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
//                           Text('الدكاترة',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           SizedBox(height: 20,),
//                           Expanded(
//                             child: ListView.separated(
//                                 itemBuilder: (context, index) {
//                                   final teacher = TeachersCubit.get(context).teachersList[index];
//                                   return Container(
//                                     padding: const EdgeInsets.all(20),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.05),
//                                           blurRadius: 15,
//                                           offset: const Offset(0, 5),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             // Avatar with gradient background
//                                             // Container(
//                                             //   width: 70,
//                                             //   height: 70,
//                                             //   decoration: BoxDecoration(
//                                             //     gradient: member.isHead
//                                             //         ? const LinearGradient(
//                                             //       colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
//                                             //     )
//                                             //         : const LinearGradient(
//                                             //       colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
//                                             //     ),
//                                             //     borderRadius: BorderRadius.circular(20),
//                                             //     boxShadow: [
//                                             //       BoxShadow(
//                                             //         color: (member.isHead
//                                             //             ? const Color(0xFFff6b6b)
//                                             //             : const Color(0xFF4facfe)).withOpacity(0.3),
//                                             //         blurRadius: 15,
//                                             //         offset: const Offset(0, 8),
//                                             //       ),
//                                             //     ],
//                                             //   ),
//                                             //   child: Center(
//                                             //     child: Text(
//                                             //       member.avatar,
//                                             //       style: const TextStyle(
//                                             //         color: Colors.white,
//                                             //         fontSize: 18,
//                                             //         fontWeight: FontWeight.bold,
//                                             //       ),
//                                             //     ),
//                                             //   ),
//                                             // ),
//
//                                             // Faculty Info
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   // Name with head indicator
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Text(
//                                                           teacher['name']!,
//                                                           style: const TextStyle(
//                                                             color: Color(0xFF2c3e50),
//                                                             fontSize: 18,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       // if (member.isHead)
//                                                       //   Container(
//                                                       //     padding: const EdgeInsets.symmetric(
//                                                       //       horizontal: 8,
//                                                       //       vertical: 4,
//                                                       //     ),
//                                                       //     decoration: BoxDecoration(
//                                                       //       gradient: const LinearGradient(
//                                                       //         colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
//                                                       //       ),
//                                                       //       borderRadius: BorderRadius.circular(12),
//                                                       //     ),
//                                                       //     child: const Text(
//                                                       //       'رئيس القسم',
//                                                       //       style: TextStyle(
//                                                       //         color: Colors.white,
//                                                       //         fontSize: 10,
//                                                       //         fontWeight: FontWeight.bold,
//                                                       //       ),
//                                                       //     ),
//                                                       //   ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 8),
//
//                                                   // Position
//                                                   Text(
//                                                     teacher['title']!,
//                                                     style: TextStyle(
//                                                       color: const Color(0xFF2c3e50).withOpacity(0.7),
//                                                       fontSize: 14,
//                                                       fontWeight: FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 15),
//
//                                         // Additional Info Row
//                                         Container(
//                                           padding: const EdgeInsets.all(12),
//                                           decoration: BoxDecoration(
//                                             color: const Color(0xFFF8F9FA),
//                                             borderRadius: BorderRadius.circular(15),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               // _buildInfoItem(
//                                               //   icon: Icons.school_outlined,
//                                               //   label: 'الرتبة',
//                                               //   value: member.rank,
//                                               // ),
//                                               // Container(
//                                               //   width: 1,
//                                               //   height: 30,
//                                               //   color: const Color(0xFF2c3e50).withOpacity(0.1),
//                                               // ),
//                                               SpecialaizationInfo(
//                                                   icon: Icons.business_outlined,
//                                                   label: 'التخصص',
//                                                   value: teacher['specialization']!
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 15),
//
//                                         // Action Buttons
//                                         // Row(
//                                         //   children: [
//                                         //     Expanded(
//                                         //       child: _buildActionButton(
//                                         //         title: 'التواصل',
//                                         //         icon: Icons.message_outlined,
//                                         //         gradient: const LinearGradient(
//                                         //           colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
//                                         //         ),
//                                         //         onTap: () {
//                                         //           // Handle contact
//                                         //         },
//                                         //       ),
//                                         //     ),
//                                         //     const SizedBox(width: 10),
//                                         //     Expanded(
//                                         //       child: _buildActionButton(
//                                         //         title: 'المواد',
//                                         //         icon: Icons.book_outlined,
//                                         //         gradient: const LinearGradient(
//                                         //           colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                                         //         ),
//                                         //         onTap: () {
//                                         //           // Handle subjects
//                                         //         },
//                                         //       ),
//                                         //     ),
//                                         //   ],
//                                         // ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) => SizedBox(height: 20.h,),
//                                 itemCount: TeachersCubit.get(context).teachersList.length
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }else if(state is GetTeachersFailureState){
//               return Center(
//                 child: Text('Some Thing went wrong'),
//               );
//             }else{
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//           },
//         ),
//       ),
//     );
//   }
// }
