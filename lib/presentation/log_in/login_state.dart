class LoginState{
  final bool isLoginInProgress;
  LoginState({
    this.isLoginInProgress = false,
  });

  LoginState copyWith({
    bool? isLoginInProgress,
  }) {
    return LoginState(
      isLoginInProgress: isLoginInProgress ?? this.isLoginInProgress,
    );
  }

}