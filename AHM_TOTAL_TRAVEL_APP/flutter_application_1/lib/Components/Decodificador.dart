class Decodificador {
  final int code;
  final bool success;
  final String message;
  final dynamic data;

  Decodificador(this.code, this.success, this.message, this.data);

  Decodificador.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        success = json['success'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() =>
      {'code': code, 'succes': success, 'message': message, 'data': data};
}

class ServiceDecoder {
  final int codeStatus;
  final String messageStatus;

  ServiceDecoder(this.codeStatus, this.messageStatus);

  ServiceDecoder.fromJson(Map<String, dynamic> json)
      : codeStatus = json['codeStatus'],
        messageStatus = json['messageStatus'];
}
