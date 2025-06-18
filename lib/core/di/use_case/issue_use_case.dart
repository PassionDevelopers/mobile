

import '../../../data/repositoryImpl/issues_repository_impl.dart';
import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../api.dart';

final fetchIssuesUseCase = FetchIssuesUseCase(IssuesRepositoryImpl(dio));

