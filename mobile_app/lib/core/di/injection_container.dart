// lib/core/di/injection_container.dart

import 'package:get_it/get_it.dart';
import '../../features/barcode_scan/data/repositories/mock_product_repository.dart';
import '../../features/barcode_scan/domain/repositories/product_repository.dart';
import '../../features/barcode_scan/presentation/bloc/scan_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  getIt.registerLazySingleton<ProductRepository>(
    () => MockProductRepository(),
  );

  // BLoCs
  getIt.registerFactory(
    () => ScanBloc(productRepository: getIt()),
  );
}
