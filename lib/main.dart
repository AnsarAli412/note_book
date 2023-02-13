import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/view/screens/notes/notes_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NoteController>.value(value: NoteController())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotesScreen(),
    );
  }
}
