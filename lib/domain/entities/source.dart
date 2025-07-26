import 'package:could_be/core/method/bias/bias_enum.dart';

class Source {
  final String id;
  final String name;
  final Bias bias;
  final String logoUrl;
  final bool isSubscribed;
  final Bias? userEvaluatedPerspective;

  Source({
    required this.id,
    required this.name,
    required this.bias,
    required this.logoUrl,
    required this.isSubscribed,
    required this.userEvaluatedPerspective
  });

  Source copyWith({
    String? id,
    String? name,
    Bias? bias,
    String? logoUrl,
    bool? isSubscribed,
    Bias? userEvaluatedPerspective,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
      bias: bias ?? this.bias,
      logoUrl: logoUrl ?? this.logoUrl,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      userEvaluatedPerspective: userEvaluatedPerspective ?? this.userEvaluatedPerspective,
    );
  }
} 