
import 'package:could_be/data/repositoryImpl/articles_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_issue_subscription_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/manage_media_subscription_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/topics_repository_impl.dart';

import '../../../data/repositoryImpl/issue_detail_repository_impl.dart';
import '../../../data/repositoryImpl/issues_repository_impl.dart';
import '../../../data/repositoryImpl/sources_repository_impl.dart';
import '../../../data/repositoryImpl/user_bias_repository_impl.dart';
import '../../../domain/useCases/fetch_articles_use_case.dart';
import '../../../domain/useCases/fetch_issues_use_case.dart';
import '../../../domain/useCases/fetch_sources_use_case.dart';
import '../../../domain/useCases/fetch_topics_use_case.dart';
import '../../../domain/useCases/fetch_user_bias_user_case.dart';
import '../../../domain/useCases/fetch_whole_issue_use_case.dart';
import '../../../domain/useCases/manage_issue_subscription_use_case.dart';
import '../../../domain/useCases/manage_media_subscription_use_case.dart';
import '../api.dart';

final fetchIssuesUseCase = FetchIssuesUseCase(IssuesRepositoryImpl(dio));
final fetchIssueDetailUseCase = FetchIssueDetailUseCase(IssueDetailRepositoryImpl(dio));
// final fetchMediaUseCase = FetchMediaUseCase(MediaRepositoryImpl(dio));
final fetchUserBiasUseCase = FetchUserBiasUseCase(UserBiasRepositoryImpl(dio));

// final fetchSubscribedMediaAndArticlesUseCase =
//     FetchSubscribedMediaAndArticlesUseCase(SubscribedMediaArticlesRepositoryImpl(dio));

final fetchArticlesUseCase = FetchArticlesUseCase(ArticlesRepositoryImpl(dio));

final manageIssueSubscriptionUseCase =
    ManageIssueSubscriptionUseCase(ManageIssueSubscriptionRepositoryImpl(dio));

//토픽
final fetchTopicsUseCase = FetchTopicsUseCase(TopicsRepositoryImpl(dio));

//매체
final fetchSourcesUseCase = FetchSourcesUseCase(SourcesRepositoryImpl(dio));
final manageMediaSubscriptionUseCase =
    ManageMediaSubscriptionUseCase(ManageMediaSubscriptionRepositoryImpl(dio));
