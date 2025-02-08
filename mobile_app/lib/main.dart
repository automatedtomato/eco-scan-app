import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/navigation/app_navigation.dart';
import 'core/theme/app_theme.dart';
import 'features/barcode_scan/presentation/bloc/scan_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScanBloc>(
          create: (_) => getIt<ScanBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'EcoScan',
        theme: AppTheme.theme,
        home: const AppNavigator(),
      ),
    );
  }
}
