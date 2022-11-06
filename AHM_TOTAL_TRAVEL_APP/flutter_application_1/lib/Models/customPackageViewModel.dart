class customPackageViewModel {
  int? usua_ID;
  int? hote_ID;
  String? hote_Descripcion;
  String? reHo_FechaEntrada;
  String? reHo_FechaSalida;
  String? reHo_PrecioTotal;
  int? hote_numNoches;
  String? night;
  int? hote_numeroPersonas;
  String? people;
  int? habi_ID;
  int? habi_Cantidad;
  String? room;
  String? habi_Descripcion;
  List<ActivitiesExtra>? actividadesExtra;
  List<Restaurants>? Restaurant;
  String? partner;
  int? ciudadSalida_ID;
  String? ciudadSalida;
  int? ciudadLlegada_ID;
  String? ciudadLlegada;
  String? horaSalida;
  int? tprt_cantidadPersonas;
  int? tprt_Total;
  String? PackageTotal;
  int?  tipoPago;
  int? CantidadPagos;
  Map<String, dynamic> toJson() => {
        'usua_ID': usua_ID,
        'hote_ID': hote_ID,
        'reHo_FechaEntrada': reHo_FechaEntrada,
        'reHo_FechaSalida': reHo_FechaSalida,
        'reHo_PrecioTotal': reHo_PrecioTotal,
        'hote_numeroPersonas': hote_numeroPersonas,
        'habi_ID': habi_ID,
        'actividadesExtra': actividadesExtra,
        'restaurant': Restaurant,
      };
}


class historyActivities{
  List<int>? index;
  List<int>? acEx_ID;
  List<String>? acEx_Descripcion;
  List<int>? acEx_numeroPersonas;
  List<String>? reAE_FechaReservacion;
  List<String>? reAE_HoraReservacion;
  List<String>? reAE_Precios;

  Map<String, dynamic> toJson() => {
        'index': index,
        'acEx_ID': acEx_ID,
        'acEx_Descripcion': acEx_Descripcion,
        'acEx_numeroPersonas': acEx_numeroPersonas,
        'reAE_FechaReservacion': reAE_FechaReservacion,
        'reAE_HoraReservacion': reAE_HoraReservacion,
        'reAE_Precios': reAE_Precios,
      };

}

class ActivitiesExtra{
  int? index;
  int? acEx_ID;
  String? acEx_Descripcion;
  int? acEx_numeroPersonas;
  String? reAE_FechaReservacion;
  String? reAE_HoraReservacion;
  String? reAE_Precios;
}

class Restaurants{
  int? index;
  int? rest_ID;
  String? restaurante;
  int? rest_numeroPersonas;
  String? rest_FechaReservacion;
  String? rest_HoraReservacion;
}