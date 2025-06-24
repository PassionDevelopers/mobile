import 'package:could_be/domain/entities/sources.dart';

abstract class SourcesRepository {

  Future<Sources> fetchSubscribedSources();

  Future<Sources> fetchAllSources();
}