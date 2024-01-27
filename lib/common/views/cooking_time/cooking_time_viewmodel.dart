import 'package:chefio_recipe_app/utils/base.controller.dart';

const minCookingTimeInMinutes = 10.0;
const maxCookingTimeInMinutes = 60.0;

class CookingTimeViewModel extends BaseController {
  double _cookingTimeInMinutes = minCookingTimeInMinutes;
  double get cookingTimeInMinutes => _cookingTimeInMinutes;

  void setCookingTime(double value) {
    _cookingTimeInMinutes = value;
    notifyListeners();
  }
}
