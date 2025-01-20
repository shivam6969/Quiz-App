import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/screens/score_screen.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'package:quizapp/widgets/answer_option.dart';
import 'package:quizapp/widgets/progress_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<Quiz> quizFuture;
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  String? selectedOptionId;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    quizFuture = QuizService().fetchQuiz();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < 9) {
        currentQuestionIndex++;
        isAnswered = false;
        selectedOptionId = null;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(score: score, totalQuestions: 10 ),
          ),
        );
      }
    });
  }

  void _selectOption(Option option, Quiz quiz) {
    setState(() {
      isAnswered = true;
      selectedOptionId = option.id.toString();

      if (option.isCorrect) {
        score += quiz.correctAnswerMarks.toInt();
        _confettiController.play(); 
      } else {
        score -= quiz.negativeMarks.toInt();
      }
    });

    Future.delayed(const Duration(milliseconds: 3000), _nextQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Time'),
      ),
      body: Stack(
        children: [
          FutureBuilder<Quiz>(
            future: quizFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final quiz = snapshot.data!;
                final currentQuestion = quiz.questions[currentQuestionIndex];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Question ${currentQuestionIndex + 1} of ${quiz.questions.length}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.surface,
                        ),
                      ),
                    ),
                    ProgressBar(
                      progress: (currentQuestionIndex) / quiz.questions.length,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        currentQuestion.description,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: currentQuestion.options.map((option) {
                          return AnswerOption(
                            option: option,
                            isSelected: selectedOptionId == option.id.toString(),
                            isCorrect: isAnswered && option.isCorrect,
                            onTap: isAnswered
                                ? () {}
                                : () => _selectOption(option, quiz),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No questions available.'));
              }
            },
          ),
        
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.red, Colors.blue, Colors.green, Colors.orange,Colors.purple,Colors.yellow],
              gravity: 0.6, 
            ),
          ),
        ],
      ),
    );
  }
}
