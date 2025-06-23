import 'package:dalily/features/home/widget/home_cards.dart';
import 'package:dalily/features/settings/logic/profile_cubit.dart';
import 'package:dalily/features/settings/logic/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../config/routes/app_routes.dart';
import '../announce_page/announce_page.dart';
import '../chat_bot/chat_bot.dart';
import '../college_details/college_details.dart';
import '../map/map_page.dart';
import '../settings/settings_page.dart';
import '../student_service/student_service.dart';
import '../tarbya_page/tarbya_page.dart';
import '../teatchers/departments.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Header Section
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot(),)),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF4facfe),
                                Color(0xFF00f2fe),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              // Profile Section
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 3,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: const Text(
                                        'مرحبا كيف يمكنني مساعدتك؟',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'دليل الطالب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Menu Grid
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(25),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1,
                          children: [
                            HomeCards(icon: Icons.school,
                              title: "كلية التربية النوعية",
                              onTap: () =>  _navigateToTarbyaPage(context),
                            ),
                            HomeCards(
                              icon: Icons.account_balance,
                              title: 'اقسام الكلية',
                              onTap: () => _navigateToDepartments(context),
                            ),
                            HomeCards(
                              icon: Icons.calendar_today,
                              title: 'الجدول الدراسي',
                              onTap: () => _navigateToSchedule(context),
                            ),
                            HomeCards(
                              icon: Icons.group,
                              title: 'أعضاء هيئة التدريس',
                              onTap: () => _navigateToTeacherAcademy(context),
                            ),
                            HomeCards(
                              icon: Icons.map,
                              title: 'الخرائط',
                              onTap: () => _navigateToMaps(context),
                            ),
                            HomeCards(
                              icon: Icons.settings,
                              title: 'اعدادات',
                              onTap: () => _navigateToSettings(context),
                            ),
                            HomeCards(
                              icon: Icons.support_agent,
                              title: 'خدمات الطالب',
                              onTap: () => _navigateToStudentServices(context),
                            ),
                            HomeCards(
                              icon: Icons.help_outline,
                              title: 'الاستعلامات',
                              onTap: () => _navigateToAnnouncePage(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }else if(state is ProfileErrorState){
            return Center(
              child: Text('error'),
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

  // Widget _buildMenuItem(
  //     BuildContext context, {
  //       required IconData icon,
  //       required String title,
  //       required VoidCallback onTap,
  //     })
  // {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [
  //             Colors.white,
  //             Colors.grey.shade50,
  //           ],
  //         ),
  //         borderRadius: BorderRadius.circular(20),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.08),
  //             blurRadius: 15,
  //             offset: const Offset(0, 5),
  //           ),
  //         ],
  //         border: Border.all(
  //           color: Colors.grey.withOpacity(0.1),
  //           width: 1,
  //         ),
  //       ),
  //       child: Material(
  //         color: Colors.transparent,
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(20),
  //           onTap: onTap,
  //           child: Container(
  //             padding: const EdgeInsets.all(20),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   padding: const EdgeInsets.all(12),
  //                   decoration: BoxDecoration(
  //                     color: const Color(0xFF4facfe).withOpacity(0.1),
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Icon(
  //                     icon,
  //                     size: 32,
  //                     color: const Color(0xFF4facfe),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   title,
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w600,
  //                     color: Color(0xFF2c3e50),
  //                     height: 1.2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Navigation methods
  void _navigateToTarbyaPage(BuildContext context) {
    // Navigate to college information page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TarbyaPage()),
    );
  }

  void _navigateToDepartments(BuildContext context) {
    // Navigate to departments page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CollegeDetails()),
    );
  }

  void _navigateToSchedule(BuildContext context) {
    // Navigate to academic schedule page
    Navigator.pushNamed(context, Routes.calender);
  }

  void _navigateToTeacherAcademy(BuildContext context) {
    // Navigate to faculty members page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Departments()),
    );
  }

  void _navigateToMaps(BuildContext context) {
    // Navigate to maps page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen(location: LatLng(31.222305723935566, 29.947088606746213))),
    );
  }

  void _navigateToSettings(BuildContext context) {
    // Navigate to settings page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileView()),
    );
  }

  void _navigateToStudentServices(BuildContext context) {
    // Navigate to student services page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentService()),
    );
  }

  void _navigateToAnnouncePage(BuildContext context) {
    // Navigate to inquiries page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AnnouncePage()),
    );
  }
}