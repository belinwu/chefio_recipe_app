import 'package:chefio_recipe_app/src/modules/auth/widgets/auth_view.dart';
import 'package:chefio_recipe_app/src/shared/styles/colors.dart';
import 'package:chefio_recipe_app/src/shared/styles/text.dart';
import 'package:chefio_recipe_app/src/shared/widgets/buttons/custom_button.dart';
import 'package:chefio_recipe_app/src/shared/widgets/inputs/otp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    Key? key,
    required this.controller,
    required this.time,
    required this.verify,
    required this.resend,
  }) : super(key: key);

  final TextEditingController controller;
  final String time;
  final Function() verify;
  final Function() resend;

  @override
  Widget build(BuildContext context) {
    return AuthView(
      title: 'Check your email',
      subtitle: 'We.ve sent the code to your email',
      body: Column(
        children: [
          OTPField(controller: controller),
          SizedBox(height: 48.h),
          _CodeExpiration(time: time),
          SizedBox(height: 24.h),
          AppButton(
            label: 'Verify',
            onPressed: verify,
          ),
          SizedBox(height: 16.h),
          AppButton(
            label: 'Send again',
            labelColor: AppColors.secondaryText,
            showBorder: true,
            backgroundColor: Colors.white,
            onPressed: resend,
          ),
        ],
      ),
    );
  }
}

class _CodeExpiration extends StatelessWidget {
  const _CodeExpiration({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    final style = AppText.bold500(context).copyWith(
      fontSize: 15.sp,
    );

    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "code expires in:",
              style: style,
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: time,
              style: style.copyWith(color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
