# Firebase Analytics 이벤트 요약

## 총 이벤트 개수: 93개

### 카테고리별 이벤트 분류

#### 1. Navigation Events (12개)
- tapHomeTab
- tapIssueTab  
- tapBlindSpotTab
- tapMediaTab
- tapMyPageTab
- navigateToIssueDetail
- navigateToMediaDetail
- navigateToTopicDetail
- navigateToWebView
- navigateToSettings
- navigateToNotice
- navigateToFeedback
- navigateToLogin
- navigateToHotIssue
- navigateToShortsPlayer
- navigateBack

#### 2. Authentication Events (7개)
- tapGoogleLogin
- tapAppleLogin
- tapKakaoLogin
- loginSuccess
- loginFailure
- tapLogout
- logoutSuccess
- sessionStart
- sessionEnd

#### 3. Issue Events (13개)
- viewIssueList
- refreshIssueList
- loadMoreIssues
- filterIssues
- sortIssues
- viewIssueDetail
- tapIssueCard
- swipeIssue
- shareIssue
- bookmarkIssue
- unbookmarkIssue
- evaluateIssue
- tapSummaryTab
- tapArticlesTab
- tapBiasTab
- tapSourcesTab
- viewHotIssue
- swipeHotIssue
- tapHotIssueMore

#### 4. Media Events (10개)
- viewMediaList
- searchMedia
- filterMediaByBias
- sortMedia
- viewMediaDetail
- tapMediaCard
- subscribeMedia
- unsubscribeMedia
- evaluateMedia
- shareMedia
- tapArticle
- readArticle
- shareArticle

#### 5. Topic Events (7개)
- viewTopicList
- searchTopic
- filterTopics
- viewTopicDetail
- tapTopicCard
- subscribeTopic
- unsubscribeTopic
- shareTopic

#### 6. User Events (13개)
- viewProfile
- editProfile
- updateNickname
- uploadProfileImage
- updateNotificationSettings
- updatePrivacySettings
- updateContentPreferences
- viewWatchHistory
- clearWatchHistory
- viewSubscribedIssues
- viewSubscribedMedia
- viewSubscribedTopics
- viewEvaluationHistory
- deleteEvaluation
- viewBiasAnalysis
- viewBiasTrend
- takePoliticalTest

#### 7. Social Events (7개)
- viewComments
- writeComment
- editComment
- deleteComment
- likeComment
- reportComment
- viewMajorOpinion
- participateInPoll
- shareOpinion

#### 8. Search Events (9개)
- tapSearchBar
- performSearch
- clearSearch
- selectSearchResult
- viewSearchHistory
- deleteSearchHistory
- searchIssues
- searchMedia
- searchTopics
- searchArticles

#### 9. Content Events (9개)
- viewShorts
- playShorts
- pauseShorts
- swipeNextShorts
- swipePreviousShorts
- tapShortsLike
- tapShortsShare
- startReadingArticle
- finishReadingArticle
- scrollArticle
- tapRelatedArticle
- tapExternalLink
- openInBrowser

#### 10. UI Events (13개)
- pullToRefresh
- openDialog
- closeDialog
- confirmDialog
- cancelDialog
- tapButton
- longPressButton
- submitForm
- cancelForm
- validateForm
- switchTab
- applyFilter
- resetFilter
- changeSortOrder
- loadNextPage
- scrollToTop

#### 11. System Events (14개)
- appOpen
- appBackground
- appForeground
- appTerminate
- checkForUpdate
- startUpdate
- completeUpdate
- skipUpdate
- receiveNotification
- tapNotification
- enableNotifications
- disableNotifications
- requestPermission
- grantPermission
- denyPermission
- networkError
- networkReconnect
- clearCache
- cacheHit
- cacheMiss

#### 12. Error Events (9개)
- apiError
- authenticationError
- networkError
- renderError
- navigationError
- parseError
- validationError
- crashError
- memoryError

## 구현 현황

현재 구현된 주요 이벤트:
1. 네비게이션 탭 전환 (5개 탭)
2. 로그인/로그아웃 관련 이벤트
3. 이슈 카드 클릭
4. 마이페이지 액션 (6개)
5. 검색 관련 이벤트
6. 설정 화면 액션
7. 앱 라이프사이클 이벤트
8. 시스템 업데이트 체크

## Analytics Manager 특징

1. **중앙화된 이벤트 관리**: 모든 Analytics 이벤트가 한 곳에서 관리됨
2. **이벤트 카운터**: 실시간으로 이벤트 발생 횟수 추적
3. **디버그 뷰**: 개발자가 이벤트 로깅 상태를 확인할 수 있는 화면 제공
4. **타입 안전성**: Enum을 사용하여 이벤트 타입의 일관성 보장
5. **확장 가능성**: 새로운 이벤트 추가가 용이한 구조