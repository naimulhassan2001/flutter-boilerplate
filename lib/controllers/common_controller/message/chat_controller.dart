import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/active_user_model.dart';
import '../../../data/models/chat_list_model.dart';
import '../../../services/api/api_service.dart';
import '../../../services/socket/socket_service.dart';
import '../../../utils/constants/api_end_point.dart';
import '../../../services/storage/storage_services.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/enum/enum.dart';

class ChatController extends GetxController {
  Status status = Status.completed;

  bool isMoreLoading = false;

  int page = 1;

  List chats = [];
  List activeUsers = [];

  ChatListModel chatModel = ChatListModel.fromJson({});

  ScrollController scrollController = ScrollController();

  static ChatController get instance => Get.put(ChatController());

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await getChatRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> getChatRepo() async {
    return;
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.get("${ApiEndPoint.chats}?page=$page");

    if (response.statusCode == 200) {
      chatModel = ChatListModel.fromJson(response.data);

      chats.addAll(chatModel.data.attributes.chatList);

      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  listenChat() async {
    SocketServices.socket.on("update-chatlist::${LocalStorage.userId}", (data) {
      status = Status.loading;
      update();

      page = 1;
      ChatListModel chatListModel;
      chatListModel = ChatListModel.fromJson(data);

      chats.clear();
      chats.addAll(chatListModel.data.attributes.chatList);

      status = Status.completed;
      update();
    });
  }

  getActiveUser() async {
    SocketServices.socket.emitWithAck("get-active-users", {}, ack: (data) {
      activeUsers.clear();
      for (var item in data['data']) {
        activeUsers.add(ActiveUserModel.fromJson(item));
      }
      update();

      if (kDebugMode) {
        print("===========================> Received acknowledgment: $data");
      }
    });
  }

  @override
  void onInit() {
    getChatRepo();
    getActiveUser();
    super.onInit();
  }
}
