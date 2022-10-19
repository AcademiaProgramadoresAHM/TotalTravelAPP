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