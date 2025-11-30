import 'package:bloc/bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NavControllerCubit extends Cubit<int> {
  NavControllerCubit() : super(0);
  final PersistentTabController controller = PersistentTabController(
    initialIndex: 0,
  );

  void changeTab(int index) {
    controller.jumpToTab(index);
  }
}
