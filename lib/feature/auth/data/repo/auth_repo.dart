import 'package:dartz/dartz.dart';
import 'package:driver_mate/feature/auth/data/model/auth_model.dart';

class AuthRepo {
  UserModel? user;
  Either<String, void> register({required UserModel user}) {
    try {
      this.user = user;
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Either<String, UserModel> login({
    required String email,
    required String password,
  }) {
    try {
      if (user == null) {
        throw Exception("No user registered");
      } else {
        if (email == user!.email && password == user!.password) {
          return Right(user!);
        } else {
          return Left("Invalid email or password");
        }
      }
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
