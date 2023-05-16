// To parse this JSON data, do
//
//     final updatepfpFile = updatepfpFileFromJson(jsonString);

import 'dart:convert';

UpdatepfpFile updatepfpFileFromJson(String str) => UpdatepfpFile.fromJson(json.decode(str));

String updatepfpFileToJson(UpdatepfpFile data) => json.encode(data.toJson());

class UpdatepfpFile {
  UpdatepfpFile({
    required this.pfpFile,
  });

  String pfpFile;

  factory UpdatepfpFile.fromJson(Map<String, dynamic> json) => UpdatepfpFile(
    pfpFile: json["pfpFile"],
  );

  Map<String, dynamic> toJson() => {
    "pfpFile": pfpFile,
  };
}