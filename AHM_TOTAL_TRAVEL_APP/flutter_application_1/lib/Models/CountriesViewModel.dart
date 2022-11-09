    class CountriesViewModel
    {
        int? ID;
        String? Pais;
        String? UsuarioCrea;
        String? UsuarioModifica;

        CountriesViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Pais = json['pais'];
    }