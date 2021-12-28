import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/services/projects_service.dart';
import 'package:jei_project_manager_app/widgets/input_theme_provider.dart';
import 'package:jei_project_manager_app/widgets/rounded_button.dart';
import 'package:jei_project_manager_app/widgets/text_field_widget.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final membersController = TextEditingController();
  final deadlineController = TextEditingController();
  final items = [
    "Développement Web",
    "Développement Mobile",
    "Référencement Web"
  ];
  final itemsSelected = TextEditingController();

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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget build(BuildContext context) {
    return InputThemeProvider(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "Ajouter un projet",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  children: [
                    TextFieldWidget("Nom : ", 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => nameController.clear(),
                            icon: Icon(
                              Icons.close,
                              color: Color(0xFF171a33),
                              size: 20,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    TextFieldWidget("Type : ", 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFF171a33),
                              width: 1,
                            )),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: value,
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.value = value),
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF171a33),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextFieldWidget("Description : ", 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        maxLines: 3,
                        controller: descriptionController,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    TextFieldWidget("Membres : ", 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextField(
                        controller: membersController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => membersController.clear(),
                            icon: Icon(
                              Icons.close,
                              color: Color(0xFF171a33),
                              size: 20,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    TextFieldWidget("Date limite : ", 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFF171a33),
                              width: 1,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                color: Color(0xFF171a33),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  text: "Ajouter",
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Veuillez entrer le nom du projet",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xFF8a2831),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (value == null) {
                      Fluttertoast.showToast(
                          msg: "Un projet doit avoir un type",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xFF8a2831),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (descriptionController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Veuillez ajouter une description au projet",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xFF8a2831),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (membersController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Veuillez ajouter des membres au projet",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xFF8a2831),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (selectedDate.isAtSameMomentAs(DateTime.now())) {
                      Fluttertoast.showToast(
                          msg: "Veuillez ajouter une date limite",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xFF8a2831),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Project project = Project(
                        name: nameController.text,
                        type: value!,
                        description: descriptionController.text,
                        members: membersController.text
                            .split(",")
                            .map((name) => name.trim())
                            .toList(),
                        deadline: selectedDate,
                      );
                      ProjectsService.postProject(project).then((_) {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
