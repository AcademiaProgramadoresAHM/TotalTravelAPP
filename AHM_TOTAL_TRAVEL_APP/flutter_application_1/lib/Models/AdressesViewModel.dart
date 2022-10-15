 class AdressesViewModel
    {
        
        int? Colo_ID;
        String? Dire_Calle;
        String? Dire_Avenida;
        int? Dire_UsuarioCreacion;
        int? Dire_UsuarioModifica;

         Map<String, dynamic> toJson() => { 'colo_ID': Colo_ID,
                                            'dire_Calle': Dire_Calle, 
                                            'dire_Avenida': Dire_Avenida,
                                            'dire_UsuarioCreacion': Dire_UsuarioCreacion,
                                            'dire_UsuarioModifica': Dire_UsuarioModifica};

        
    }