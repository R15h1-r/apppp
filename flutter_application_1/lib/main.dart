import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Communication App"),
        backgroundColor: Colors.black,
      ),
      body: VerticalBoxScroller(),
    );
  }
}

class VerticalBoxScroller extends StatelessWidget {
  final Map<String, List<String>> dialogues = {
    "Greetings": [
      "Hello",
      "Good morning",
      "Good night",
      "How are you?",
    ],
    "Food": [
      "I'm hungry",
      "I want water",
      "What's for dinner?",
    ],
    "Help": [
      "I need help",
      "Call a doctor",
      "Please assist me",
    ],
    "Expressions": [
      "Thank you",
      "I'm sorry",
      "I love you",
    ],
    "Medical Needs": [
      "I need my medicine",
      "I feel pain",
      "Call 911",
    ],
    "Weather": [
      "What's the weather?",
      "Is it raining?",
      "It's cold today",
    ],
    "Time": [
      "What time is it?",
      "Is it lunchtime?",
      "Is it bedtime?",
    ],
    "Family": [
      "Where is mom?",
      "I want to talk to dad",
      "Call my sister",
    ],
    "Emergency": [
      "Help me immediately",
      "I need urgent care",
      "Call emergency services",
    ],
    "Daily Activities": [
      "I want to watch TV",
      "I want to read a book",
      "Let's go outside",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dialogues.keys.length,
      itemBuilder: (context, index) {
        String key = dialogues.keys.elementAt(index);
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DialogueScreen(
                title: key,
                dialogues: dialogues[key]!,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                key,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DialogueScreen extends StatelessWidget {
  final String title;
  final List<String> dialogues;

  DialogueScreen({required this.title, required this.dialogues});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: DialogueList(dialogues: dialogues),
    );
  }
}

class DialogueList extends StatefulWidget {
  final List<String> dialogues;

  DialogueList({required this.dialogues});

  @override
  _DialogueListState createState() => _DialogueListState();
}

class _DialogueListState extends State<DialogueList> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dialogues.length,
      itemBuilder: (context, index) {
        String text = widget.dialogues[index];
        return GestureDetector(
          onTap: () => speak(text),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}



