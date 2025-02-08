// lib/features/barcode_scan/presentation/widgets/barcode_scanner_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/scan_bloc.dart';
import '../bloc/scan_state.dart';

class BarcodeScannerWidget extends StatelessWidget {
  final Function(String) onBarcodeDetected;
  final Function(Exception) onError;

  const BarcodeScannerWidget({
    super.key,
    required this.onBarcodeDetected,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Stack(
        children: [
          // スキャンエリアを示す枠
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'スキャンエリア',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // テスト用のボタン
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showBarcodeInputDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008080),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'バーコードを入力',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // テスト用にダミーのバーコードをスキャン
                    context.read<ScanBloc>().add(
                          const BarcodeScanned('4912345678904'),
                        );
                  },
                  child: const Text(
                    'テストスキャン',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBarcodeInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        String barcode = '';
        return AlertDialog(
          title: const Text('バーコードを入力'),
          content: TextField(
            decoration: const InputDecoration(
              hintText: '例: 4912345678904',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              barcode = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                if (barcode.isNotEmpty) {
                  // 元のcontextを使用してBLoCにアクセス
                  context.read<ScanBloc>().add(BarcodeScanned(barcode));
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('スキャン'),
            ),
          ],
        );
      },
    );
  }
}
