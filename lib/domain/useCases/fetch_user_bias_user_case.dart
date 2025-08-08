import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';

import '../entities/user_bias.dart';
import '../repositoryInterfaces/user_bias_interface.dart';

class FetchUserBiasUseCase {
  final UserBiasRepository _userBiasRepository;

  FetchUserBiasUseCase(this._userBiasRepository);

  Future<UserBias> execute() async {
    final result = await _userBiasRepository.fetchUserBias();
    // 사용자 성향 데이터는 중요한 분석 지표이므로 로깅
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchUserBias,
    );
    return result;
  }
}