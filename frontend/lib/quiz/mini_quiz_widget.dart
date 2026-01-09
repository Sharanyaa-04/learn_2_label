import 'package:flutter/material.dart';

import '../progress/learning_progress.dart';
import 'quiz_question.dart';

enum PointsSyncStatus { idle, pending, saved, failed }

class MiniQuiz extends StatefulWidget {
  final List<QuizQuestion> questions;
  final Future<bool> Function(int score, int total)? onCompleted;

  const MiniQuiz({super.key, required this.questions, this.onCompleted});

  @override
  State<MiniQuiz> createState() => _MiniQuizState();
}

class _MiniQuizState extends State<MiniQuiz> {
  int currentIndex = 0;
  List<int?> selectedAnswers = [];
  bool showResult = false;
  bool _completionNotified = false;
  PointsSyncStatus _pointsStatus = PointsSyncStatus.idle;
  String? _pointsError;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.questions.length, null);
  }

  int get score {
    int s = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i].correctIndex) {
        s++;
      }
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final progress = ProgressProvider.of(context);

    if (widget.questions.isEmpty) {
      return const Center(child: Text('No quiz available'));
    }

    if (showResult) {
      return _buildResultScreen(progress);
    }

    final question = widget.questions[currentIndex];
    final selected = selectedAnswers[currentIndex];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsBanner(progress),
          const SizedBox(height: 12),

          Text(
            'Question ${currentIndex + 1} of ${widget.questions.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: (currentIndex + 1) / widget.questions.length,
          ),

          const SizedBox(height: 20),

          Text(
            question.question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          ...List.generate(question.options.length, (index) {
            final isCorrect = index == question.correctIndex;
            final isSelected = selected == index;

            Color? bgColor;
            if (selected != null) {
              if (isCorrect) {
                bgColor = Colors.green.shade100;
              } else if (isSelected) {
                bgColor = Colors.red.shade100;
              }
            }

            return Card(
              color: bgColor,
              child: ListTile(
                title: Text(question.options[index]),
                onTap: selected == null
                    ? () {
                        setState(() {
                          selectedAnswers[currentIndex] = index;
                        });
                      }
                    : null,
              ),
            );
          }),

          const Spacer(),

          Row(
            children: [
              if (currentIndex > 0)
                TextButton(
                  onPressed: () {
                    setState(() {
                      currentIndex--;
                    });
                  },
                  child: const Text('Previous'),
                ),

              const Spacer(),

              ElevatedButton(
                onPressed: selected == null
                    ? null
                    : () async {
                        if (currentIndex == widget.questions.length - 1) {
                          if (!_completionNotified) {
                            _completionNotified = true;
                            setState(() {
                              showResult = true;
                              _pointsStatus = PointsSyncStatus.pending;
                              _pointsError = null;
                            });
                            final completed = await _runCompletion(
                              score,
                              widget.questions.length,
                            );
                            if (mounted) {
                              setState(() {
                                _pointsStatus = completed
                                    ? PointsSyncStatus.saved
                                    : PointsSyncStatus.failed;
                              });
                            }
                          }
                        } else {
                          setState(() {
                            currentIndex++;
                          });
                        }
                      },
                child: Text(
                  currentIndex == widget.questions.length - 1
                      ? 'Finish'
                      : 'Next',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(LearningProgress progress) {
    final total = widget.questions.length;
    final percentage = ((score / total) * 100).round();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 64, color: Colors.amber),
          const SizedBox(height: 16),

          const Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text('Score: $score / $total', style: const TextStyle(fontSize: 18)),

          const SizedBox(height: 8),

          Text('Accuracy: $percentage%', style: const TextStyle(fontSize: 16)),

          const SizedBox(height: 12),
          _buildPointsStatus(),
          if (_pointsError != null) ...[
            const SizedBox(height: 6),
            Text(_pointsError!, style: const TextStyle(color: Colors.red)),
          ],

          const SizedBox(height: 12),
          Text(
            '${progress.points} pts • Total',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            onPressed: () {
              setState(() {
                selectedAnswers = List.filled(widget.questions.length, null);
                currentIndex = 0;
                showResult = false;
                _pointsStatus = PointsSyncStatus.idle;
                _pointsError = null;
                _completionNotified = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPointsBanner(LearningProgress progress) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, size: 18, color: Colors.amber.shade700),
            const SizedBox(width: 6),
            Text(
              '${progress.points} pts',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsStatus() {
    String message;
    Color color;
    Widget? suffix;

    switch (_pointsStatus) {
      case PointsSyncStatus.pending:
        message = 'Points pending...';
        color = Colors.orange.shade700;
        suffix = const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
        break;
      case PointsSyncStatus.saved:
        message = '+50 pts saved';
        color = Colors.green.shade700;
        suffix = const Icon(Icons.check_circle, color: Colors.green);
        break;
      case PointsSyncStatus.failed:
        message = 'Points could not be saved';
        color = Colors.red;
        suffix = const Icon(Icons.error_outline, color: Colors.red);
        break;
      default:
        message = 'Points will update once saved';
        color = Colors.grey;
        suffix = null;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        if (suffix != null) ...[const SizedBox(width: 8), suffix],
      ],
    );
  }

  Future<bool> _runCompletion(int score, int total) async {
    if (widget.onCompleted == null) return true;
    try {
      return await widget.onCompleted!(score, total);
    } catch (e) {
      _pointsError = e.toString();
      return false;
    }
  }
}
