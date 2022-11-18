class DefaultPackageViewModel {
  int? ID;
  String? Nombre;
  String? Descripcion;
  String? Duracion;
  double? Precio;
  String? Hotel;
  String? Restaurante;

  Map<String, dynamic> toJson() => {
        'id': ID,
        'nombre': Nombre,
        'descripcion_Paquete': Descripcion,
        'duracion_Paquete': Duracion,
        'precio': Precio,
        'hotel': Hotel,
        'restaurante': Restaurante
      };
  DefaultPackageViewModel(this.ID, this.Nombre, this.Descripcion, this.Duracion,
      this.Hotel, this.Precio, this.Restaurante);
  DefaultPackageViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Descripcion = json['descripcion_Paquete'],
        Duracion = json['duracion_Paquete'],
        Precio = json['precio'],
        Hotel = json['hotel'],
        Restaurante = json['restaurante'];
}

class DefaultPackageModel {
  int? id;
  String? nombre;
  String? descripcionPaquete;
  String? duracionPaquete;
  double? precio;
  int? iDHotel;
  String? hotel;
  String? descripcionHotel;
  int? ciudadID;
  String? Ciudad;
  int? iDRestaurante;
  String? restaurante;
  int? iDUsuarioCreacion;
  String? usuarioCreacion;
  DateTime? fechaCreacion;
  dynamic? iDUsuarioModifica;
  String? usuarioModifica;
  dynamic? fechaModifcia;
  bool? estado;

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion_Paquete": descripcionPaquete,
        "duracion_Paquete": duracionPaquete,
        "precio": precio,
        "iD_Hotel": iDHotel,
        "hotel": hotel,
        "descripcion_Hotel": descripcionHotel,
        "ciudad_ID": ciudadID,
        "ciudad": Ciudad,
        "iD_Restaurante": iDRestaurante,
        "restaurante": restaurante,
        "iD_Usuario_Creacion": iDUsuarioCreacion,
        "usuario_Creacion": usuarioCreacion,
        "fecha_Creacion": fechaCreacion.toString(),
        "iD_Usuario_Modifica": iDUsuarioModifica,
        "usuario_Modifica": usuarioModifica,
        "fecha_Modifcia": fechaModifcia,
        "estado": estado,
      };
}

class DefaultPackageDetailsModel {
  int? id;
  int? paqueteId;
  String? nombrePaquete;
  String? descripcionPaquete;
  String? duracionPaquete;
  int? actividadId;
  String? descripcionActividad;
  int? usuarioCreacionId;
  String? usuarioCreacion;
  DateTime? fechaCreacion;
  int? usuarioModificaId;
  String? usuarioModifica;
  DateTime? fechaModifica;
  bool? estado;

  Map<String, dynamic> toJson() => {
        "id": id,
        "paqueteID": paqueteId,
        "nombrePaquete": nombrePaquete,
        "descripcionPaquete": descripcionPaquete,
        "duracionPaquete": duracionPaquete,
        "actividadID": actividadId,
        "descripcionActividad": descripcionActividad,
        "usuarioCreacionID": usuarioCreacionId,
        "usuarioCreacion": usuarioCreacion,
        "fechaCreacion": fechaCreacion.toString(),
        "usuarioModificaID": usuarioModificaId,
        "usuarioModifica": usuarioModifica,
        "fechaModifica": fechaModifica.toString(),
        "estado": estado,
      };
}

class CiudadViewModel {
  int? ciudadID;
  String? Ciudad;
}

class ActivitiesExtraDefault {
  int? index;
  int? acEx_ID;
  String? acEx_Descripcion;
  int? acEx_numeroPersonas;
  String? reAE_FechaReservacion;
  String? reAE_HoraReservacion;
  double? reAE_Precios;

  Map<String, dynamic> toJson() => {
        'index': index,
        'acEx_ID': acEx_ID,
        'acEx_Descripcion': acEx_Descripcion,
        'reAE_Cantidad': acEx_numeroPersonas,
        'reAE_FechaReservacion': reAE_FechaReservacion,
        'reAE_HoraReservacion': reAE_HoraReservacion,
        'reAE_Precio': reAE_Precios,
      };
}
