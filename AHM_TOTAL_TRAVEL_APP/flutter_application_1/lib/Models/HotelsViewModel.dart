   class HotelViewModel
    {
        int? ID;
        String? Hotel;
        String? descripcion;
        int? ciudadID;

        Map<String, dynamic> toJson() => {'id': ID, 'hotel': Hotel,'descripcion': descripcion, 'ciudadID': ciudadID};
       HotelViewModel(this.ID, this.Hotel, this.descripcion, this.ciudadID);
        HotelViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Hotel = json['hotel'],
        descripcion = json['descripcion'],
        ciudadID = json['ciudadID'];
    }

       class HotelFindViewModel
    {
        int? ID;
        String? Hotel;
        String? descripcion;
        int? ciudadID;
        String? ciudad;
        String? colonia;
        String? calle;
        String? image_URL;



        Map<String, dynamic> toJson() => {'id': ID, 
                                          'hotel': Hotel,
                                          'descripcion': descripcion, 
                                          'ciudadID': ciudadID,
                                          'ciudad': ciudad, 
                                          'colonia': colonia,
                                          'calle': calle, 
                                          'image_URL': image_URL};
       HotelFindViewModel(this.ID, this.Hotel, this.descripcion, this.ciudadID,
                          this.ciudad, this.colonia, this.calle, this.image_URL);
        HotelFindViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Hotel = json['hotel'],
        descripcion = json['descripcion'],
        ciudadID = json['ciudadID'],
        ciudad = json['ciudad'],
        colonia = json['colonia'],
        calle = json['calle'],
        image_URL = json['image_URL'];
    }