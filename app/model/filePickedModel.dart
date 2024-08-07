// ignore_for_file: file_names

class FilePicked {
  FilePicked(
      {this.path,
      this.extension,
      this.size,
      this.name,
      this.sizeValid,
      required this.isNetworkImage});

  FilePicked.fromJson(dynamic json) {
    path = json['path'];
    extension = json['extension'];
    size = json['size'];
    sizeValid = json['sizeValid'];
    name = json['name'];
    isNetworkImage = false;
  }

  String? path;
  String? extension;
  String? size;
  dynamic sizeValid;
  String? name;
  bool isNetworkImage = false;
}
