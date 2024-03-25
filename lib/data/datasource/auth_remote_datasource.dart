// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:flutter_posresto_app/core/core/constants/variable.dart';
import 'package:flutter_posresto_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_posresto_app/data/models/response/auth_response_mode.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left('Failed to login');
    }
  }

  // logout
  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(true);
    } else {
      return Left('Failed to logout');
    }
  }
}
