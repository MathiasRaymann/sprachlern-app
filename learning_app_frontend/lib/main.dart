import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vokabeltrainer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const VocabularyTrainer(),
    );
  }
}

class VocabularyTrainer extends StatefulWidget {
  const VocabularyTrainer({super.key});

  @override
  State<VocabularyTrainer> createState() => _VocabularyTrainerState();
}

class _VocabularyTrainerState extends State<VocabularyTrainer> {
  List<dynamic> exercises = [];
  int currentIndex = 0;
  final TextEditingController _inputController = TextEditingController();

  bool isLoading = true;
  String? feedbackMessage;
  Color feedbackColor = Colors.black;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  // --- DATEN LADEN ---
  Future<void> fetchExercises() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8080/api/exercises'));
      if (response.statusCode == 200) {
        setState(() {
          exercises = jsonDecode(response.body);
          exercises.shuffle();
          isLoading = false;
          // Alles zurücksetzen
          currentIndex = 0;
          feedbackMessage = null;
          isChecked = false;
          _inputController.clear();
        });
      }
    } catch (e) {
      print("Fehler beim Laden: $e");
      setState(() => isLoading = false);
    }
  }

  // --- NEUES WORT HINZUFÜGEN ---
  Future<void> addVocabulary(String deutsch, String spanisch) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/api/exercises'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "type": "vocab",
          "lesson": {"id": 1},
          "xpReward": 10,
          "order": exercises.length + 1,
          "content": {
            "question": deutsch,
            "correct_answer": spanisch
          }
        }),
      );

      if (response.statusCode == 200) {
        fetchExercises(); // Liste neu laden
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Wort gespeichert!")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fehler: $e")),
        );
      }
    }
  }

  // --- WORT LÖSCHEN (NEU!) ---
  Future<void> deleteCurrentExercise() async {
    // 1. ID herausfinden
    final currentExercise = exercises[currentIndex];
    final int id = currentExercise['id'];

    try {
      // 2. Lösch-Befehl an Backend senden
      final response = await http.delete(Uri.parse('http://localhost:8080/api/exercises/$id'));

      if (response.statusCode == 204 || response.statusCode == 200) {
        // 3. Aus lokaler Liste entfernen
        setState(() {
          exercises.removeAt(currentIndex);

          // Wenn wir am Ende der Liste waren, müssen wir eins zurückgehen
          if (currentIndex >= exercises.length) {
            currentIndex = 0;
          }

          // UI Reset
          _inputController.clear();
          feedbackMessage = null;
          isChecked = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("🗑️ Wort gelöscht!")),
          );
        }
      }
    } catch (e) {
      print("Fehler beim Löschen: $e");
    }
  }

  // --- DIALOGE ---

  // Hinzufügen Dialog
  void showAddDialog() {
    String newDeutsch = "";
    String newSpanisch = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Neues Wort hinzufügen"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Deutsch (Frage)"),
              onChanged: (value) => newDeutsch = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Spanisch (Antwort)"),
              onChanged: (value) => newSpanisch = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Abbrechen")),
          ElevatedButton(
            onPressed: () {
              if (newDeutsch.isNotEmpty && newSpanisch.isNotEmpty) {
                addVocabulary(newDeutsch, newSpanisch);
                Navigator.pop(context);
              }
            },
            child: const Text("Speichern"),
          ),
        ],
      ),
    );
  }

  // Löschen Bestätigungs-Dialog (NEU!)
  void showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Löschen?"),
        content: const Text("Willst du dieses Wort wirklich dauerhaft entfernen?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Abbrechen")),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Dialog schließen
              deleteCurrentExercise(); // Löschen ausführen
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Löschen"),
          ),
        ],
      ),
    );
  }

  // --- LOGIK ---
  void checkAnswer() {
    String userInput = _inputController.text.trim().toLowerCase();
    var currentExercise = exercises[currentIndex];

    String correctAnswer = "";
    if (currentExercise['content'] != null) {
      correctAnswer = currentExercise['content']['correct_answer'] ?? "";
    }

    if (userInput == correctAnswer.toLowerCase()) {
      setState(() {
        feedbackMessage = "✅ Richtig!";
        feedbackColor = Colors.green;
        isChecked = true;
      });
    } else {
      setState(() {
        feedbackMessage = "❌ Falsch. Richtig wäre: $correctAnswer";
        feedbackColor = Colors.red;
        isChecked = true;
      });
    }
  }

  void nextQuestion() {
    setState(() {
      if (currentIndex < exercises.length - 1) {
        currentIndex++;
        _inputController.clear();
        feedbackMessage = null;
        isChecked = false;
      } else {
        feedbackMessage = "🎉 Alle durch! Neustart...";
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) fetchExercises(); // Neu laden und mischen
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    // Leerer Status (wenn alles gelöscht wurde)
    if (exercises.isEmpty) {
      return Scaffold(
          appBar: AppBar(title: const Text("Vokabeltrainer")),
          body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sentiment_dissatisfied, size: 60, color: Colors.grey),
                const SizedBox(height: 20),
                const Text("Keine Vokabeln mehr da."),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: showAddDialog, child: const Text("Neues Wort hinzufügen"))
              ]
          ))
      );
    }

    final currentExercise = exercises[currentIndex];
    String question = currentExercise['content']?['question'] ?? "Keine Frage";

    return Scaffold(
      appBar: AppBar(
        title: Text("Wort ${currentIndex + 1} / ${exercises.length}"),
        actions: [
          // HIER IST DER MÜLLEIMER:
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: showDeleteConfirmation,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Übersetze ins Spanische:", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              question,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Spanische Übersetzung',
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 20),
            if (feedbackMessage != null)
              Text(
                feedbackMessage!,
                style: TextStyle(fontSize: 18, color: feedbackColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isChecked
                    ? (currentIndex < exercises.length - 1 ? nextQuestion : null)
                    : checkAnswer,
                child: Text(isChecked
                    ? (currentIndex < exercises.length - 1 ? "Nächstes Wort" : "Fertig")
                    : "Prüfen"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}