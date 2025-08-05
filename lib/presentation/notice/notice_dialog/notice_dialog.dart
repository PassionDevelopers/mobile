import 'dart:developer';

import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/presentation/notice/notice_dialog/notice_dialog_view_model.dart';
import 'package:could_be/presentation/notice/notice_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../core/di/di_setup.dart';

class NoticeDialog extends StatelessWidget {
  const NoticeDialog({super.key, required this.notice});
  final Notice notice;

  Widget htmlBuilder(Notice notice) {
    return Html(
      data: """
      <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>김코딩 - 개인 프로필</title>
    <style>
        /* CSS 초기화 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* 전체 페이지 스타일 */
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        /* 컨테이너 */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 헤더 스타일 */
        header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: white;
            font-weight: bold;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 2.5em;
        }

        .subtitle {
            color: #7f8c8d;
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        /* 네비게이션 */
        nav {
            background: rgba(255,255,255,0.9);
            border-radius: 25px;
            padding: 15px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        nav a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: #3498db;
            color: white;
            transform: translateY(-2px);
        }

        /* 메인 콘텐츠 */
        main {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h2 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.5em;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }

        .skill-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }

        .skill-tag {
            background: #3498db;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            transition: background 0.3s ease;
        }

        .skill-tag:hover {
            background: #2980b9;
            cursor: pointer;
        }

        /* 연락처 정보 */
        .contact-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .contact-icon {
            width: 20px;
            height: 20px;
            background: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
        }

        /* 푸터 */
        footer {
            background: rgba(255,255,255,0.9);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            backdrop-filter: blur(10px);
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            main {
                grid-template-columns: 1fr;
            }
            
            nav ul {
                flex-direction: column;
                gap: 10px;
            }
            
            h1 {
                font-size: 2em;
            }
            
            .container {
                padding: 10px;
            }
        }

        /* 애니메이션 */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeIn 0.6s ease-out;
        }

        .card:nth-child(2) {
            animation-delay: 0.2s;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 헤더 섹션 -->
        <header>
            <div class="profile-image">김</div>
            <h1>김코딩</h1>
            <p class="subtitle">웹 개발자 & 디자이너</p>
            <p>창의적이고 열정적인 개발자입니다. 사용자 경험을 중시하며 깔끔한 코드를 작성합니다.</p>
        </header>

        <!-- 네비게이션 -->
        <nav>
            <ul>
                <li><a href="#about">소개</a></li>
                <li><a href="#skills">기술</a></li>
                <li><a href="#projects">프로젝트</a></li>
                <li><a href="#contact">연락처</a></li>
            </ul>
        </nav>

        <!-- 메인 콘텐츠 -->
        <main>
            <div class="card">
                <h2>🎯 전문 분야</h2>
                <p>프론트엔드 개발에 특화되어 있으며, 사용자 친화적인 인터페이스 구현에 강점을 가지고 있습니다.</p>
                <div class="skill-list">
                    <span class="skill-tag">HTML</span>
                    <span class="skill-tag">CSS</span>
                    <span class="skill-tag">JavaScript</span>
                    <span class="skill-tag">React</span>
                    <span class="skill-tag">Vue.js</span>
                </div>
            </div>

            <div class="card">
                <h2>📞 연락처</h2>
                <div class="contact-info">
                    <div class="contact-item">
                        <div class="contact-icon">@</div>
                        <span>kim.coding@email.com</span>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon">📱</div>
                        <span>010-1234-5678</span>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon">🌍</div>
                        <span>서울, 대한민국</span>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon">💼</div>
                        <span>github.com/kimcoding</span>
                    </div>
                </div>
            </div>
        </main>

        <!-- 푸터 -->
        <footer>
            <p>&copy; 2025 김코딩. HTML & CSS 기본 예제입니다.</p>
            <p>이 페이지는 학습 목적으로 제작되었습니다.</p>
        </footer>
    </div>
</body>
</html>
      """,
    );


    return Html(
      data: notice.content ?? '',

      // style: {
      //   "body": Style(
      //     fontSize: FontSize(MyFontSizes.medium),
      //     color: AppColors.textPrimary,
      //     padding: HtmlPaddings.symmetric(horizontal: MyPaddings.large),
      //     lineHeight: LineHeight(1.6),
      //   ),
      //   "h1": Style(
      //     fontSize: FontSize(MyFontSizes.h0),
      //     fontWeight: FontWeight.w700,
      //     color: AppColors.textPrimary,
      //     margin: Margins(bottom: Margin(MyPaddings.medium, Unit.px)),
      //   ),
      //   "h2": Style(
      //     fontSize: FontSize(MyFontSizes.extraLarge),
      //     fontWeight: FontWeight.w600,
      //     color: AppColors.textPrimary,
      //     margin: Margins(bottom: Margin(MyPaddings.small, Unit.px)),
      //   ),
      //   "p": Style(
      //     margin: Margins(bottom: Margin(MyPaddings.medium, Unit.px)),
      //   ),
      //   "a": Style(
      //     color: AppColors.primary,
      //     textDecoration: TextDecoration.underline,
      //   ),
      // },
      // extensions: [
      //   TagExtension(
      //     tagsToExtend: {"flutter"},
      //     child: const FlutterLogo(),
      //   ),
      // ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final NoticeDialogViewModel viewModel = getIt<NoticeDialogViewModel>(param1: notice);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: EdgeInsets.all(MyPaddings.small),
              child: Row(
                children: [
                  SizedBox(width: MyPaddings.medium),
                  if (notice.isImportant)
                    Align(
                    alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MyPaddings.small,
                          vertical: MyPaddings.extraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MyText.small(
                          '중요',
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (notice.isImportant)
                    SizedBox(width: MyPaddings.small),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: MyText.h2(notice.title, fontWeight: FontWeight.w700,)),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppColors.border,
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MyPaddings.large),
                child: ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, state) {
                    final state = viewModel.state;
                    if(state.isLoading){
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }else if(state.notice == null || state.notice!.content == null){
                      return Center(
                        child: NotFound(notFoundType: NotFoundType.notice),
                      );
                    }
                    return htmlBuilder(state.notice!);
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}