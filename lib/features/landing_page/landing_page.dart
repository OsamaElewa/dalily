import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalily/features/landing_page/widgets/custom_network_image.dart';
import 'package:dalily/features/landing_page/widgets/profile_image.dart';
import 'package:dalily/features/settings/logic/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/routes/app_routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/gradient_button.dart';
import '../settings/logic/profile_cubit.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Scaffold(
        body: BlocBuilder<ProfileCubit,ProfileState>(
          builder: (context, state) {
            if(state is ProfileSuccessState){
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            ProfileImage(),
                            SizedBox(width: 10.w,),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'مرحبًا بك ${ProfileCubit.get(context).userModel!.userName}',
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    speed: Duration(milliseconds: 100),
                                  ),
                                  TyperAnimatedText(
                                    'اهلا بك في تطبيق دليلي',
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    speed: Duration(milliseconds: 100),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Main Content Container
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Welcome Header
                                _buildWelcomeHeader(),

                                const SizedBox(height: 25),

                                // Faculty Gallery Card


                                CarouselSlider(
                                  items: imageUrls.map((e) {
                                    return CustomNetworkImage(borderRadius: 10, image: e);
                                  },).toList(),
                                  options: CarouselOptions(
                                    //height: 180,
                                    aspectRatio: 2.7,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.80,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration: const Duration(seconds: 1),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                SizedBox(height: 25.h,),

                                const SizedBox(height: 20),

                                // Officials Meeting Card


                                // Faculty Information Card
                                _buildFacultyInfoCard(),

                                const SizedBox(height: 20),

                                // Action Button
                                GradientButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.homeView);
                                  },
                                  title: Text(
                                    'الانتقال الي خدمات التطبيق',
                                    style: AppStyles.textStyle18.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else if (state is ProfileErrorState) {
              return Center(child: Text('Something went error'));
            } else {
              return Center(child: CircularProgressIndicator());
            }

          },
        ),
      ),
    );
  }
  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            'كلية التربية النوعية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'جامعة الإسكندرية',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2c3e50),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'كلية رائدة في مجال إعداد المعلمين المؤهلين فنياً',
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF2c3e50).withOpacity(0.7),
          ),
        ),
      ],
    );
  }
  Widget _buildFacultyInfoCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  'عن الكلية',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'كلية التربية النوعية بجامعة الإسكندرية هي كلية رائدة في مجال إعداد المعلمين المؤهلين فنياً في مجالات الاقتصاد المنزلي، والفنون، والموسيقى، وتساهم في تأهيل الطلاب لمواكبة التطورات التربوية العالمية المعاصرة. تأسست الكلية في سبتمبر 1988، وتعد واحدة من أربع كليات للمعلمين النوعية التي تم إنشاءها، لكنها هي الكلية الوحيدة التي افتتحت في الإسكندرية. تهدف الكلية إلى تخريج معلم تربوي مؤهل فنياً، قادر على المساهمة في تنمية شخصية الطلاب من خلال البرامج التربوية في تخصصات الفنون، والموسيقى، والاقتصاد المنزلي. ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'تأسست في سبتمبر 1988',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
List<String> imageUrls = [
  'https://media.elbalad.news/2024/10/large/1028/2/192.jpg',
  'https://media.gemini.media/img/Original/2020/9/15/2020_9_15_11_8_42_24.jpg',
  'https://img.youm7.com/large/202009151052215221.jpg',
  'https://media.elbalad.news/2024/10/large/887/7/992.jpg',
];






// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dalily/config/routes/app_routes.dart';
// import 'package:dalily/features/landing_page/widgets/custom_network_image.dart';
// import 'package:dalily/features/landing_page/widgets/profile_image.dart';
// import 'package:dalily/features/settings/logic/profile_cubit.dart';
// import 'package:dalily/features/settings/logic/profile_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../core/utils/app_colors.dart';
// import '../../core/utils/app_strings.dart';
// import '../../core/utils/app_styles.dart';
// import '../../core/widgets/gradient_button.dart';
//
// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileCubit()..getUser(),
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: BlocBuilder<ProfileCubit, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileSuccessState) {
//               return SafeArea(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Row(
//                             children: [
//                               ProfileImage(),
//                               SizedBox(width: 10.w,),
//                               FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: AnimatedTextKit(
//                                   repeatForever: true,
//                                   animatedTexts: [
//                                     TyperAnimatedText(
//                                       'مرحبًا بك ${ProfileCubit.get(context).userModel!.userName}',
//                                       textStyle: TextStyle(
//                                         fontSize: 24.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       speed: Duration(milliseconds: 100),
//                                     ),
//                                     TyperAnimatedText(
//                                       'اهلا بك في تطبيق دليلي',
//                                       textStyle: TextStyle(
//                                         fontSize: 24.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       speed: Duration(milliseconds: 100),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20.h),
//                         CarouselSlider(
//                           items: imageUrls.map((e) {
//                               return CustomNetworkImage(borderRadius: 10, image: e);
//                             },).toList(),
//                           options: CarouselOptions(
//                             //height: 180,
//                             aspectRatio: 2.7,
//                             enlargeCenterPage: true,
//                             viewportFraction: 0.80,
//                             autoPlay: true,
//                             autoPlayInterval: const Duration(seconds: 3),
//                             autoPlayAnimationDuration: const Duration(seconds: 1),
//                             autoPlayCurve: Curves.fastOutSlowIn,
//                             scrollDirection: Axis.horizontal,
//                           ),
//                         ),
//                         SizedBox(height: 25.h,),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.all(Radius.circular(15)),
//
//                           ),
//                             clipBehavior: Clip.antiAlias,
//                             child: Column(
//                               children: [
//                                 Image.network('https://alexu.edu.eg/images/spedu2022.png',height: 200,width: 600,fit: BoxFit.cover,),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('كلية التربية النوعية بجامعة الإسكندرية هي كلية رائدة في مجال إعداد المعلمين المؤهلين فنياً في مجالات الاقتصاد المنزلي، والفنون، والموسيقى، وتساهم في تأهيل الطلاب لمواكبة التطورات التربوية العالمية المعاصرة. تأسست الكلية في سبتمبر 1988، وتعد واحدة من أربع كليات للمعلمين النوعية التي تم إنشاءها، لكنها هي الكلية الوحيدة التي افتتحت في الإسكندرية. تهدف الكلية إلى تخريج معلم تربوي مؤهل فنياً، قادر على المساهمة في تنمية شخصية الطلاب من خلال البرامج التربوية في تخصصات الفنون، والموسيقى، والاقتصاد المنزلي. '),
//                                 ),
//
//                               ],
//                             )
//                         ),
//                         SizedBox(height: 20.h,),
//                         GradientButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, Routes.homeView);
//                           },
//                           title: Text(
//                             'الانتقال الي خدمات التطبيق',
//                             style: AppStyles.textStyle18.copyWith(
//                               color: AppColors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else if (state is ProfileErrorState) {
//               return Center(child: Text('Something went error'));
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

