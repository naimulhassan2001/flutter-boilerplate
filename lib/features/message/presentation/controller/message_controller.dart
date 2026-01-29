import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/model/message_model.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/enum/enum.dart';

class MessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  String? video;

  List<ChatMessageModel> messages = [];

  String chatId = '';
  String name = '';

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  static MessageController get instance => Get.put(MessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  Future<void> getMessageRepo() async {
    return;
    if (page == 1) {
      messages.clear();
      status = Status.loading;
      update();
    }

    final response = await ApiService.get(
      '${ApiEndPoint.messages}?chatId=$chatId&page=$page&limit=15',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = response.data['data'] ?? {};
      final Map<String, dynamic>? attributes = data?['attributes'] ?? {};
      final List<dynamic> messages = attributes?['messages'] ?? [];

      for (var messageData in messages) {
        messageModel = MessageModel.fromJson(messageData);

        messages.add(
          ChatMessageModel(
            time: messageModel.createdAt.toLocal(),
            text: messageModel.message,
            image: messageModel.sender.image,
            isNotice: messageModel.type == 'notice' ? true : false,
            isMe: LocalStorage.userId == messageModel.sender.id ? true : false,
          ),
        );
      }

      page = page + 1;
      status = Status.completed;
      update();
    } else {
      AppSnackbar.error(
        title: response.statusCode.toString(),
        message: response.message,
      );
      status = Status.error;
      update();
    }
  }

  Future<void> addNewMessage() async {
    isMessage = true;
    update();

    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: messageController.text,
        image: LocalStorage.myImage,
        isMe: true,
      ),

      // ChatMessageModel(
      //     currentTime.format(context).toString(),
      //     controller.messageController.text,
      //     true),
    );

    isMessage = false;
    update();

    final body = {
      'chat': chatId,
      'message': messageController.text,
      'sender': LocalStorage.userId,
    };

    messageController.clear();

    SocketServices.emitWithAck('add-new-message', body, (data) {
      if (kDebugMode) {
        print(
          '===============================================================> Received acknowledgment: $data',
        );
      }
    });
  }

  Future<void> listenMessage(String chatId) async {
    SocketServices.on('new-message::$chatId', (data) {
      status = Status.loading;
      update();

      final messageModel = MessageModel.fromJson(data);

      final time = messageModel.createdAt.toLocal();
      messages.insert(
        0,
        ChatMessageModel(
          isNotice: messageModel.type == 'notice' ? true : false,
          time: time,
          text: messageModel.message,
          image: messageModel.sender.image,
          isMe: false,
        ),
      );

      status = Status.completed;
      update();
    });
  }

  void isEmoji(int index) {
    currentIndex = index;
    isInputField = isInputField;
    update();
  }
}
