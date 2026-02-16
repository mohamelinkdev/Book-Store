enum SplashStatus { initial, authenticated, unauthenticated }

class SplashState {
  final SplashStatus status;

  SplashState({this.status = SplashStatus.initial});
}
