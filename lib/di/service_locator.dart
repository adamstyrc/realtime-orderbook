
import 'package:adam_kraken_task/repositories/order_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class DependencyRegistry {

  void register() {
    getIt.registerLazySingleton<OrderRepository>(() => OrderRepository());
  }
}