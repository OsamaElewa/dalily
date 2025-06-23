import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentService extends StatelessWidget {
  const StudentService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
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
                        'خدمات الطالب',
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

              // Main Content
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header Section
                        _buildHeaderSection(),

                        const SizedBox(height: 30),

                        // Services Title
                        _buildServicesTitle(),

                        const SizedBox(height: 25),

                        // Video Conferencing Services
                        _buildServiceCard(
                          title: 'Zoom Meeting',
                          description: 'انضم إلى المحاضرات والاجتماعات المباشرة',
                          icon: Icons.videocam_outlined,
                          gradientColors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                          onTap: () => _launchZoom(),
                        ),

                        const SizedBox(height: 20),

                        _buildServiceCard(
                          title: 'Microsoft Teams',
                          description: 'تعاون مع زملائك وأساتذتك بسهولة',
                          icon: Icons.groups_outlined,
                          gradientColors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          onTap: () => _launchTeams(),
                        ),

                        const SizedBox(height: 30),

                        // Additional Services

                        // Bottom Statistics Card
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Expanded(
            child: Text(
              'خدمات الطالب',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 45), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
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
          // Header Icon
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4facfe).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(height: 20),

          // Main Title
          const Text(
            'الخدمات الطلابية الرقمية',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2c3e50),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'تواصل مع أساتذتك وزملائك من خلال أحدث التقنيات',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2c3e50),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 3,
          width: 30,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
        const SizedBox(width: 15),
        const Text(
          'خدمات التعلم الافتراضي',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2c3e50),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 3,
          width: 30,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
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
        child: Row(
          children: [
            // Service Icon
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(width: 20),

            // Service Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2c3e50),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF2c3e50),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAdditionalServices() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'خدمات إضافية',
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFF2c3e50),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //       const SizedBox(height: 20),
  //
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildQuickServiceCard(
  //               title: 'المكتبة الرقمية',
  //               icon: Icons.library_books_outlined,
  //               color: Color(0xFF4facfe),
  //             ),
  //           ),
  //           const SizedBox(width: 15),
  //           Expanded(
  //             child: _buildQuickServiceCard(
  //               title: 'الدعم التقني',
  //               icon: Icons.support_agent_outlined,
  //               color: Color(0xFF667eea),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //       const SizedBox(height: 15),
  //
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildQuickServiceCard(
  //               title: 'التقييمات',
  //               icon: Icons.quiz_outlined,
  //               color: Color(0xFF764ba2),
  //             ),
  //           ),
  //           const SizedBox(width: 15),
  //           Expanded(
  //             child: _buildQuickServiceCard(
  //               title: 'الإعلانات',
  //               icon: Icons.notifications_outlined,
  //               color: Color(0xFF00f2fe),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildQuickServiceCard({
  //   required String title,
  //   required IconData icon,
  //   required Color color,
  // })
  // {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 45,
  //           width: 45,
  //           decoration: BoxDecoration(
  //             color: color.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Icon(
  //             icon,
  //             color: color,
  //             size: 22,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         Text(
  //           title,
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold,
  //             color: Color(0xFF2c3e50),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildStatisticsCard() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(25),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
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
  //         const Icon(
  //           Icons.analytics_outlined,
  //           color: Colors.white,
  //           size: 40,
  //         ),
  //
  //         const SizedBox(height: 15),
  //
  //         const Text(
  //           'إحصائيات الاستخدام',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //
  //         const SizedBox(height: 10),
  //
  //         const Text(
  //           'تفاعل الطلاب مع الخدمات الرقمية',
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.white,
  //           ),
  //         ),
  //
  //         const SizedBox(height: 20),
  //
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             _buildStatItem('جلسات نشطة', '250+'),
  //             _buildStatItem('طلاب متصلين', '1200+'),
  //             _buildStatItem('محاضرات', '45'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildStatItem(String label, String value) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //       const SizedBox(height: 5),
  //       Text(
  //         label,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //           fontSize: 12,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _launchZoom() async{
    // Add your Zoom launch logic here
    final Uri uri = Uri.parse('https://www.zoom.com/');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ';
    }
    print('Opening Zoom...');
  }

  void _launchTeams() async{
    // Add your Teams launch logic here
    final Uri uri = Uri.parse('https://teams.live.com/free');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch ';
    }
    print('Opening Microsoft Teams...');
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class StudentService extends StatelessWidget {
//   const StudentService({super.key});
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
//         title: Text('خدمات الطالب'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () async{
//                 final Uri uri = Uri.parse('https://www.zoom.com/');
//
//                 if (await canLaunchUrl(uri)) {
//                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//                 } else {
//                 throw 'Could not launch ';
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 height: 200.h,
//                 width: 200.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                   //color: Color(0xFF6264A7),
//                   color: Colors.grey[100]
//                 ),
//                 child: Image.asset('assets/images/zoom.png'),
//               ),
//             ),
//             SizedBox(height: 40.h,),
//             GestureDetector(
//               onTap: () async{
//                 final Uri uri = Uri.parse('https://teams.live.com/free');
//
//                 if (await canLaunchUrl(uri)) {
//                 await launchUrl(uri, mode: LaunchMode.platformDefault);
//                 } else {
//                 throw 'Could not launch ';
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 height: 200.h,
//                 width: 200.w,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                     //color: Color(0xFF6264A7),
//                     color: Colors.grey[100]
//                 ),
//                 child: Image.asset('assets/images/teams.png'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
