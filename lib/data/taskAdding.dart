import 'package:flutter/material.dart';
import 'package:practice2/data/local/dbProvider.dart';
import 'package:provider/provider.dart';

class TaskAdding extends StatefulWidget {
  final bool isEditing;
  final int? sno;
  final String? initialTitle;
  final String? initialDescription;

  const TaskAdding({
    super.key,
    this.isEditing = false,
    this.sno,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<TaskAdding> createState() => _TaskAddingState();
}

class _TaskAddingState extends State<TaskAdding> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      titleController.text = widget.initialTitle ?? '';
      descriptionController.text = widget.initialDescription ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEditing ? 'Edit Note' : 'Add Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                          if (widget.isEditing) {
                            context
                                .read<DBProvider>()
                                .updateNote(title, desc, widget.sno!);
                          } else {
                            context.read<DBProvider>().addNote(title, desc);
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
                      child: Text(
                        widget.isEditing ? 'Edit Note' : 'Add Note',
                      ),
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
      ),
    );
  }
}
