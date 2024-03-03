import 'package:chefio_recipe_app/modules/recipe/domain/entities/recipe_category.dart';
import 'package:chefio_recipe_app/modules/recipe/domain/entities/recipe.dart';
import 'package:chefio_recipe_app/common/models/failure.dart';
import 'package:chefio_recipe_app/modules/recipe/domain/repositories/i_recipe_repository.dart';
import 'package:chefio_recipe_app/utils/base.controller.dart';

enum HomeLoadingState { init, recipes }

class HomeController extends BaseController {
  HomeController({required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  final IRecipeRepository _recipeRepository;

  List<RecipeCategory> _categories = [];

  List<RecipeCategory> get categories => _categories;

  RecipeCategory? _selectedCategory;

  RecipeCategory? get selectedCategory => _selectedCategory;

  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void selectCategory(RecipeCategory category) {
    _selectedCategory = category;

    if (category.name == 'All') {
      _getRecipesForCategory(category: null);
    } else {
      _getRecipesForCategory(category: category);
    }
  }

  Future<void> init() async {
    try {
      setBusyForObject(HomeLoadingState.init, true);
      await Future.wait([
        _getCategories(),
        _initRecipes(),
      ]);
    } on Failure catch (e) {
      setError(e);
    } finally {
      setBusyForObject(HomeLoadingState.init, false);
    }
  }

  Future<void> _getCategories() async {
    _categories = await _recipeRepository.getCategories();

    if (_categories.isNotEmpty) {
      _selectedCategory = _categories.first;
    }
  }

  Future<void> _initRecipes() async {
    _getRecipesForCategory(category: null);
  }

  void _getRecipesForCategory({required RecipeCategory? category}) async {
    try {
      setBusyForObject(HomeLoadingState.recipes, true);
      await _getRecipes(category);
    } on Failure catch (e) {
      setError(e);
    } finally {
      setBusyForObject(HomeLoadingState.recipes, false);
    }
  }

  Future<void> refreshRecipes() async {
    _getRecipesForCategory(category: selectedCategory);
  }

  Future<void> _getRecipes(RecipeCategory? category) async {
    clearErrors();
    _recipes = await _recipeRepository.getRecipes(category: category);
  }
}
