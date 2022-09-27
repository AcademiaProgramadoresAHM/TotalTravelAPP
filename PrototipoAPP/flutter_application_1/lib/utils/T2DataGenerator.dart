import '../utils/models.dart';
import 'T2Strings.dart';
import 'T2Images.dart';

List<T2Favourite> getFavourites() {
  List<T2Favourite> list = [];
  T2Favourite model1 = T2Favourite();
  model1.name = "Best Jogging tips in the world";
  model1.duration = "5 min ago";
  model1.image = t2_ic_img1;

  T2Favourite model2 = T2Favourite();
  model2.name = "Best Yoga guide for better Health in the world";
  model2.duration = "15 min ago";
  model2.image = t2_ic_img2;

  T2Favourite model3 = T2Favourite();
  model3.name = "Best Exercise tips in the world";
  model3.duration = "an hour ago";
  model3.image = t2_img3;

  T2Favourite model4 = T2Favourite();
  model4.name = "Best Diet tips for the good Health";
  model4.duration = "5 hour ago";
  model4.image = t2_img4;


  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  return list;
}

/*
List<T2DrawerItem> getDrawerItems() {
  List<T2DrawerItem> list = List<T2DrawerItem>();
  T2DrawerItem model1 = T2DrawerItem();
  model1.title = t2_lbl_profile;
  model1.image = Icons.person_outline;
  T2DrawerItem model2 = T2DrawerItem();
  model2.title = t2_lbl_message;
  model2.image = Icons.chat_bubble_outline;
  T2DrawerItem model3 = T2DrawerItem();
  model3.title = t2_lbl_profile;
  model3.image = Icons.char;
  T2DrawerItem model4 = T2DrawerItem();
  model4.title = t2_lbl_profile;
  model4.image = Icons.person_outline;
  T2DrawerItem model5 = T2DrawerItem();
  model5.title = t2_lbl_profile;
  model5.image = Icons.person_outline;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}
*/
