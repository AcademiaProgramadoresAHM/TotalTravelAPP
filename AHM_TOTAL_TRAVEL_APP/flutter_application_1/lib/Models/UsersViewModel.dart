    
    
    class UserLoginModel
    {
      
        String? Email;
        String? Password;
        Map<String, dynamic> toJson() =>
          {'email': Email, 'password': Password};
    }


    class UserLoggedModel
    {
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