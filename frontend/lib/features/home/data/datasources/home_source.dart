import 'package:dio/src/response.dart';
import 'package:frontend/features/home/data/repositories/home_repository.dart';
import 'package:frontend/features/home/domain/usecases/submit_usecase.dart';
import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/api_service.dart';

class HomeSource extends HomeRepository {
  @override
  Future<Response?> submitUrl({required Map<String, dynamic> data}) async {
    try {
      var response = await ApiService().post(path: ApiPath.submit, data: data);
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

}
