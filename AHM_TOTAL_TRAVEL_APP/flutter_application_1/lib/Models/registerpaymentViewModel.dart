class registerpaymentViewModel {
  int? ID;
  String? Montopago;
  DateTime? fechaPago;
  int? id_TiPa;
  String? TipoPago;
  int? id_Reservacion;
  int? id_Paquete;
  String? Descripcion_Paquete;
  int? id_Cliente;
  String? NombreCompleto;
  String? Nombre;
  String? Apellido;
  String? DNI;
  String? Telefono;
  String? UsuarioCrea;
  String? UsuarioModifica;

  registerpaymentViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Montopago = json['montoPago'],
        fechaPago = json['fechaPago'],
        id_TiPa = json['id_TipoPago'],
        TipoPago = json['tipoPago'],
        id_Reservacion = json['id_Reservacion'],
        id_Paquete = json['id_Paquete'],
        Descripcion_Paquete = json['descripcion_Paquete'],
        id_Cliente = json['idcliente'],
        NombreCompleto = json['nombreCompleto'],
        Nombre = json['nombre'],
        Apellido = json['apellido'],
        DNI = json['dni'],
        Telefono = json['telefono'];
}
