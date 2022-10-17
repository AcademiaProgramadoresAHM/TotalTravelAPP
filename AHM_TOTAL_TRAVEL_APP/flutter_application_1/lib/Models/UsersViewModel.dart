class UserLoginModel {
  String? Email;
  String? Password;
  Map<String, dynamic> toJson() => {'email': Email, 'password': Password};
}

class UserLoggedModel {
  int? ID;
  String? DNI;
  String? nombre;
  String? apellido;
  String? Email;
  String? Rol;
  int? Role_ID;
  String? Partner;
  int? PartnerID;
  String? Token;

  UserLoggedModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        DNI = json['dni'],
        nombre = json['nombre'],
        apellido = json['apellido'],
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
  int? Role_ID;
  int? Dire_ID;
  int? Part_ID;
  int? Usua_UsuarioCreacion;
  DateTime? Usua_FechaCreacion;
  int? Usua_UsuarioModifica;
  DateTime? Usua_FechaModifica;
  bool? Usua_Estado;

  Map<String, dynamic> toJson() => {
        "usua_ID": Usua_ID,
        "usua_DNI": Usua_DNI,
        "usua_Nombre": Usua_Nombre,
        "usua_Apellido": Usua_Apellido,
        "usua_FechaNaci": Usua_FechaNaci,
        "usua_Email": Usua_Email,
        "usua_Sexo": Usua_Sexo,
        "usua_Telefono": Usua_Telefono,
        "usua_Url": "string",
        "usua_Password": Usua_Password,
        "usua_esAdmin": Usua_esAdmin,
        "role_ID": Role_ID,
        "dire_ID": Dire_ID,
        "part_ID": 0,
        "usua_UsuarioCreacion": Usua_UsuarioCreacion,
        "usua_UsuarioModifica": 0
      };
}

class UserListViewModel {
  int? ID;
  String? DNI;
  String? nombre;
  String? apellido;
  String? Genero;
  DateTime? Fecha_Nacimiento;
  String? Email;
  String? Password;
  String? Telefono;
  String? Colonia;
  String? Calle;
  String? Avenida;
  int? DireccionID;
  String? Partner;
  int? PartnerID;
  String? Rol;
  int? Role_ID;
  int? ID_Crea;
  String? UsuarioCreacion;
  DateTime? Fecha_Creacion;
  int? ID_Modifica;
  String? UsuarioModifica;
  DateTime? Fecha_Modifica;
  bool? Estado;

  UserListViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        DNI = json['dni'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        Genero = json['genero'],
        Fecha_Nacimiento = json['fecha_Nacimiento'],
        Email = json['email'],
        Password = json['password'],
        Telefono = json['telefono'],
        Colonia = json['colonia'],
        Calle = json['calle'],
        Avenida = json['avenida'],
        DireccionID = json['direccionID'],
        Rol = json['rol'],
        Role_ID = json['rol_ID'],
        Partner = json['partner'],
        PartnerID = json['partnerID'],
        ID_Crea = json['iD_Crea'],
        UsuarioCreacion = json['usuarioCreacion'],
        Fecha_Creacion = json['fecha_Creacion'],
        ID_Modifica = json['iD_Modifica'],
        UsuarioModifica = json['usuarioModifica'],
        Fecha_Modifica = json['fecha_Modifica'],
        Estado = json['estado'];
}
