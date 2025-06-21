
import '../../../data/repositoryImpl/issues_repository_impl.dart';
import '../../../data/repositoryImpl/media_repository_impl.dart';
import '../../../data/repositoryImpl/whole_issue_repository_impl.dart';
import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../../../domain/useCases/fetch_media_use_case.dart';
import '../../../domain/useCases/fetch_whole_issue_use_case.dart';
import '../api.dart';

final fetchIssuesUseCase = FetchIssuesUseCase(IssuesRepositoryImpl(dio));
final fetchWholeIssueUseCase = FetchWholeIssueUseCase(WholeIssueRepositoryImpl(dio));
final fetchMediaUseCase = FetchMediaUseCase(MediaRepositoryImpl(dio));

