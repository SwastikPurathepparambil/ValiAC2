import 'package:flutter/cupertino.dart';
import 'package:dart_sentiment/dart_sentiment.dart';
import '../isQuestion.dart';
import '../models/chat_model.dart';
import '../services/api_service.dart';


final sentiment = Sentiment();

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [ChatModel(msg: "Hello, my name is Christa! How's it going?", chatIndex: 1)];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<String> sendMessageAndGetAnswers({required String msg, required String chosenModelId}) async {
    //IMPORTANT NEEDS TO BEE FINISHED
    if (isQuestion(msg)) {
      if (isLegitimateQuestion(msg)) {
        if (chosenModelId.toLowerCase().startsWith("gpt")) {
          // chatList.addAll(await ApiService.sendMessageGPT(
          //   message: msg + ". Answer in less than 5 sentences.",
          //   modelId: chosenModelId,
          // ));
          // return msg;
          chatList.add(ChatModel(
              msg: "Listen to them without judgment, "
                  "validate their experiences and emotions, "
                  "offer support and resources if needed, "
                  "maintain confidentiality unless there "
                  "are safety concerns, and respect their boundaries.",
              chatIndex: 1)
          );

        } else {
          chatList.addAll(await ApiService.sendMessage(
            message: msg + ". Answer in less than 5 sentences.",
            modelId: chosenModelId,
          ));
        }
        notifyListeners();
        return msg;
      } else {
        chatList.add(ChatModel(
            msg: "I apologize, but I am unable to answer that question. Please try to rephrase your question or ask a mental health related question.",
            chatIndex: 1)
        );
        notifyListeners();
        return msg;
      }
    } else {
    //  Find out sentiment of the information because chatGPT cant
    //  If sentiment analysis is less than or equal to -1.5: Aw, I hope you feel better. Is there anything else you would like to chat about or ask?
    //  If between 0 and 1.5: Great! Is there anything else you would like to chat about or ask?
    //  If less than -1.5: GPT with reassurance and a leading question
    //  If greater than 1.5: GPT Validation and Encouragement
      if (sentiment.analysis(msg)["score"] < (0)) {
        List<ChatModel> answer = await ApiService.sendMessageGPT(
          message: msg + ". Given the statements from the previous sentences, reassure me in less than five sentences without saying anything about being an AI language model.",
          modelId: chosenModelId,
        );
        print(answer);
        chatList.addAll(await ApiService.sendMessageGPT(
          message: msg + ". Given the statements from the previous sentences, reassure me in less than five sentences without saying anything about being an AI language model.",
          modelId: chosenModelId,
        ));
        notifyListeners();
        return msg;
      } else if (sentiment.analysis(msg)["score"] > (1.5)) {
        // List<ChatModel> answer = await ApiService.sendMessageGPT(
        //   message: msg + ". Given the statements from the previous sentences, validate my happiness in less than 4 sentences without saying anything about being an AI language model..",
        //   modelId: chosenModelId,
        // ).then((value) => print(value));
        chatList.addAll(await ApiService.sendMessageGPT(
          message: msg + ". Given the statements from the previous sentences, validate my happiness in less than 4 sentences without saying anything about being an AI language model..",
          modelId: chosenModelId,
        ));
        notifyListeners();
        return msg;
      } else {
        chatList.add(ChatModel(
            msg: "Great! What else can I help you with?",
            chatIndex: 1)
        );
        notifyListeners();
        return msg;
      }
    }
  }
}
