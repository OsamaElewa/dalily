import 'package:dalily/core/functions/show_snack_bar.dart';
import 'package:dalily/core/widgets/custom_loading.dart';
import 'package:dalily/features/announce_page/logic/announce_cubit.dart';
import 'package:dalily/features/announce_page/logic/announce_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/gradient_button.dart';

class AddAnnounce extends StatelessWidget {
  const AddAnnounce({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnounceCubit,AnnounceState>(
      listener: (context, state) {
        if(state is AnnounceSuccessState){
          showSuccessSnackBar(context: context, message: 'تم اضافة الاعلان بنجاح');
        }else if(state is AnnounceFailureState){
          showErrorSnackBar(context: context, message: 'هناك مشكلة ما');
        }
      },
      builder: (context, state) {
        return CustomLoading(
          isLoading: state is AnnounceLoadingState,
          child: Form(
            key: AnnounceCubit.get(context).formKey,
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
                GradientButton(
                  onPressed: () {
                    if (AnnounceCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      AnnounceCubit.get(context).addAnnounce();
                    }
                  },
                  title: Text(
                    'اضافة الاعلان',
                    style: AppStyles.textStyle18.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
