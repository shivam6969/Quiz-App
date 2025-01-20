import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizapp/models/models.dart';

class QuizService {
  final String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<Quiz> fetchQuiz() async {
    try{
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        return Quiz.fromJson(data);
      }else{
        throw Exception('Failed to fetch the Quiz');
      }
    }catch(e){
      throw Exception(e);
    }
  }
}