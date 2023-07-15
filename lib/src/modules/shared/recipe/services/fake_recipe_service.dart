import 'package:chefio_recipe_app/src/modules/shared/category/models/category.dart';
import 'package:chefio_recipe_app/src/modules/shared/recipe/models/recipe.dart';
import 'package:chefio_recipe_app/src/modules/shared/recipe/services/i_recipe_service.dart';
import 'package:chefio_recipe_app/src/shared/utils/constants.dart';
import 'package:chefio_recipe_app/src/shared/utils/utils.dart';

class FakeRecipeService implements IRecipeService {
  @override
  Future<List<Recipe>> getRecipes({required Category category}) async {
    await fakeNetworkDelay();
    final List<CookingStep> steps = List.generate(
      2,
      (index) => CookingStep(
        step: index + 1,
        description: faker.lorem.sentence(),
        photoUrl: getOneMealPhoto(),
      ),
    );

    final List<Recipe> items = List.generate(
      random.nextInt(200) + 25,
      (index) => Recipe(
        id: Utils.getGuid(),
        user: Chef(
          id: Utils.getGuid(),
          photoUrl: getOneProfilePhoto(),
          firstName: faker.person.firstName(),
          lastName: faker.person.firstName(),
        ),
        coverPhotoUrl: getOneMealPhoto(),
        description: faker.lorem.sentence(),
        duration: random.nextInt(100) + 50,
        ingredients: faker.lorem.words(5),
        likeCount: random.nextInt(500) + 13,
        steps: steps,
        title: faker.lorem.word(),
      ),
    );
    return items;
  }

  @override
  Future<List<Recipe>> getLikedRecipesByUser({required String userId}) async {
    await fakeNetworkDelay();
    final List<CookingStep> steps = List.generate(
      2,
      (index) => CookingStep(
        step: index + 1,
        description: faker.lorem.sentence(),
        photoUrl: getOneMealPhoto(),
      ),
    );

    final List<Recipe> items = List.generate(
      random.nextInt(200) + 25,
      (index) => Recipe(
        id: Utils.getGuid(),
        user: Chef(
          id: Utils.getGuid(),
          photoUrl: getOneProfilePhoto(),
          firstName: faker.person.firstName(),
          lastName: faker.person.firstName(),
        ),
        coverPhotoUrl: getOneMealPhoto(),
        description: faker.lorem.sentence(),
        duration: random.nextInt(100) + 50,
        ingredients: faker.lorem.words(5),
        likeCount: random.nextInt(500) + 13,
        steps: steps,
        title: faker.lorem.word(),
      ),
    );
    return items;
  }

  @override
  Future<List<Recipe>> getRecipesByUser({required String userId}) async {
    await fakeNetworkDelay();
    final List<CookingStep> steps = List.generate(
      2,
      (index) => CookingStep(
        step: index + 1,
        description: faker.lorem.sentence(),
        photoUrl: getOneMealPhoto(),
      ),
    );

    final List<Recipe> items = List.generate(
      random.nextInt(200) + 25,
      (index) => Recipe(
        id: Utils.getGuid(),
        user: Chef(
          id: Utils.getGuid(),
          photoUrl: getOneProfilePhoto(),
          firstName: faker.person.firstName(),
          lastName: faker.person.firstName(),
        ),
        coverPhotoUrl: getOneMealPhoto(),
        description: faker.lorem.sentence(),
        duration: random.nextInt(100) + 50,
        ingredients: faker.lorem.words(5),
        likeCount: random.nextInt(500) + 13,
        steps: steps,
        title: faker.lorem.word(),
      ),
    );
    return items;
  }
}
