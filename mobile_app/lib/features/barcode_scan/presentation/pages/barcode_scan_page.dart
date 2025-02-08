import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product_detail/presentation/pages/scan_result_page.dart';
import '../bloc/scan_bloc.dart';
import '../bloc/scan_state.dart';
import '../widgets/barcode_scanner_widget.dart';

class BarcodeScanPage extends StatelessWidget {
  const BarcodeScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, ScanState>(
      listener: (context, state) {
        if (state is ScanSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ScanResultPage(),
            ),
          );
        } else if (state is ScanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('バーコードスキャン'),
          backgroundColor: const Color(0xFF008080),
        ),
        body: BarcodeScannerWidget(
          onBarcodeDetected: (barcode) {
            debugPrint('Detected barcode: $barcode');
          },
          onError: (error) {
            debugPrint('Scan error: $error');
          },
        ),
      ),
    );
  }
}
