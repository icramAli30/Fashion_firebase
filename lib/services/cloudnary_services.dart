import 'dart:convert';

import 'package:firebase_class/config/cloudnary_config.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudniaryService {
  Future<String> uploadImage(XFile image) async {
    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload",
    );

    final bytes = await image.readAsBytes();

    final request = http.MultipartRequest("POST", uri)
      ..fields["upload_preset"] = CloudinaryConfig.uploadPreset
      ..files.add(
        http.MultipartFile.fromBytes(
          "file",
          bytes,
          filename: image.name,
        ),
      );

    final response = await request.send();

    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception(body);
    }

    final data = jsonDecode(body);

    return data["secure_url"];
  }
}