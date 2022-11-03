import 'package:flutter/material.dart';
import 'dart:convert';

class ReservationViewmodel {
  int? resvId;
  int? usuaId;
  int? paquId;
  bool? resvEsPersonalizado;
  int? resvCantidadPagos;
  int? resvNumeroPersonas;
  bool? resvConfirmacionPago;
  bool? resvConfirmacionHotel;
  bool? resvConfirmacionRestaurante;
  bool? resvConfirmacionTrans;
  double? resvPrecio;
  String? reHo_FechaEntrada;
  String? reHo_FechaSalida;

  Map<String, dynamic> toJson() => {
        'resv_ID': resvId,
        'usua_ID': usuaId,
        'paqu_ID': paquId,
        'resv_esPersonalizado': resvEsPersonalizado,
        'resv_CantidadPagos': resvCantidadPagos,
        'resv_NumeroPersonas': resvNumeroPersonas,
        'resv_ConfirmacionPago': resvConfirmacionPago,
        'resv_ConfirmacionHotel': resvConfirmacionHotel,
        'resv_ConfirmacionRestaurante': resvConfirmacionRestaurante,
        'reAE_FechaReservacion': resvConfirmacionTrans,
        'resv_ConfirmacionTrans': resvConfirmacionTrans,
        'resv_Precio': resvPrecio,
        'reHo_FechaEntrada': reHo_FechaEntrada,
        'reHo_FechaSalida': reHo_FechaSalida,
      };
}

class ReservationUserViewModel {
  int? ID;
  int? NumeroPersonas;
  int? CantidadPagos;
  int? Id_Paquete;
  String? DescripcionPaquete;
  String? DurecionPaquete;
  double? precio;
  int? ReservacionHotelID;
  DateTime? Fecha_Entrada;
  DateTime? Fecha_Salida;
  int? Hotel_ID;
  String? Nombre_Hotel;
  String? Habitacion;
  String? Categoria_Habitacion;
  int? Camas;
  int? Id_Cliente;
  String? Nombre;
  String? Apellido;
  String? Nombrecompleto;
  String? DNI;
  String? Email;
  String? Telefono;
  int? Id_UsuarioCrea;
  int? UsuarioCrea;
  DateTime? FechaCreacion;
  int? Id_UsuarioModifica;
  int? UsuarioModifica;
  DateTime? FechaModifica;

  ReservationUserViewModel.fromJson(Map<String, dynamic> Json)
      : ID = Json['id'],
        NumeroPersonas = Json['numeroPersonas'],
        CantidadPagos = Json['cantidadPagos'],
        Id_Paquete = Json['id_Paquete'],
        DescripcionPaquete = Json['descripcionPaquete'],
        DurecionPaquete = Json['durecionPaquete'],
        precio = Json['precio'],
        ReservacionHotelID = Json['reservacionHotelID'],
        Fecha_Entrada = Json['fecha_Entrada'],
        Fecha_Salida = Json['fecha_Salida'],
        Hotel_ID = Json['hotel_ID'],
        Nombre_Hotel = Json['nombre_Hotel'],
        Habitacion = Json['habitacion'],
        Categoria_Habitacion = Json['categoria_Habitacion'],
        Camas = Json['camas'],
        Id_Cliente = Json['id_Cliente'],
        Nombre = Json['nombre'],
        Apellido = Json['apellido'],
        Nombrecompleto = Json['nombrecompleto'],
        DNI = Json['dni'],
        Email = Json['email'],
        Telefono = Json['telefono'],
        Id_UsuarioCrea = Json['id_UsuarioCrea'],
        UsuarioCrea = Json['usuarioCrea'],
        FechaCreacion = Json['fechaCreacion'],
        Id_UsuarioModifica = Json['id_UsuarioModifica'],
        UsuarioModifica = Json['usuarioModifica'],
        FechaModifica = Json['fechaModifica'];
}
