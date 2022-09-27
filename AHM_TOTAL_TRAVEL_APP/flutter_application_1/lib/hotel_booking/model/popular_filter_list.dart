class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Desayuno',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Parqueo',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Piscina',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Acepten mascotas',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Wi-Fi',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'De todo',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Apartamento',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Casa',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Resort',
      isSelected: false,
    ),
  ];
}
