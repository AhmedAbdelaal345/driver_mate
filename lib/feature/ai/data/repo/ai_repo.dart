// import 'package:dartz/dartz.dart';
// import 'package:driver_mate/core/network/api_helper.dart';
// import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
// import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';

// class AiChatRepo {
//   AiChatRepo._internal();
//   static final AiChatRepo _singleton = AiChatRepo._internal();
//   factory AiChatRepo() {
//     return _singleton;
//   }

//   ApiHelper apiHelper = ApiHelper();
//   Future<Either<String, ChatRequestModel>> sendMessage(
//     ChatMessageModel message,
//   ) async {
//     try {
//       final response = await apiHelper.postRequest(
//         endpoint: "chatbot/message",
//         isForm: false,
//         data: message.toMap(),
//         isAuthorized: true,
//       );

//       if (response.status == true) {
//         return Right(
//           ChatRequestModel(
//             id: DateTime.now().millisecondsSinceEpoch.toString(),
//             message: response.data["aiResponse"],
//             isUserMessage: false,
//             createdAt: DateTime.now().toString(),
//           ),
//         );
//       } else {
//         return Left(response.message);
//       }
//     } on Exception catch (e) {
//       return Left("Failed to send message: ${e.toString()}");
//     }
//   }

//   Future<Either<String, List<ChatRequestModel>>> getHistory() async {
//     try {
//       final response = await apiHelper.getRequest(
//         endpoint: "chatbot/history",
//         isAuthorized: true,
//       );

//       if (response.status == true) {
//         return Right(
//           List<ChatRequestModel>.from(
//             response.data.map((e) => ChatRequestModel.fromJson(e)).toList(),
//           ),
//         );
//       } else {
//         return Left(response.message);
//       }
//     } on Exception catch (e) {
//       return Left("Failed to fetch history: ${e.toString()}");
//     }
//   }
// }
