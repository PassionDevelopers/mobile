
import 'package:go_router/go_router.dart';

class RouteService {
  final GoRouter _router;
  RouteService(this._router);

  void go(String path, {Object? extra}) => _router.go(path, extra: extra);
  void push(String path, {Object? extra}) => _router.push(path, extra: extra);

}