import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({super.key, required this.message});

  final String message;

  static Future<void> show(BuildContext context, {required String message}) async {
    await Get.dialog<void>(
      AppErrorDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('錯誤'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back<void>(),
          child: const Text('確定'),
        ),
      ],
    );
  }
}

/// 啟動器：監聽 RxString，當有值時彈出錯誤視窗；點擊「確定」後清空。
class AppErrorDialogLauncher extends StatefulWidget {
  const AppErrorDialogLauncher({super.key, required this.error});

  final RxString error;

  @override
  State<AppErrorDialogLauncher> createState() => _AppErrorDialogLauncherState();
}

class _AppErrorDialogLauncherState extends State<AppErrorDialogLauncher> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final text = widget.error.value;
      if (text.isEmpty) return const SizedBox.shrink();
      Future.microtask(() async {
        await Get.dialog<void>(AppErrorDialog(message: text));
        widget.error.value = '';
      });
      return const SizedBox.shrink();
    });
  }
}


