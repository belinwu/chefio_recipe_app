import 'package:chefio_recipe_app/modules/recipe/view/search/sheets/filter/search_filter.controller.dart';
import 'package:chefio_recipe_app/styles/styles.dart';
import 'package:chefio_recipe_app/common/widgets/others/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchFilterCategoriesComponent extends StatelessWidget {
  const SearchFilterCategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<SearchFilterViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Text(
            'Category',
            style: AppText.bold700(context).copyWith(
              fontSize: 17.sp,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: viewmodel.categories.length,
            padding: AppPadding.symetricHorizontalOnly,
            itemBuilder: (context, index) {
              final selectedCategory = viewmodel.selectedCategory;
              final category = viewmodel.categories[index];
              final selected = category.id == selectedCategory.id;

              return CategoryItemView(
                label: category.name,
                selected: selected,
                onTap: () => viewmodel.selectCategory(category),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}