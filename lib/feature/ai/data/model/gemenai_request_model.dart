class GeminiRequestModel {

  final String prompt;

  GeminiRequestModel({required this.prompt});

  Map<String,dynamic> toJson(){
    return {
      "contents":[
        {
          "parts":[
            {
              "text":prompt
            }
          ]
        }
      ]
    };
  }

}