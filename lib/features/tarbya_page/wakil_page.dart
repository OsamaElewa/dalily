import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/tarbya_cubit.dart';
import 'logic/tarbya_state.dart';




class WakilPage extends StatelessWidget {
  const WakilPage({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TarbyaCubit()..getWakilData(),
      child: Scaffold(
        body: BlocBuilder<TarbyaCubit,TarbyaState>(
          builder: (context, state) {
            if(state is GetWakilSuccessState){
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
                            // const Expanded(
                            //   child: Text(
                            //     'المعلومات الشخصية',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 22,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 48), // Balance the back button
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final Wakil = TarbyaCubit.get(context).wakil[index];
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
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // Name with head indicator
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              Wakil['name']??'',
                                                              style: const TextStyle(
                                                                color: Color(0xFF2c3e50),
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),

                                                      // Position
                                                      Text(
                                                        Wakil['title']??'',
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

                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                                    itemCount: TarbyaCubit.get(context).wakil.length
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
            }else if(state is GetWakilFailureState){
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
}




// import 'package:dalily/features/tarbya_page/logic/tarbya_cubit.dart';
// import 'package:dalily/features/tarbya_page/logic/tarbya_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class WakilPage extends StatelessWidget {
//   WakilPage({super.key, required this.title, required this.index});
//   final String title;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TarbyaCubit()..getWakilData(),
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
//             if(state is GetWakilSuccessState){
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
//                           Text(title,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                           SizedBox(height: 20,),
//                           Expanded(
//                             child: ListView.separated(
//                                 itemBuilder: (context, index) {
//                                   final Wakil = TarbyaCubit.get(context).wakil[index];
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: ListTile(
//                                         title: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(Wakil['name']??'',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                                             Text(Wakil['title']??'',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                                             //Image.network(Wakil['image']!,height: 50,width: 50,)
//                                           ],
//                                         ),
//                                         // leading: Image(
//                                         //   image: AssetImage(AppAssets.art),height: 50,width: 50,),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) => SizedBox(height: 20.h,),
//                                 itemCount: TarbyaCubit.get(context).wakil.length
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }else if(state is GetWakilFailureState){
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
