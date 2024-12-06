import 'package:flutter/material.dart';
import 'package:practice2/data/local/db_connection.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<Map<String, dynamic>> allNotes = [];
  DBConnection? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DBConnection.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  void openBottomSheet({required bool isEdit, Map<String, dynamic>? note}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetView(
        dbRef: dbRef,
        onNoteAdded: getNotes,
        isEdit: isEdit,
        note: note,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
        itemCount: allNotes.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Text('${index+1}'),
            title: Text(allNotes[index][DBConnection.COLUMN_NOTE_TITLE]),
            subtitle: Text(allNotes[index][DBConnection.COLUMN_NOTE_DESC]),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      openBottomSheet(isEdit: true, note: allNotes[index]);
                    },
                  ),
                  InkWell(
                    child : const Icon(Icons.delete, color: Colors.red),
                    onTap: () async {
                      bool check = await dbRef!.deleteNote(sno: allNotes[index][DBConnection.COLUMN_NOTE_SN0]);
                      if(check) {
                        getNotes();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      )
          : const Center(child: Text("No Notes added !!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet(isEdit: false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BottomSheetView extends StatefulWidget {
  final DBConnection? dbRef;
  final VoidCallback onNoteAdded;
  final bool isEdit;
  final Map<String, dynamic>? note;

  const BottomSheetView({
    super.key,
    required this.dbRef,
    required this.onNoteAdded,
    required this.isEdit,
    this.note,
  });

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.note != null) {
      titleController.text = widget.note![DBConnection.COLUMN_NOTE_TITLE] ?? '';
      descriptionController.text = widget.note![DBConnection.COLUMN_NOTE_DESC] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 30 : MediaQuery.of(context).viewInsets.bottom + 10,
        left: 15,
        right: 15,
        top: 17,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEdit ? 'Edit Note' : 'Add Note',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title here",
                label: const Text('Title'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Enter Description here",
                label: const Text('Description'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      var title = titleController.text;
                      var desc = descriptionController.text;

                      if (title.isNotEmpty && desc.isNotEmpty) {
                        if (widget.isEdit) {
                          // Update the note in the database
                          bool check = await widget.dbRef!.updateNote(
                            sno : widget.note![DBConnection.COLUMN_NOTE_SN0],
                            title: title,
                            desc: desc,
                          );
                          if (check) widget.onNoteAdded();
                        } else {
                          // Add the new note
                          bool check = await widget.dbRef!.addNote(
                            mTitle: title,
                            mDesc: desc,
                          );
                          if (check) widget.onNoteAdded();
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the details.'),
                          ),
                        );
                      }
                    },
                    child: Text(widget.isEdit ? 'Edit Note' : 'Add Note'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
