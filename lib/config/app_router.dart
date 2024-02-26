import 'package:chefio_recipe_app/modules/recipe/domain/entities/recipe.dart';
import 'package:chefio_recipe_app/common/models/user.dart';
import 'package:chefio_recipe_app/common/views/dashboard/dashboard.component.dart';
import 'package:chefio_recipe_app/common/views/onboarding/onboarding.screen.dart';
import 'package:chefio_recipe_app/modules/recipe/view/recipes_grid/detail/recipe_detail_screen.dart';
import 'package:chefio_recipe_app/modules/recipe/view/upload_recipe/upload_recipe_screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/forgot_password/confirmation/confirm_forgot_password.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/forgot_password/forgot_password.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/forgot_password/reset_password/reset_password.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/sign_in/sign_in.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/sign_up/confirmation/confirm_signup.screen.dart';
import 'package:chefio_recipe_app/modules/auth/view/sign_up/sign_up.screen.dart';
import 'package:chefio_recipe_app/modules/home/screens/home.screen.dart';
import 'package:chefio_recipe_app/modules/home/screens/search/search_screen.dart';
import 'package:chefio_recipe_app/modules/notification/notification.dart';
import 'package:chefio_recipe_app/modules/profile/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: OnboardingScreen.route,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: SignInScreen.route,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: SignUpScreen.route,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: ConfirmSignUpScreen.routeName,
          builder: (context, state) {
            final email = state.extra as String;
            return ConfirmSignUpScreen(email: email);
          },
        ),
      ],
    ),
    GoRoute(
      path: ForgotPasswordScreen.route,
      builder: (context, state) => const ForgotPasswordScreen(),
      routes: [
        GoRoute(
          path: ConfirmForgotPasswordScreen.routeName,
          builder: (context, state) {
            final email = state.extra as String;
            return ConfirmForgotPasswordScreen(email: email);
          },
        ),
        GoRoute(
          path: ResetPasswordScreen.routeName,
          builder: (context, state) => const ResetPasswordScreen(),
        ),
      ],
    ),
    GoRoute(
      path: DashBoardComponent.route,
      builder: (context, state) {
        final pageIndex = state.extra as int? ?? 0;
        return DashBoardComponent(pageIndex: pageIndex);
      },
    ),
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: NotificationsScreen.route,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: UploadRecipeScreen.route,
      builder: (context, state) => const UploadRecipeScreen(),
    ),
    GoRoute(
      path: SearchScreen.route,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: ProfileScreen.route,
      builder: (context, state) {
        final user = state.extra as User;
        return ProfileScreen(user: user);
      },
    ),
    GoRoute(
      path: RecipeDetailScreen.route,
      builder: (context, state) {
        final recipe = state.extra as Recipe;
        return RecipeDetailScreen(recipe);
      },
    ),
  ],
);