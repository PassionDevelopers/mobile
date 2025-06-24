import '../entities/user_bias.dart';

abstract class UserBiasRepository{
  Future<UserBias> fetchUserBias();
}