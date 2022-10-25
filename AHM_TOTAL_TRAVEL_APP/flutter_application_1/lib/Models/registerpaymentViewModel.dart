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

  Map<String, dynamic> toJson() => {
        'id': ID,
        'pago': Montopago,
        'fecha': fechaPago,
        'idtipopago': id_TiPa,
        'tipopago': TipoPago,
        'idpaquete': id_Paquete,
        'paquete': Descripcion_Paquete,
        'idcliente': id_Cliente,
        'nombrecompleto': NombreCompleto,
        'nombre': Nombre,
        'apellido': Apellido,
        'dni': DNI,
        'telefono': Telefono
      };
  registerpaymentViewModel(
      this.ID,
      this.Montopago,
      this.fechaPago,
      this.id_TiPa,
      this.TipoPago,
      this.id_Paquete,
      this.Descripcion_Paquete,
      this.id_Cliente,
      this.NombreCompleto,
      this.Nombre,
      this.Apellido,
      this.DNI,
      this.Telefono,
      this.UsuarioCrea,
      this.UsuarioModifica);

  registerpaymentViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Montopago = json['pago'],
        fechaPago = json['fecha'],
        id_TiPa = json['idtipopago'],
        TipoPago = json['tipopago'],
        id_Paquete = json['idpaquete'],
        Descripcion_Paquete = json['paquete'],
        id_Cliente = json['idcliente'],
        NombreCompleto = json['nombrecompleto'],
        Nombre = json['nombre'],
        Apellido = json['apellido'],
        DNI = json['dni'],
        Telefono = json['telefono'];
}
