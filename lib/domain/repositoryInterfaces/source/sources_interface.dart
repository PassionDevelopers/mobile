import 'package:could_be/domain/entities/source/sources.dart';

abstract class SourcesRepository {

  Future<Sources> fetchSubscribedSources();

  Future<Sources> fetchEvaluatedSources();

  Future<Sources> fetchAllSources();
}