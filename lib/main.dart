import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مذكرتي',
      theme: ThemeData(useMaterial3: true),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final controller = TextEditingController();
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    setState(() => notes = p.getStringList('notes') ?? []);
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList('notes', notes);
  }

  void add() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      notes.add(controller.text.trim());
      controller.clear();
    });
    save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مذكرتي - Godnit')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'اكتب ملاحظة'))),
            IconButton(onPressed: add, icon: const Icon(Icons.add))
          ]),
        ),
        Expanded(child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (c,i)=>ListTile(title: Text(notes[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: (){setState(()=>notes.removeAt(i));save();}))
        ))
      ]),
    );
  }
}
