import 'dart:io';

import 'package:chefio_recipe_app/modules/recipe/models/recipe.dart';
import 'package:chefio_recipe_app/modules/recipe/services/i_recipe_service.dart';
import 'package:chefio_recipe_app/shared/models/failure.dart';
import 'package:chefio_recipe_app/shared/viewmodels/base_viewmodel.dart';

class ScanFoodResultsViewModel extends BaseViewModel {
  final IRecipeService _recipeService;
  late File? image;
  late String type;

  ScanFoodResultsViewModel({
    required this.type,
    required this.image,
    required IRecipeService recipeService,
  }) : _recipeService = recipeService;

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  Future<void> getRecipes() async {
    clearErrors();

    try {
      setBusy(true);
      _recipes = await _recipeService.getRecipesByScan();
    } on Failure catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
