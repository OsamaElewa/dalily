import 'package:dalily/features/tarbya_page/logic/tarbya_state.dart';
import 'package:dalily/features/tarbya_page/tarbya_details.dart';
import 'package:dalily/features/tarbya_page/wakil_page.dart';
import 'package:dalily/features/tarbya_page/widgets/tarbya_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'amid_page.dart';
import 'logic/tarbya_cubit.dart';



class TarbyaPage extends StatelessWidget {
  const TarbyaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TarbyaCubit()..getTarbyaData(),
      child: Scaffold(
        body: BlocBuilder<TarbyaCubit, TarbyaState>(
          builder: (context, state) {
            if (state is GetTarbyaSuccessState) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
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
                                'كلية التربية النوعية',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                            // Balance the back button
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
                                      final tarbya = TarbyaCubit.get(context).TarbyaList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          if(index == 0 || index == 1 || index == 2){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => TarbyaDetails(imageName: tarbya['imageName']!, pageTitle: tarbya['title']!),));
                                          }else if(index ==3){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AmidPage(title: tarbya['title']!, index: index,),));
                                          }else if(index == 4){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => WakilPage(title: tarbya['title']!, index: index,),));
                                          }
                                        },
                                        child: TarbyaCard(
                                          icon: departmentIcons[tarbya['title']]!,
                                          title: tarbya['title']!,
                                          subtitle: tarbya['subTitle']!,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                    itemCount: TarbyaCubit.get(context).TarbyaList.length
                                ),

                                // Menu Items
                                // _buildMenuItem(
                                //   context,
                                //   icon: Icons.account_tree,
                                //   title: 'الهيكل التنظيمي للكلية',
                                //   subtitle: 'عرض الهيكل الإداري والتنظيمي',
                                //   onTap:
                                //       () => _navigateToOrganizationalStructure(
                                //         context,
                                //       ),
                                // ),
                                //
                                // const SizedBox(height: 20),
                                //
                                // _buildMenuItem(
                                //   context,
                                //   icon: Icons.visibility,
                                //   title: 'رؤية ورسالة الكلية',
                                //   subtitle: 'رؤية الكلية ورسالتها وقيمها',
                                //   onTap:
                                //       () => _navigateToVisionMission(context),
                                // ),
                                //
                                // const SizedBox(height: 20),
                                //
                                // _buildMenuItem(
                                //   context,
                                //   icon: Icons.flag,
                                //   title: 'اهداف الكلية',
                                //   subtitle: 'الأهداف الاستراتيجية للكلية',
                                //   onTap: () => _navigateToGoals(context),
                                // ),
                                //
                                // const SizedBox(height: 20),
                                //
                                // _buildMenuItem(
                                //   context,
                                //   icon: Icons.person_pin,
                                //   title: 'عميد الكلية',
                                //   subtitle: 'معلومات عن عميد الكلية',
                                //   onTap: () => _navigateToDean(context),
                                // ),
                                //
                                // const SizedBox(height: 20),
                                //
                                // _buildMenuItem(
                                //   context,
                                //   icon: Icons.supervisor_account,
                                //   title: 'وكيل الكلية',
                                //   subtitle: 'معلومات عن وكيل الكلية',
                                //   onTap: () => _navigateToViceDean(context),
                                // ),

                                const SizedBox(height: 30),

                                // Additional Information Card
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF4facfe),
                                        Color(0xFF00f2fe),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4facfe,
                                        ).withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.school,
                                        color: Colors.white,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        'كلية التربية النوعية',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'مؤسسة تعليمية رائدة في مجال التربية النوعية',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is GetTarbyaFailureState) {
              return Center(child: Text('error'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

// Widget _buildMenuItem(
//   BuildContext context, {
//   required IconData icon,
//   required String title,
//   required String subtitle,
//   required VoidCallback onTap,
// }) {
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
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF4facfe).withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Icon(icon, color: Colors.white, size: 28),
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
//                     const SizedBox(height: 5),
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF4facfe).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.arrow_forward_ios,
//                   color: Color(0xFF4facfe),
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

// Navigation methods
// void _navigateToOrganizationalStructure(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const OrganizationalStructurePage(),
//     ),
//   );
// }
//
// void _navigateToVisionMission(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const VisionMissionPage()),
//   );
// }
//
// void _navigateToGoals(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const GoalsPage()),
//   );
// }
//
// void _navigateToDean(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const DeanPage()),
//   );
// }
//
// void _navigateToViceDean(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const ViceDeanPage()),
//   );
// }
}

