class ChatListModel {
  final String status;
  final String statusCode;
  final String message;
  final ChatData data;

  ChatListModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? "",
      message: json['message'] ?? '',
      data: ChatData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ChatData {
  final ChatAttributes attributes;

  ChatData({required this.attributes});

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      attributes: ChatAttributes.fromJson(json['attributes'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.toJson(),
    };
  }
}

class ChatAttributes {
  final List<Chat> chatList;
  final Pagination pagination;

  ChatAttributes({required this.chatList, required this.pagination});

  factory ChatAttributes.fromJson(Map<String, dynamic> json) {
    return ChatAttributes(
      chatList: (json['chatList'] as List? ?? [])
          .map((i) => Chat.fromJson(i ?? {}))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatList': chatList.map((chat) => chat.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class Chat {
  final String id;
  final Participant participant;

  final LatestMessage latestMessage;

  Chat({
    required this.id,
    required this.participant,
    required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'] ?? '',
      participant: Participant.fromJson(json['participant'] ?? {}),
      latestMessage: LatestMessage.fromJson(json['latestMessage'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'participants': participant.toJson(),
      'latestMessage': latestMessage.toJson(),
    };
  }
}

class Participant {
  final String id;
  final String fullName;
  final String image;

  Participant({
    required this.id,
    required this.fullName,
    required this.image,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'image': image,
    };
  }
}

class LatestMessage {
  final String id;
  final String message;
  final DateTime createdAt;

  LatestMessage({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return LatestMessage(
      id: json['_id'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Pagination {
  final int totalResults;
  final int totalPages;
  final int currentPage;
  final int limit;

  Pagination({
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalResults: json['totalResults'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalResults': totalResults,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'limit': limit,
    };
  }
}
