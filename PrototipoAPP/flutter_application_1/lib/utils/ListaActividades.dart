import '../utils/models.dart';
import 'T2Images.dart';

List<Actividades> getActividades() {
  List<Actividades> list = [];
  Actividades model1 = Actividades();
  model1.name = "Viaje en parapente";
  model1.duration = "30 min";
  model1.precio = "200.00 Lps";
  model1.descripcion = "Vuela hacia el cielo con un amigo en un viaje en tándem a gran altura, balanceando los pies sobre las aguas de los Cayos de Florida. Incluso podrías ver algunos grupos de delfines saltando a lo largo de la costa.";
  model1.image = t2_activi_img1;

  Actividades model2 = Actividades();
  model2.name = "Bucear en los corales";
  model2.duration = "20 min";
  model1.precio = "350.00 Lps";
  model2.descripcion = "Pasea bajo la superficie del Caribe en un BOB y disfruta de esta forma inusual de ver la vida marina del arrecife de Chitales.";
  model2.image = t2_activi_img2;

  Actividades model3 = Actividades();
  model3.name = "Lecciones de surf";
  model3.duration = "50 min";
  model1.precio = "500.00 Lps";
  model3.descripcion = "Este debe ser el lugar con el nombre más apropiado para aprender a surfear como un profesional.";
  model3.image = t2_activi_img3;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}