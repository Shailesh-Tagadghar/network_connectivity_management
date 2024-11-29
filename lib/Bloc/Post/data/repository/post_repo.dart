import 'package:dio/dio.dart';
import 'package:network_connectivity_management/Bloc/Post/data/model/post_model.dart';
import 'package:network_connectivity_management/Data/API/api_constant.dart';

class PostRepo {
  final Dio dio = Dio();
  Future<List<PostModel>> fetchPost() async {
    var response = await dio.get('$baseUrl$productAPI');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
