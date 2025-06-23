import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/icons/icons_broken.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/login_cubit/login_state.dart';


class LoginTextsFieldsSection extends StatelessWidget {
  const LoginTextsFieldsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: LoginCubit.get(context).formKey,
          child: Column(
            children: [
              CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: LoginCubit.get(context).emailController,
                prefixIcon: const Icon(IconBroken.Profile),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل بريدك الالكتروني';
                  }
                  return null;
                },
                title: 'البريد الالكتروني',
                hintText: 'ادخل بريدك الالكتروني',
              ),
              CustomTextField(
                textInputType: TextInputType.visiblePassword,
                obscureText: LoginCubit.get(context).isShowPassword,
                prefixIcon: const Icon(IconBroken.Lock),
                paddingForBottom: AppConstants.padding20h,
                suffixIcon: InkWell(
                  onTap: () {
                    LoginCubit.get(context).changePasswordVisibility();
                  },
                  child: Icon(
                    LoginCubit.get(context).isShowPassword
                        ? IconBroken.Hide
                        : IconBroken.Show,
                    color: AppColors.grey,
                  ),
                ),
                controller: LoginCubit.get(context).passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل كلمة السر';
                  }

                  return null;
                },
                title: 'كلمة السر',
                hintText: 'ادخل كلمة السر',
              ),
            ],
          ),
        );
      },
    );
  }
}
