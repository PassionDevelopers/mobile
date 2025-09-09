import '../../entities/source/source_detail.dart';

abstract class SourceDetailRepository{
  Future<SourceDetail> fetchSourceDetailById(String id);

}