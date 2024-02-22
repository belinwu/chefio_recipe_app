import 'package:chefio_recipe_app/common/views/dashboard/dashboard_view.dart';
import 'package:chefio_recipe_app/config/locator/locator.dart';
import 'package:chefio_recipe_app/modules/auth/domain/usecases/i_sign_in.repository.dart';
import 'package:chefio_recipe_app/modules/auth/view/sign_in/sign_in.controller.dart';
import 'package:chefio_recipe_app/modules/auth/view/forgot_password/forgot_password.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/sign_up/sign_up.screen.dart';
import 'package:chefio_recipe_app/modules/auth/widgets/auth_view.dart';
import 'package:chefio_recipe_app/assets/icons.dart';
import 'package:chefio_recipe_app/common/models/failure.dart';
import 'package:chefio_recipe_app/styles/colors.dart';
import 'package:chefio_recipe_app/styles/text.dart';
import 'package:chefio_recipe_app/common/widgets/buttons/custom_button.dart';
import 'package:chefio_recipe_app/common/widgets/inputs/custom_textfield.dart';
import 'package:chefio_recipe_app/common/widgets/inputs/password_textfield.dart';
import 'package:chefio_recipe_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static String route = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInController(
        signInRepository: locator<ISignInRepository>(),
      ),
      child: const _SignInScreen(),
    );
  }
}

class _SignInScreen extends StatefulWidget {
  const _SignInScreen();

  @override
  State<_SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<_SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<SignInController>().execute();

        if (!mounted) {
          return;
        }

        AppNavigator.pushAndRemoveUntil(context, const DashBoardView());
        Messenger.success(context: context, message: 'Login successful');
      } on Failure catch (e) {
        Messenger.error(context: context, message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInController>();

    return PopScope(
      canPop: false,
      child: AuthView(
        title: 'Welcome Back!',
        subtitle: 'Please enter your account here',
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Email',
                prefixIcon: const TextFieldIcon(icon: AppIcons.email),
                controller: controller.emailController,
                validator: Validator.validateEmail,
              ),
              SizedBox(height: 16.h),
              PasswordTextField(
                controller: controller.passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  AppNavigator.to(context, const ForgotPasswordScreen());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: AppText.bold500(context).copyWith(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 72.h),
              AppButton(
                label: 'Login',
                isBusy: controller.isBusy,
                onPressed: signIn,
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Or continue with',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 15.sp,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              AppButtonWithIcon(
                label: 'Google',
                onPressed: () {},
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  context.push(SignUpScreen.route);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have any account? ',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 16.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: AppText.bold700(context).copyWith(
                            fontSize: 16.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 41.h),
            ],
          ),
        ),
      ),
    );
  }
}
