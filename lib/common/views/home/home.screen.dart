import 'package:chefio_recipe_app/modules/recipe/view/recipes_grid/recipes_grid.dart';
import 'package:chefio_recipe_app/config/locator/locator.dart';
import 'package:chefio_recipe_app/common/views/home/components/home_categories_component.dart';
import 'package:chefio_recipe_app/common/views/home/home.controller.dart';
import 'package:chefio_recipe_app/modules/recipe/view/search/search_recipe.screen.dart';

import 'package:chefio_recipe_app/assets/assets.dart';
import 'package:chefio_recipe_app/modules/recipe/domain/repositories/i_recipe_repository.dart';
import 'package:chefio_recipe_app/styles/styles.dart';

import 'package:chefio_recipe_app/common/widgets/inputs/custom_textfield.dart';
import 'package:chefio_recipe_app/common/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    context.read<HomeController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                left: AppPadding.horizontal,
                right: AppPadding.horizontal,
              ),
              child: Hero(
                tag: 'search',
                child: Material(
                  type: MaterialType.transparency,
                  child: CustomTextField(
                    prefixIcon: const TextFieldIcon(icon: AppIcons.search),
                    hintText: 'Search',
                    readOnly: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.r),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AppColors.form,
                    onTap: () {
                      context.push(SearchRecipeScreen.route);
                    },
                  ),
                ),
              ),
            ),
            const HomeCategoriesComponent(),
            Container(
              height: 8.h,
              color: const Color(0xFFF4F5F7),
            ),
            Consumer<HomeController>(
              builder: (context, controller, _) {
                if (controller.hasError) {
                  return ErrorView(
                    error: controller.modelError,
                    refetch: init,
                  );
                }

                return RecipesGrid(
                  recipes: controller.recipes,
                  isBusy: controller.busy(HomeLoadingState.recipes),
                  onRefresh: controller.refreshRecipes,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}