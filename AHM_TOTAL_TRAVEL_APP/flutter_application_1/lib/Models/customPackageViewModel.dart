class customPackageViewModel {
  int? usua_ID;
  int? hote_ID;
  String? hote_Descripcion;
  String? reHo_FechaEntrada;
  String? reHo_FechaSalida;
  String? reHo_PrecioTotal;
  int? hote_numNoches;
  int? hote_numeroPersonas;
  List<int>? habi_ID;
  String? habi_Descripcion;
  List<int>? acEx_ID;
  List<String>? acEx_Descripcion;
  List<int>? acEx_numeroPersonas;
  List<String>? reAE_FechaReservacion;
  List<String>? reAE_HoraReservacion;
  List<String>? reAE_Precios;
  List<int>? rest_ID;
  List<String>? restaurantes;
  List<int>? rest_numeroPersonas;
  List<String>? rest_FechaReservacion;
  List<String>? rest_HoraReservacion;

  Map<String, dynamic> toJson() => {
        'usua_ID': usua_ID,
        'hote_ID': hote_ID,
        'reHo_FechaEntrada': reHo_FechaEntrada,
        'reHo_FechaSalida': reHo_FechaSalida,
        'reHo_PrecioTotal': reHo_PrecioTotal,
        'hote_numeroPersonas': hote_numeroPersonas,
        'habi_ID': habi_ID,
        'acEx_ID': acEx_ID,
        'acEx_numeroPersonas': acEx_numeroPersonas,
        'reAE_FechaReservacion': reAE_FechaReservacion,
        'reAE_HoraReservacion': reAE_HoraReservacion,
        'rest_ID': rest_ID,
        'rest_numeroPersonas': rest_numeroPersonas,
        'rest_FechaReservacion': rest_FechaReservacion,
        'rest_HoraReservacion': rest_HoraReservacion,
      };
}
