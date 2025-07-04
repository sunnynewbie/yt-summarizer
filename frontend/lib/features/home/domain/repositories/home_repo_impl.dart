import 'package:dio/src/response.dart';
import 'package:frontend/features/home/data/datasources/home_source.dart';
import 'package:frontend/features/home/data/repositories/home_repository.dart';

class HomeRepoImpl extends HomeRepository{
  HomeSource homeSource;

  HomeRepoImpl(this.homeSource);

  @override
  Future<Response?> submitUrl({required Map<String, dynamic> data}) {
    return homeSource.submitUrl(data: data);
  }

}