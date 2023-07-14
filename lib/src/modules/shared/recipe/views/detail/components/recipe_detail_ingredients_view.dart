import 'package:chefio_recipe_app/src/modules/shared/recipe/views/detail/recipe_detail_viewmodel.dart';
import 'package:chefio_recipe_app/src/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RecipeDetailIngredientsView extends StatelessWidget {
  const RecipeDetailIngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = context.read<RecipeDetailViewModel>().recipe.ingredients;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: AppText.bold700(context).copyWith(
              color: const Color(0xFF3D5480),
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            itemCount: ingredients.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _IngredientItem(ingredients[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          ),
        ],
      ),
    );
  }
}

class _IngredientItem extends StatelessWidget {
  const _IngredientItem(this.ingredient);

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.sp),
          decoration: const BoxDecoration(
            color: Color(0xffE3FFF8),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: AppColors.primary,
            size: 12.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          ingredient,
          style: AppText.bold500(context).copyWith(
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
