import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:oktoast/oktoast.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/models/result_model.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/interface/clipboard.dart';

class ClipBoard implements IClipBoard {
  @override
  Future<R<bool>> copyToClipBoard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      showToast('COPIED');
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }

  @override
  Future<R<String>> pasteFromClipBoard() async {
    try {
      final data = await Clipboard.getData('text/plain');
      if (data == null || data.text == null) {
        return const R(result: '');
      }
      return R(result: data.text);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }
}
