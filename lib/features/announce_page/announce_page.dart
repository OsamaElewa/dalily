import 'package:dalily/features/add_announce_page/add_announce_page.dart';
import 'package:dalily/features/announce_page/widgets/announce_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/gradient_button.dart';
import '../settings/logic/profile_cubit.dart';
import 'logic/get_announce_cubit/get_announce_cubit.dart';



class AnnouncePage extends StatelessWidget {
  const AnnouncePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAnnounceCubit(),
      child: Scaffold(
        body: Container(
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
                          'الاعلانات',
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
                    width: double.infinity,
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
                          // Add Announcement Button
                          ProfileCubit.get(context).userModel!.isAdmin! ?
                          GradientButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAnnouncePage(),));
                            },
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'إضافة الإعلان',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : SizedBox(),
                          const SizedBox(height: 25),

                          // Announcements List
                          AnnounceList(),
                          const SizedBox(height: 30),

                          // Statistics Card (Bottom Featured)
                          // _buildAnnouncementsStats(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Widget _buildAddAnnouncementButton() {
//   return GestureDetector(
//     onTap: () {
//       // Handle add announcement
//
//     },
//     child: Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 18),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
//         ),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF4facfe).withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.add_circle_outline,
//             color: Colors.white,
//             size: 24,
//           ),
//           SizedBox(width: 12),
//           Text(
//             'إضافة الإعلان',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

LinearGradient getAnnouncementGradient(String type) {
  switch (type) {
    case 'اجازة':
      return  LinearGradient(
        colors: [Color(0xFFff6b6b), Color(0xFFee5a52)],
      );
    case 'امتحان':
      return const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
      );
    case 'ورشة عمل':
      return const LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
      );
    default:
      return const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
      );
  }
}

IconData getAnnouncementIcon(String type) {
  switch (type) {
    case 'اجازة':
      return Icons.celebration_outlined;
    case 'امتحان':
      return Icons.quiz_outlined;
    case 'ورشة عمل':
      return Icons.school_outlined;
    default:
      return Icons.announcement_outlined;
  }
}












// import 'package:dalily/config/local/cache_helper.dart';
// import 'package:dalily/features/announce_page/logic/announce_cubit.dart';
// import 'package:dalily/features/announce_page/logic/get_announce_cubit/get_announce_cubit.dart';
// import 'package:dalily/features/announce_page/widgets/add_announce.dart';
// import 'package:dalily/features/announce_page/widgets/announce_list.dart';
// import 'package:dalily/features/settings/logic/profile_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AnnouncePage extends StatelessWidget {
//   const AnnouncePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => GetAnnounceCubit()),
//         BlocProvider(create: (context) => AnnounceCubit()),
//       ],
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.all(Radius.circular(15)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     Text('الاعلانات',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 20,),
//                     ProfileCubit.get(context).userModel!.isAdmin! ?
//                     AddAnnounce() :
//                     SizedBox(),
//                     SizedBox(height: 10.h,),
//                     AnnounceList(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
