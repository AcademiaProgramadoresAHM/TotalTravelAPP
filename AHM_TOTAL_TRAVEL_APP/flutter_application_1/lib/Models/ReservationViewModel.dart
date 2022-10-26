import 'package:flutter/material.dart';
import 'dart:convert';

class ReservationInsert {
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

  // ReservationInsert.fromJson(Map<String, dynamic> json)
  //     : resvId = json["resv_ID"],
  //       usuaId = json["usua_ID"],
  //       paquId = json["paqu_ID"],
  //       resvEsPersonalizado = json["resv_esPersonalizado"],
  //       resvCantidadPagos = json["resv_CantidadPagos"],
  //       resvNumeroPersonas = json["resv_NumeroPersonas"],
  //       resvConfirmacionPago = json["resv_ConfirmacionPago"],
  //       resvConfirmacionHotel = json["resv_ConfirmacionHotel"],
  //       resvConfirmacionRestaurante = json["resv_ConfirmacionRestaurante"],
  //       resvConfirmacionTrans = json["resv_ConfirmacionTrans"],
  //       resvPrecio = json["resv_Precio"].toDouble();
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
        Categoria_Habitacion = Json['Categoria_Habitacion'],
        Camas = Json['Camas'],
        Id_Cliente = Json['id_Cliente'],
        Nombre = Json['nombre'],
        Apellido = Json['apellido'],
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
