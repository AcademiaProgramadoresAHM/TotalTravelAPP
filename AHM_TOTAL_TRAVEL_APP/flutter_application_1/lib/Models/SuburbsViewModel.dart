    class SuburbsViewModel
    {
        int? ID;
        String? Colonia;
        int? CiudadID;
        String? Ciudad;



        Map<String, dynamic> toJson() => {'id': ID, 'colonia': Colonia,'ciudadID': CiudadID,'ciudad': Ciudad};
       SuburbsViewModel(this.ID, this.Colonia, this.CiudadID, this.Ciudad);


        SuburbsViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Colonia = json['colonia'],
        CiudadID = json['ciudadID'],
        Ciudad = json['ciudad'];
    }