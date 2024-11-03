
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shope_ease/network/model_class/NewsFeedsResponse.dart';
import 'package:shope_ease/utils/constants.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl) //live link

abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl, String? token}) {
    dio.options =
        BaseOptions(receiveTimeout: const Duration(milliseconds: 6000), connectTimeout: const Duration(milliseconds: 6000), headers: {
      'Authorization': 'Bearer $token',
    });
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET('news')
  Future<NewsFeedsResponse> getNewsFeeds(
      @Query("apikey") String apiKey,
      @Query("q") String query,
      );

}
