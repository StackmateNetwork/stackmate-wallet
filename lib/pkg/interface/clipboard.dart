import 'package:stackmate_wallet/app/common/models/result_model.dart';

abstract class IClipBoard {
  Future<R<bool>> copyToClipBoard(String tex);
  Future<R<String>> pasteFromClipBoard();
}
