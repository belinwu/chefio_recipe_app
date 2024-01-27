import 'package:chefio_recipe_app/modules/auth/services/interfaces/i_auth_service.dart';
import 'package:chefio_recipe_app/utils/base.controller.dart';

class ForgotPasswordViewModel extends BaseController {
  final IAuthService _authService;

  ForgotPasswordViewModel({required IAuthService authService})
      : _authService = authService;

  Future<void> execute({required String email}) async {
    try {
      setBusy(true);
      await _authService.forgotPassword(email: email);
    } finally {
      setBusy(false);
    }
  }
}
