class TimelineViewModel{
  List<Actividades>? actividades;
  int? id_Hotel;
  String? Hotel;
  String? Fecha_Entrada;
  String? Fecha_Salida;
  int? iD_Transporte;
  String? Transporte;
  String? Hora_Salida;
  String? Hora_Llegada;
  int? iD_Cliente;
  String? nombre_Cliente;
  String? apellido_Cliente;

  TimelineViewModel(this.actividades, this.id_Hotel, this.Hotel,this.Fecha_Entrada, 
  this.Fecha_Salida, this.iD_Transporte, this.Transporte, this.Hora_Salida, this.Hora_Llegada,
  this.iD_Cliente, this.nombre_Cliente, this.apellido_Cliente);

  TimelineViewModel.fromJson(Map<String, dynamic> json)
  : id_Hotel = json['id'],
    Hotel = json[''],
    Fecha_Entrada = json[''],
    Fecha_Salida = json[''],
    iD_Transporte = json[''],
    Transporte = json[''],
    Hora_Salida = json[''],
    Hora_Llegada = json[''],
    iD_Cliente = json[''],
    nombre_Cliente = json[''],
    apellido_Cliente = json[''];
}

class Actividades {
  int? id_actividad;
  String? nombre_actividad;
  String fecha_Actividad;

  Actividades(this.id_actividad, this.nombre_actividad, this.fecha_Actividad);

  Actividades.fromJson(Map<String, dynamic> json)
      : id_actividad = json['id'],
        nombre_actividad = json['actividad'],
        fecha_Actividad = json['fecha'];
}

