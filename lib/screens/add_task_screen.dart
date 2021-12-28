import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/task_service.dart';
import 'package:jei_project_manager_app/widgets/input_theme_provider.dart';
import 'package:jei_project_manager_app/widgets/text_field_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final projectController = TextEditingController();
  final deadlineController = TextEditingController();

  String? value;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: TextFieldWidget(item, 15),
      );
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget build(BuildContext context) {
    return InputThemeProvider(
      child: Scaffold(
        appBar: AppBar(
          title: TextFieldWidget("Add task", 30),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  isAlwaysShown: true,
                  showTrackOnHover: true,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    children: [
                      TextFieldWidget("Name : ", 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => nameController.clear(),
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF171a33),
                                size: 20,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      TextFieldWidget("Project : ", 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: projectController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => projectController.clear(),
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF171a33),
                                size: 20,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      TextFieldWidget("Description : ", 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          maxLines: 3,
                          controller: descriptionController,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      TextFieldWidget("Deadline : ", 20),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF171a33),
                                width: 1,
                              )),
                          child: Row(
                            children: [
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: const TextStyle(
                                  color: Color(0xFF171a33),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 190,
                              ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(90, 30),
                    primary: const Color(0xFF8a2831),
                    onPrimary: Colors.white,
                    side: const BorderSide(
                      color: Color(0xFF8a2831),
                      width: 0.5,
                    ),
                  ),
                  onPressed: () {
                    Task data = Task(
                      name: nameController.text,
                      project: int.parse(projectController.text),
                      description: descriptionController.text,
                      deadline: selectedDate,
                      status: 'to do',
                    );
                    TaskServices.postTask(data).then((_) {
                      Navigator.of(context).pop();
                    });
                    print(data.toJson());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
