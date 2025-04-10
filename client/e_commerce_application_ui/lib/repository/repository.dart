
import '../features/auth/models/token_model.dart';
import '../features/auth/models/user_model.dart';
import '../provider/my_api_provider.dart';

class Repository {
  final MyApiProvider myApiProvider;

  Repository(this.myApiProvider);

  Future<TokenModel> login(Map<String, dynamic> map) =>
      myApiProvider.login(map);

  Future<UserModel> getProfile() => myApiProvider.getProfile();
}
