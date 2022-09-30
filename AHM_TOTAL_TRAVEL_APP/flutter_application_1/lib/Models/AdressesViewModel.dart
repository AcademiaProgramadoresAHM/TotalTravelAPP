 class AdressesViewModel
    {
        String? Dire_Descripcion;
        int? Ciud_ID;
        int? Dire_UsuarioCreacion;
        int? Dire_UsuarioModifica;

         Map<String, dynamic> toJson() => {'dire_Descripcion': Dire_Descripcion, 
                                            'ciud_ID': Ciud_ID,
                                            'dire_UsuarioCreacion': Dire_UsuarioCreacion,
                                            'dire_UsuarioModifica': Dire_UsuarioModifica};

        
    }