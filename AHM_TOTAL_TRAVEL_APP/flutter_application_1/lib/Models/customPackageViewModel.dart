import 'dart:ffi';

class customPackageViewModel {
  int? usua_ID; //*
  int? hote_ID; //*
  String? hote_Descripcion;
  String? reHo_FechaEntrada; //*
  String? reHo_FechaSalida; //*
  String? reHo_PrecioTotal; //*
  int? hote_numNoches; //*
  String? night;
  int? hote_numeroPersonas; //*
  String? people;
  int? habi_ID; //*
  int? habi_Cantidad; //*
  String? room;
  String? habi_Descripcion;
  List<ActivitiesExtra>? actividadesExtra; //*
  List<Restaurants>? Restaurant; //*
  String? actividadesExtras;
  String? restaurantes;
  String? reservacionTransportes;
  String? partner;
  int? ciudadSalida_ID; //*
  String? ciudadSalida;
  int? ciudadLlegada_ID; //*
  String? ciudadLlegada;
  String? horaSalida;
  int? tprt_cantidadPersonas; //*
  int? tprt_Total; //*
  double? PackageTotal; //*
  int? tipoPago; //*
  int? CantidadPagos; //*
  int? MontoPago;
  List<reservacionTransporte>? transporteReservacion;
  Map<String, dynamic> toJson() => {
        /*'resv_ID': 0,
        'usua_ID': usua_ID,
        'paqu_ID': 1,
        'resv_esPersonalizado': true,
        'resv_CantidadPagos': CantidadPagos,
        'resv_NumeroPersonas': hote_numeroPersonas,
        'resv_ConfirmacionPago': false,
        'resv_ConfirmacionHotel': false,
        'resv_ConfirmacionRestaurante': false,
        'resv_ConfirmacionTrans': false,
        'resv_Precio': PackageTotal,
        'resv_UsuarioCreacion': usua_ID,
        'resv_UsuarioModifica': 0,
        'reHo_FechaEntrada': reHo_FechaEntrada.toString(),
        'reHo_FechaSalida': reHo_FechaSalida.toString(),
        'hote_ID': hote_ID,*/
        'actividadesExtras': actividadesExtra,
        'restaurantes': Restaurant,
        'actividadesHoteles': [],
        'resv_Habitaciones': [],
        'tipoPago': tipoPago,
        'habi_ID': habi_ID,
        'habi_Cantidad': habi_Cantidad,
        'reservacionTransportes': transporteReservacion
      };
}

class ActivitiesExtra {
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

class ActivitiesHotel {
  int? index;
  int? hoAc_ID;
  String? hoAc_Descripcion;
  int? hoAc_numeroPersonas;
  String? reAH_FechaReservacion;
  String? reAH_HoraReservacion;
  double? reAH_Precio;

  Map<String, dynamic> toJson() => {
        'index': index,
        'hoAc_ID': hoAc_ID,
        'reAH_Cantidad': hoAc_numeroPersonas,
        'reAH_FechaReservacion': reAH_FechaReservacion,
        'reAH_HoraReservacion': reAH_HoraReservacion,
        'reAH_Precio': reAH_Precio,
      };
}



class Restaurants {
  int? index;
  int? rest_ID;
  String? restaurante;
  int? rest_numeroPersonas;
  String? rest_FechaReservacion;
  String? rest_HoraReservacion;

  Map<String, dynamic> toJson() => {
        'index': index,
        'rest_ID': rest_ID,
        'restaurante': restaurante,
        'rest_numeroPersonas': rest_numeroPersonas,
        'reRe_FechaReservacion': rest_FechaReservacion,
        'reRe_HoraReservacion': rest_HoraReservacion,
      };
}

class reservacionTransporte {
  int? detr_ID;
  int? reTr_CantidadAsientos;

  Map<String, dynamic> toJson() => {
        'detr_ID': detr_ID,
        'reTr_CantidadAsientos': reTr_CantidadAsientos,
      };
}
