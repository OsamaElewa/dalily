import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/icons/icons_broken.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../cubits/register_cubit/register_cubit.dart';
import '../../cubits/register_cubit/register_state.dart';


class RegisterTextsFieldsSection extends StatelessWidget {
  const RegisterTextsFieldsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: RegisterCubit.get(context).formKey,
          child: Column(
            children: [
              CustomTextField(
                textInputType: TextInputType.name,
                controller: RegisterCubit.get(context).nameController,
                prefixIcon: const Icon(IconBroken.Profile),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل اسمك';
                  }
                  return null;
                },
                title: 'الاسم',
                hintText: 'ادخل اسمك',
              ),
              CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: RegisterCubit.get(context).emailController,
                prefixIcon: const Icon(Icons.email_outlined),
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
                controller: RegisterCubit.get(context).passwordController,
                obscureText: RegisterCubit.get(context).isShowPassword,
                prefixIcon: const Icon(IconBroken.Lock),
                paddingForBottom: AppConstants.padding20h,
                suffixIcon: InkWell(
                  onTap: () {
                    RegisterCubit.get(context).changePasswordVisibility();
                  },
                  child: Icon(
                    RegisterCubit.get(context).isShowPassword
                        ? IconBroken.Hide
                        : IconBroken.Show,
                    color: AppColors.grey,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل كلمة السر الخاصة بك';
                  } else if (value.length < 8) {
                    return 'كلمة السر قصيرة للغاية';
                  }
                  return null;
                },
                title: 'كلمة السر',
                hintText: 'ادخل كلمة السر الخاصة بك',
              ),
            ],
          ),
        );
      },
    );
  }
}
