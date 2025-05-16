import 'package:get/get.dart';
import 'game_room_controller.dart';

class GameRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameRoomController>(() => GameRoomController());
  }
}