// Placeholder pages - replace with your actual implementations
class OrganizationalStructurePage extends StatelessWidget {
  const OrganizationalStructurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الهيكل التنظيمي للكلية'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة الهيكل التنظيمي للكلية',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class VisionMissionPage extends StatelessWidget {
  const VisionMissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رؤية ورسالة الكلية'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text(
            'صفحة رؤية ورسالة الكلية',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class GoalsPage extends StatelessWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اهداف الكلية'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text('صفحة اهداف الكلية', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class DeanPage extends StatelessWidget {
  const DeanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عميد الكلية'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text('صفحة عميد الكلية', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class ViceDeanPage extends StatelessWidget {
  const ViceDeanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('وكيل الكلية'),
        backgroundColor: const Color(0xFF4facfe),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
            stops: [0.0, 0.3],
          ),
        ),
        child: const Center(
          child: Text('صفحة وكيل الكلية', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}


Map<String, IconData> departmentIcons = {
  'الهيكل التنظيمي للكلية': Icons.account_tree,
  'رؤية ورسالة الكلية': Icons.visibility,
  'اهداف الكلية': Icons.flag,
  'عميد الكلية': Icons.person_pin,
  'وكيل الكلية': Icons.supervisor_account,
};





















// import 'package:dalily/features/tarbya_page/amid_page.dart';
// import 'package:dalily/features/tarbya_page/logic/tarbya_cubit.dart';
// import 'package:dalily/features/tarbya_page/logic/tarbya_state.dart';
// import 'package:dalily/features/tarbya_page/tarbya_details.dart';
// import 'package:dalily/features/tarbya_page/wakil_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../config/routes/app_routes.dart';
//
// class TarbyaPage extends StatelessWidget {
//   const TarbyaPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TarbyaCubit()..getTarbyaData(),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//         ),
//         body: BlocBuilder<TarbyaCubit,TarbyaState>(
//           builder: (context, state) {
//             if(state is GetTarbyaSuccessState){
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
//                           Text('كلية التربية النوعية',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           SizedBox(height: 20,),
//                           Expanded(
//                             child: ListView.separated(
//                                 itemBuilder: (context, index) {
//                                   final tarbya = TarbyaCubit.get(context).TarbyaList[index];
//                                   return GestureDetector(
//                                     onTap: () {
//                                       if(index == 0 || index == 1 || index == 2){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) => TarbyaDetails(imageName: tarbya['imageName']!, pageTitle: tarbya['title']!),));
//                                       }else if(index ==3){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) => AmidPage(title: tarbya['title']!, index: index,),));
//                                       }else if(index == 4){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) => WakilPage(title: tarbya['title']!, index: index,),));
//                                       }
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: ListTile(
//                                           title: Text(tarbya['title']!,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                                           // leading: Image(
//                                           //   image: AssetImage(AppAssets.art),height: 50,width: 50,),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) => SizedBox(height: 20.h,),
//                                 itemCount: TarbyaCubit.get(context).TarbyaList.length
//                             ),
//                           ),
//                           // Container(
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white,
//                           //     borderRadius: BorderRadius.all(Radius.circular(15)),
//                           //   ),
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.all(8.0),
//                           //     child: ListTile(
//                           //       title: Text('عميد الكلية',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           //       // leading: Image(
//                           //       //   image: AssetImage(AppAssets.art),height: 50,width: 50,),
//                           //     ),
//                           //   ),
//                           // ),
//                           // SizedBox(height: 20.h,),
//                           // Container(
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white,
//                           //     borderRadius: BorderRadius.all(Radius.circular(15)),
//                           //   ),
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.all(8.0),
//                           //     child: ListTile(
//                           //       title: Text('وكيل الكلية',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           //       // leading: Image(
//                           //       //   image: AssetImage(AppAssets.art),height: 50,width: 50,),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }else if(state is GetTarbyaFailureState){
//               return Center(
//                 child: Text('error'),
//               );
//             }else{
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
