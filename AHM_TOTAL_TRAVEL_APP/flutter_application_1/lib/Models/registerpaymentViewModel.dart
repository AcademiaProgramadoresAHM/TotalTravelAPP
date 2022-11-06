class registerpaymentViewModel {
  int? ID;
  String? MontoPago;
  DateTime? fechaPago;
  int? Id_TipoPago;
  String? TipoPago;
  int? Id_Reservacion;
  int? Id_Paquete;
  String? Descripcion_Paquete;
  String? nombre_paquete;
  String? precio_paquete;
  int? Id_Cliente;
  String? NombreCompleto;
  String? Nombre;
  String? Apellido;
  String? DNI;
  String? Telefono;
  String? UsuarioCrea;
  String? UsuarioModifica;

  registerpaymentViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        MontoPago = json['montoPago'],
        fechaPago = json['fechaPago'],
        Id_TipoPago = json['id_TipoPago'],
        TipoPago = json['tipoPago'],
        Id_Reservacion = json['id_Reservacion'],
        Id_Paquete = json['id_Paquete'],
        Descripcion_Paquete = json['descripcion_paquete'],
        nombre_paquete = json['nombre_paquete'],
        precio_paquete = json['precio_paquete'],
        Id_Cliente = json['id_cliente'],
        NombreCompleto = json['nombre_Completo'],
        Nombre = json['nombre'],
        Apellido = json['apellido'],
        DNI = json['dni'],
        Telefono = json['telefono'];
}

class TypePaymentModel {
  int? id;
  String? descripcion;

  Map<String, dynamic> toJson() => {"id": id, "descripcion": descripcion};
  TypePaymentModel(this.id, this.descripcion);

  TypePaymentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descripcion = json['descripcion'];
}

class RecordPaymentModel {
  int? resvId;
  int? tiPaId;
  double? rePaMonto;
  String? rePaFechaPago;
  int? rePaUsuarioCreacion;
  int? rePaUsuarioModifica;

  Map<String, dynamic> toJson() => {
        "resv_ID": resvId,
        "tiPa_ID": tiPaId,
        "rePa_Monto": rePaMonto,
        "rePa_FechaPago": rePaFechaPago.toString(),
        "rePa_UsuarioCreacion": rePaUsuarioCreacion,
        "rePa_UsuarioModifica": rePaUsuarioModifica,
      };
}

class ModelDataRecordPayment {
  int? idpayment;
  double? monto;
  String? formatted;
}
