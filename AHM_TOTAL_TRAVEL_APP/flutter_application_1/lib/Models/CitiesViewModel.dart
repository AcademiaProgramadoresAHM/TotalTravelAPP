    class CiudadesViewModel
    {
        int? ID;
        String? Ciudad;
        int? PaisID;
        String? Pais;
        String? UsuarioCrea;
        String? UsuarioModifica;

        Map<String, dynamic> toJson() => {'id': ID, 'ciudad': Ciudad,'pais': ID};
       CiudadesViewModel(this.ID, this.Ciudad, this.Pais, this.UsuarioCrea,
        this.UsuarioModifica);


        CiudadesViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Ciudad = json['ciudad'],
        PaisID = json['paisID'],
        Pais = json['pais'];
    }