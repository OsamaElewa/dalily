import 'package:dalily/config/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../config/routes/app_routes.dart';
import '../utils/app_colors.dart';

void showAlertDialog({
  required BuildContext context,
  required String message,
  bool isNotError = true,
  String? title,
  String? image,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      //title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image == null ? const SizedBox()
              : Image(image: AssetImage(image),height: 100.h,width: 100.w,),
          SizedBox(height: 10.h,),
          Text(message),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isNotError,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('الغاء',style: TextStyle(color: AppColors.primary),),
                ),
              ),
              TextButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  CacheHelper.removeData(key: 'uId');
                  if(context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.loginView, (route) => false);
                  }
                },
                child: const Text('نعم',style: TextStyle(color: AppColors.redAccent),),
              ),

            ],
          )
        ],
      ),
    ),
  );
}

void showAlertDialogBeauty({
  required BuildContext context,
})
{
  showDialog(
      context: context,
      builder: (_) =>  AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(
                Radius.circular(10.0))),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return Container(
              height: height - 580,
              width: width ,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    right: -40,
                    top: -40,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Form(

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter user name',
                              labelText: 'User name',
                              labelStyle: TextStyle(color: Colors.grey,fontSize: 13),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              labelText: 'password',
                              labelStyle: TextStyle(color: Colors.grey,fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletPage()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )
  );
}