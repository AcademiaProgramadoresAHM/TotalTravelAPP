class Decodificador {
  final int code;
  final bool success;
  final String message;
  final List<dynamic> data;

  Decodificador(this.code, this.success, this.message, this.data);

  Decodificador.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        success = json['success'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() =>
      {'code': code, 'succes': success, 'message': message, 'data': data};
}
