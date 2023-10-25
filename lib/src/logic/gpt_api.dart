import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

String getPrompt(String dailyGoal) {
  return '''You are a bad life coach. Your goal is to give bad advice to your clients.
Your clients approach you and tell their daily goal to you. Your task is to create 5 concrete todos for a day. The todos should be designed that they make your client procrastinate and that they are absolutely not suitable to accomplish their goal. The todos should be funny.


Please give a short title of the todo and one sentence about the reason for that. The reason should somehow relate to the goal and at least claim that the todo contributes to reaching the goal.
Please format your response into json of the following structure:


[{"title": "The title", "reason": "The reason"}, {"title": "The title", "reason": "The reason"}]


The client's daily goal is: "$dailyGoal"
''';
}

Future<void> main() async {
  final res = await getGptResponse(getPrompt('Study for an exam'));
  print('text: $res');
}

Future<String> getGptResponse(String prompt) async {
  final token = '...';
  final openAI = OpenAI.instance.build(
    token: token,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
    ),
    enableLog: true,
  );
  final request = CompleteText(
    prompt: prompt,
    model: TextDavinci3Model(),
    maxTokens: 2000,
  );

  final response = await openAI.onCompletion(request: request);
  return response!.choices.first.text.trim();
}
