import 'package:get/get.dart';

/// 封裝 Get.snackbar，避免排隊：
/// - 若當前已有 Snackbar 顯示，直接丟棄新訊息（不入佇列）
/// - 提供 close() 手動關閉（例如測試結尾或切頁）
class AppNotify {
  AppNotify._();

  static void snackbar(String title, String message, {Duration duration = const Duration(milliseconds: 2500)}) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, duration: duration);
  }

  static void close() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
  }
}


