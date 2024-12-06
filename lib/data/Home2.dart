import 'package:flutter/material.dart';
import 'package:practice2/data/local/dbProvider.dart';
import 'package:practice2/data/taskAdding.dart';
import 'package:provider/provider.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        // actions: [
        //   PopupMenuButton(
        //     itemBuilder: (_){
        //       return PopupMenuItem(
        //         child: ,
        //       ),
        //     },
        //   ),
        // ],
      ),
      body: Consumer<DBProvider>(
        builder: (ctx, provider, __) {
          final allNotes = provider.getNotes;
          if (allNotes.isEmpty) {
            return const Center(child: Text("No Notes added !!"));
          }

          return ListView.builder(
            itemCount: allNotes.length,
            itemBuilder: (_, index) {
              final note = allNotes[index];
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(note['title'] ?? 'Untitled'),
                subtitle: Text(note['description'] ?? ''),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to TaskAdding with note details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskAdding(
                                isEditing: true,
                                sno: note['s_no'],
                                initialTitle: note['title'] ?? '',
                                initialDescription: note['description'] ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: const Icon(Icons.delete, color: Colors.red),
                        onTap: () {
                          print("Deleting note: ${note}");
                          context.read<DBProvider>().deleteNote(note['s_no']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskAdding(isEditing: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
