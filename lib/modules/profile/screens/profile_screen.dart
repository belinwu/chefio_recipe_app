import 'package:chefio_recipe_app/config/locator/locator.dart';
import 'package:chefio_recipe_app/modules/profile/screens/profile_viewmodel.dart';
import 'package:chefio_recipe_app/modules/profile/screens/tabs/profile_recipes_tab_view.dart';
import 'package:chefio_recipe_app/modules/profile/screens/tabs/profile_recipes_viewmodel.dart';
import 'package:chefio_recipe_app/modules/shared/recipe/services/i_recipe_service.dart';
import 'package:chefio_recipe_app/shared/extensions/string.dart';
import 'package:chefio_recipe_app/shared/models/user.dart';
import 'package:chefio_recipe_app/shared/styles/text.dart';
import 'package:chefio_recipe_app/shared/widgets/others/custom_cached_network_image.dart';
import 'package:chefio_recipe_app/shared/widgets/others/custom_tabbar.dart';
import 'package:chefio_recipe_app/shared/widgets/others/sliver_appbar_delegate.dart';
import 'package:chefio_recipe_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<ProfileViewModel>();
    final User user = viewmodel.user;
    final bool? isAuthUserProfile = viewmodel.isAuthUserProfile;

    if (isAuthUserProfile == null) {
      return const SizedBox.shrink();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 24.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomCacheNetworkImage(
                            image: user.photoUrl,
                            height: 100.h,
                            width: 100.h,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          user.fullName.toTitleCase,
                          textAlign: TextAlign.center,
                          style: AppText.bold700(context).copyWith(
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Wrap(
                          spacing: 55.w,
                          children: [
                            _CountColumn(label: 'Recipes', count: user.recipeCount),
                            _CountColumn(label: 'Following', count: user.followingCount),
                            _CountColumn(label: 'Followers', count: user.followersCount),
                          ],
                        ),
                        if (isAuthUserProfile == false)
                          Padding(
                            padding: EdgeInsets.only(top: 32.h),
                            child: AppButton(
                              label: 'Follow',
                              onPressed: () {},
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    maxHeight: 70.h,
                    minHeight: 70.h,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: const [
                          GreyDivider(),
                          CustomTabBar(
                            tabs: [
                              Tab(text: 'Recipes'),
                              Tab(text: 'Liked'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                ChangeNotifierProvider(
                  create: (_) => UserRecipesViewModel(
                    user: user,
                    recipeService: locator<IRecipeService>(),
                  ),
                  child: const ProfileRecipesTabView<UserRecipesViewModel>(),
                ),
                ChangeNotifierProvider(
                  create: (_) => UserLikedRecipesViewModel(
                    user: user,
                    recipeService: locator<IRecipeService>(),
                  ),
                  child: const ProfileRecipesTabView<UserLikedRecipesViewModel>(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountColumn extends StatelessWidget {
  const _CountColumn({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          textAlign: TextAlign.center,
          style: AppText.bold700(context).copyWith(
            color: const Color(0xFF3D5480),
            fontSize: 17.sp,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppText.bold500(context).copyWith(
            fontSize: 12.sp,
            color: const Color(0xFF9FA5C0),
          ),
        ),
      ],
    );
  }
}