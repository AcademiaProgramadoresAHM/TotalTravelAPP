class Decoder {
  final int code;
  final bool success;
  final String message;
  final dynamic data;

  Decoder(this.code, this.success, this.message, this.data);

  Decoder.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        success = json['success'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() =>
      {'code': code, 'success': success, 'message': message, 'data': data};
}