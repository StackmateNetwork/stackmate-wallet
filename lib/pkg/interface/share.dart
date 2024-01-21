import 'package:stackmate_wallet/app/common/models/result_model.dart';

abstract class IShare {
  Future<R<bool>> share({required String text, required String subjectForEmail});
}
