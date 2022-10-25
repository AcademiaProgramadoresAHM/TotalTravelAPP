class DefaultPackageViewModel {
  int? ID;
  String? Nombre;
  String? Descripcion;
  String? Duracion;
  double? Precio;
  String? Hotel;
  String? Restaurante;

  Map<String, dynamic> toJson() => {
        'id': ID,
        'nombre': Nombre,
        'descripcion_Paquete': Descripcion,
        'duracion_Paquete': Duracion,
        'precio': Precio,
        'hotel': Hotel,
        'restaurante': Restaurante
      };
  DefaultPackageViewModel(this.ID, this.Nombre, this.Descripcion, this.Duracion,
      this.Hotel, this.Precio, this.Restaurante);
  DefaultPackageViewModel.fromJson(Map<String, dynamic> json)
      : ID = json['id'],
        Descripcion = json['descripcion_Paquete'],
        Duracion = json['duracion_Paquete'],
        Precio = json['precio'],
        Hotel = json['hotel'],
        Restaurante = json['restaurante'];
}
