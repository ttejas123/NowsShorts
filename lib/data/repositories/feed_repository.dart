import 'package:bl_inshort/data/dto/feed/feed_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';

class FeedRepository {
  final Dio dio;

  FeedRepository(this.dio);

  Future<List<FeedEntity>> fetchFeed() async {
    final response = await dio.get("/feed");
    return FeedResponseDto.toEntityFromJson(response.data);
  }
}
