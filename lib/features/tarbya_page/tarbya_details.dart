import 'package:dalily/features/tarbya_page/logic/tarbya_cubit.dart';
import 'package:dalily/features/tarbya_page/logic/tarbya_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/local/cache_helper.dart';
import '../calender/full_screen_image.dart';

class TarbyaDetails extends StatelessWidget {
  TarbyaDetails({super.key, required this.imageName, required this.pageTitle});
  final String imageName , pageTitle;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TarbyaCubit()..getImageUrl(imageName: imageName),
      child: Scaffold(

          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
            title: Text(pageTitle),
            backgroundColor: const Color(0xFF4facfe),
            foregroundColor: Colors.white,
            elevation: 0,
          ),




          body: BlocBuilder<TarbyaCubit,TarbyaState>(
            builder: (context, state) {
              if(state is GetImageSupabaseSuccessState){
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF4facfe), Color(0xFFF8F9FA)],
                      stops: [0.0, 0.3],
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imagePath: state.url),));
                      },
                      child: Image.network(
                        state.url,
                        height: 250.h,
                        width: 250.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }else if(state is GetImageSupabaseFailureState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('لا يوجد صورة'),
                    ],
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
      ),
    );
  }
}
