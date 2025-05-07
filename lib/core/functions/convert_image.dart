import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<Uri> getAssetImageFileUri(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getTemporaryDirectory()).path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return Uri.file(file.path);
  }