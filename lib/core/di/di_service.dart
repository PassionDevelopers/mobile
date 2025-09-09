
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_service.dart';

import '../routes/router.dart';

Future<void> diServiceSetUp()async{
  //route
  getIt.registerSingleton(RouteService(router));

}