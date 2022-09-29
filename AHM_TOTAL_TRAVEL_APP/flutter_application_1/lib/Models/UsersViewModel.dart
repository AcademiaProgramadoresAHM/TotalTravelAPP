class UserLoginModel {
  String? Email;
  String? Password;
  Map<String, dynamic> toJson() => {'email': Email, 'password': Password};
}

class UserLoggedModel {
  int? ID;
  String? DNI;
  String? nombre_completo;
  String? Email;
  String? Rol;
  int? Role_ID;
  String? Partner;
  int? PartnerID;
  String? Token;

  UserLoggedModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        DNI = json['dni'],
        nombre_completo = json['nombre_completo'],
        Email = json['email'],
        Rol = json['rol'],
        Role_ID = json['rol_ID'],
        Partner = json['partner'],
        PartnerID = json['partnerID'],
        Token = json['token'];
}

class UserRegisterModel {
  int? Usua_ID;
  String? Usua_DNI;
  String? Usua_Url;
  String? Usua_Nombre;
  String? Usua_Apellido;
  String? Usua_FechaNaci;
  String? Usua_Email;
  String? Usua_Sexo;
  String? Usua_Telefono;
  String? Usua_Password;
  int? Usua_esAdmin;
  String? Usua_Salt;
  int? Role_ID;
  int? Dire_ID;
  int? Part_ID;
  int? Usua_UsuarioCreacion;
  DateTime? Usua_FechaCreacion;
  int? Usua_UsuarioModifica;
  DateTime? Usua_FechaModifica;
  bool? Usua_Estado;

  Map<String, dynamic> toJson() => 
  {
  "usua_ID": 0,
  "usua_DNI": Usua_DNI,
  "usua_Url": Usua_Url,
  "usua_Nombre": Usua_Nombre,
  "usua_Apellido": Usua_Apellido,
  "usua_FechaNaci": Usua_FechaNaci,
  "usua_Email": Usua_Email,
  "usua_Sexo": Usua_Sexo,
  "usua_Telefono": Usua_Telefono,
  "usua_Password": Usua_Password,
  "usua_esAdmin": 0,
  "role_ID": 2,
  "dire_ID": 1,
  "usua_UsuarioCreacion": 1,
};



}
