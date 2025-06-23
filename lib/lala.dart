


























// import 'package:dalily/config/icons/icons_broken.dart';
// import 'package:dalily/config/routes/app_routes.dart';
// import 'package:dalily/core/utils/app_assets.dart';
// import 'package:dalily/features/announce_page/announce_page.dart';
// import 'package:dalily/features/calender/calender_page.dart';
// import 'package:dalily/features/chat_bot/chat_bot.dart';
// import 'package:dalily/features/college_details/college_details.dart';
// import 'package:dalily/features/map/map_page.dart';
// import 'package:dalily/features/settings/logic/profile_cubit.dart';
// import 'package:dalily/features/settings/logic/profile_state.dart';
// import 'package:dalily/features/settings/settings_page.dart';
// import 'package:dalily/features/student_service/student_service.dart';
// import 'package:dalily/features/tarbya_page/tarbya_page.dart';
// import 'package:dalily/features/teatchers/departments.dart';
// import 'package:dalily/features/teatchers/teatchers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:latlong2/latlong.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[100],
//         title: Text('دليل الطالب'),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot(),)),
//                 child: Image(image: AssetImage('assets/images/chatbot.png'),height: 40,width: 40,)),
//           )
//         ],
//         leading: IconButton(onPressed: () => Navigator.pushNamed(context, Routes.landingView), icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
//       ),
//       body: BlocBuilder<ProfileCubit,ProfileState>(
//         builder: (context, state) {
//           if(state is ProfileSuccessState){
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: GestureDetector(
//                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot(),)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[200],
//                                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),topRight: Radius.circular(15))
//                               ),
//                               height: 80,
//                               child: Center(child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Text('مرحبا كيف يمكنني مساعدتك؟',style: TextStyle(fontSize: 20.sp,color: Colors.black),))),
//                             ),
//                           ),
//                           SizedBox(width: 10.w,),
//                           // Spacer(),
//                           Image(
//                             image: AssetImage(AppAssets.userImage),height: 80,width: 80,),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => TarbyaPage(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.logo),height: 50,width: 50,), // الأيقونة
//                                 title: Text('كلية التربية النوعية',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => CollegeDetails(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.college),height: 50,width: 50,), // الأيقونة
//                                 title: Text('اقسام الكلية',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, Routes.calender);
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.calender),height: 50,width: 50,), // الأيقونة
//                                 title: Text('الجدول الدراسي',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => Departments(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.businessman),height: 50,width: 50,), // الأيقونة
//                                 title: Text('أعضاء هيئة التدريس',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(location: LatLng(31.222305723935566, 29.947088606746213)),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.map),height: 50,width: 50,), // الأيقونة
//                                 title: Text('الخرائط',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.settings),height: 50,width: 50,), // الأيقونة
//                                 title: Text('اعدادات',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => StudentService(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Image(
//                                   image: AssetImage(AppAssets.onlineedu),height: 50,width: 50,), // الأيقونة
//                                 title: Text('خدمات الطالب',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),), // الكلمة
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => AnnouncePage(),));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.announcement),
//                                 title: Text('الاعلانات',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }else if(state is ProfileErrorState){
//             return Center(
//               child: Text('error'),
//             );
//           }else{
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
