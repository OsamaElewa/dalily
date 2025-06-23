import 'package:dalily/features/authentication/data/models/user_model.dart';
import 'package:dalily/features/settings/widgets/customer_information.dart';
import 'package:dalily/features/settings/widgets/info_row_section.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
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
          // Profile Avatar with gradient border
          CustomerInformation(),
          const SizedBox(height: 20),

          // User Info
          InfoRowSection(icon: Icons.person_outline, label: 'الاسم', value: userModel.userName!),
          const SizedBox(height: 15),
          InfoRowSection(icon: Icons.email_outlined, label: 'البريد الالكتروني', value: userModel.userEmail!),
          const SizedBox(height: 15),
          InfoRowSection(icon: Icons.school_outlined, label: 'الفرقة', value: userModel.userClass!),
          const SizedBox(height: 15),
          InfoRowSection(icon: Icons.computer_outlined, label: 'القسم', value: userModel.userDepartment!),
        ],
      ),
    );
  }
}
