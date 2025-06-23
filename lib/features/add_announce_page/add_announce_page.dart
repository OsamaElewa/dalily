import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:dalily/features/announce_page/announce_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/functions/show_snack_bar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_dropdown.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/gradient_button.dart';
import '../announce_page/logic/announce_cubit.dart';
import '../announce_page/logic/announce_state.dart';

class AddAnnouncePage extends StatelessWidget {
  const AddAnnouncePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnounceCubit(),
      child: Scaffold(
        body: BlocConsumer<AnnounceCubit,AnnounceState>(
          listener: (context, state) {
            if(state is AnnounceSuccessState){
              showSuccessSnackBar(context: context, message: 'تم اضافة الاعلان بنجاح');
              Navigator.pop(context);
            }else if(state is AnnounceFailureState){
              showErrorSnackBar(context: context, message: 'هناك مشكلة ما');
            }
          },
          builder: (context, state) {
            return CustomLoading(
              isLoading: state is AnnounceLoadingState,
              child: Form(
                key: AnnounceCubit.get(context).formKey,
                child: Container(
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
                                  CustomTextField(
                                    textInputType: TextInputType.text,
                                    controller: AnnounceCubit.get(context).announceController,
                                    prefixIcon: const Icon(Icons.announcement),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل الاعلان';
                                      }
                                      return null;
                                    },
                                    title: 'الاعلان',
                                    hintText: 'ادخل الاعلان',
                                  ),
                                  SizedBox(height: 20.h,),
                                  CustomTextField(
                                    textInputType: TextInputType.text,
                                    controller: AnnounceCubit.get(context).contentController,
                                    prefixIcon: const Icon(Icons.content_paste),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل المحتوي';
                                      }
                                      return null;
                                    },
                                    title: 'المحتوي',
                                    hintText: 'ادخل المحتوي',
                                  ),
                                  SizedBox(height: 20.h,),
                                  CustomTextField(
                                    textInputType: TextInputType.text,
                                    controller: AnnounceCubit.get(context).authorController,
                                    prefixIcon: const Icon(Icons.person_pin),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل اسمك';
                                      }
                                      return null;
                                    },
                                    title: 'بواسطة من',
                                    hintText: 'ادخل الاسم',
                                  ),
                                  SizedBox(height: 20.h,),
                                CustomDropdown(
                                  title: 'النوع',
                                  hintText: 'ادخل نوع الاعلان',
                                  messageForValidate: 'من فضلك اختر نوع الاعلان',
                                  items: typeDropDown.map(
                                        (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  ).toList(),
                                  onChange: (value) {
                                    AnnounceCubit.get(context).dropdownValue = value;
                                    print(AnnounceCubit.get(context).dropdownValue);
                                  }, isTitled: true,
                                ),
                                  SizedBox(height: 20.h,),
                                  GradientButton(
                                    onPressed: () {
                                      if (AnnounceCubit.get(context)
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        AnnounceCubit.get(context).addAnnounce();
                                      }
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
                                  ),
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
          },
        ),
      ),
    );
  }
}
List<String> typeDropDown = [
  'اجازة',
  'امتحان',
  'ورشة عمل',
];
