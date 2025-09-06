import 'package:go_router/go_router.dart';

class RouteService {
  final GoRouter _router;
  RouteService(this._router);

  void go(String path) => _router.go(path);
  void push(String path) => _router.push(path);
}