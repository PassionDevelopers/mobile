enum ReportCategory {
  user,
  issue,
  comment
}

enum UserReportReason {
  IMPERSONATION("사칭/허위 신원"),
  SPAM_ADVERTISEMENT("스팸/광고"),
  SEXUAL_CONTENT("선정적/음란물"),
  VIOLENCE_HATE("폭력적/혐오적 표현"),
  HARASSMENT("괴롭힘/스토킹"),
  PERSONAL_INFORMATION("개인정보 노출"),
  DEFAMATION("명예훼손/비방"),
  ILLEGAL_ACTIVITY("불법 행위 조장"),
  OTHER("기타 부적절한 행동");

  const UserReportReason(this.value);
  final String value;
}

enum IssueReportReason {
  MISLEADING_TITLE("낚시성 제목"),
  DISTORTION("왜곡/오보"),
  FALSE_INFORMATION("허위 정보"),
  SPAM_ADVERTISEMENT("스팸/광고성 콘텐츠"),
  SEXUAL_CONTENT("선정적/음란물"),
  VIOLENCE_HATE("폭력적 표현");

  const IssueReportReason(this.value);
  final String value;
}

enum CommentReportReason {
  ABUSIVE_LANGUAGE("욕설/비속어"),
  FLOODING("도배성 댓글"),
  HARASSMENT("특정 이용자 괴롭힘"),
  FALSE_SOURCE("잘못된 출처"),
  SPAM_ADVERTISEMENT("스팸/광고성 콘텐츠"),
  SEXUAL_CONTENT("선정적/음란물"),
  VIOLENCE_HATE("폭력적/혐오적 표현"),
  DISCRIMINATION("차별/혐오 발언"),
  PERSONAL_INFORMATION("개인정보 노출"),
  DEFAMATION("명예훼손/비방"),
  OTHER("기타 부적절한 내용");

  const CommentReportReason(this.value);
  final String value;
}

abstract class ReportRepository {
  Future<void> report({
    required String contentId,
    required String contentType,
    required String reason,
    String? description,
  });
}