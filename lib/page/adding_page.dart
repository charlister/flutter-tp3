import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp3/cubit/theme_cubit.dart';
import 'package:tp3/model/theme_model.dart';
import 'package:tp3/repository/file_repository.dart';
import 'package:tp3/repository/question_repository.dart';
import 'package:tp3/repository/theme_repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  ThemeRepository themeRepository = ThemeRepository();
  QuestionRepository questionRepository = QuestionRepository();
  FileRepository fileRepository = FileRepository();

  late String newTheme;
  late String question;
  late String response;
  List<String> options = ["", "", ""];

  File? selectedImage;
  String? imageLink;

  String selectedValue = "";

  late List<ThemeModel> themes;
  late List<String> themesName;

  bool isThemeExists = false;
  bool addButtonClickable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("Création"),
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                if (state is ThemeInitial) {
                  BlocProvider.of<ThemeCubit>(context).getThemes();
                  debugPrint("theme page initial");
                  return const Text("initial");
                }
                else if (state is ThemeLoading) {
                  debugPrint("theme page loading");
                  return const Text("loading");
                }
                else if (state is ThemeLoaded) {
                  themesName = state.themes.map((theme) => theme.name.toString()).toList();
                  themes = state.themes;
                  return themesName.isNotEmpty ? menuSelectExistingThemes(themesName) : const Center(child: Text("Aucun thème enregistré"),);
                }
                else {
                  debugPrint("theme page error");
                  return const Text("error");
                }
              },
            ),
            form()
          ],
        ),
      ),
    );
  }

  DropDown menuSelectExistingThemes(List<String> themesName) {
    return DropDown(
      items: themesName,
      onChanged: (value) {
        setState(() {
          debugPrint("***************$value");
          selectedValue = value;
        });
      }
    );
  }

  String getImageLinkFromExistingThemeSelected () {
    ThemeModel theme = themes.firstWhere(
            (element) => element.name == newTheme,
      orElse: () => ThemeModel.empty()
    );
    return theme.imageLink!;
  }

  Column buildImageInput() {
    return Column(
      children: [
        // affiche l'image sélectionnée
        selectedImage != null
            ? Image.file(selectedImage!)
            : const SizedBox(height: 200, child: Center(child: Text('Aucune image sélectionnée'))),
        // bouton pour sélectionner une image
        TextButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              setState(() {
                selectedImage = File(result.files.single.path!);
              });
            } else {
              // User canceled the picker
            }
          },
          child: const Text('Sélectionner une image'),
        ),
      ],
    );
  }

  Form form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              debugPrint('============== theme : $value');
              newTheme = value.trim();
              if (themesName.contains(newTheme.toLowerCase())) {
                setState(() {
                  isThemeExists = true;
                });
              }
              else {
                setState(() {
                  isThemeExists = false;
                });
              }
            },
            decoration: const InputDecoration(labelText: 'Thème'),
            validator: (value) {
              if (value!.isEmpty || value!.trim().isEmpty) {
                return 'Veuillez entrer la question';
              }
              return null;
            },
          ),
          TextFormField(
            onChanged: (value) {
              debugPrint('============== question : $value');
              question = value.trim();
            },
            decoration: const InputDecoration(labelText: 'Question'),
            validator: (value) {
              if (value!.isEmpty || value!.trim().isEmpty) {
                return 'Veuillez entrer la question';
              }
              return null;
            },
          ),
          TextFormField(
            onChanged: (value) {
              debugPrint('============== response : $value');
              response = value.trim();
            },
            decoration: const InputDecoration(labelText: 'Réponse'),
            validator: (value) {
              if (value!.isEmpty || value!.trim().isEmpty) {
                return 'Veuillez entrer la réponse';
              }
              return null;
            },
          ),
          TextFormField(
            onChanged: (value) {
              debugPrint('============== option 1 : $value');
              options[0] = value.trim();
            },
            decoration: const InputDecoration(labelText: 'option 1'),
            validator: (value) {
              if (value!.isEmpty || value!.trim().isEmpty) {
                return "Veuillez entrer l'option 1";
              }
              return null;
            },
          ),
          TextFormField(
            onChanged: (value) {
              debugPrint('============== option 2 : $value');
              options[1] = value.trim();
            },
            decoration: const InputDecoration(labelText: 'option 2'),
          ),
          TextFormField(
            onChanged: (value) {
              debugPrint('============== option 3 : $value');
              options[2] = value.trim();
            },
            decoration: const InputDecoration(labelText: 'option 3'),
          ),
          isThemeExists ? Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Text(
              "ajoutez une question au thème existant",
              style: TextStyle(
                color: Colors.deepOrange,
              ),
            ),
          ) : buildImageInput(),
          TextButton(
            onPressed: () async {
              if(addButtonClickable == true) {
                addButtonClickable = false;
                if ((_formKey.currentState!.validate() && (!isThemeExists && selectedImage != null)) || (_formKey.currentState!.validate() && isThemeExists)) {
                  // le formulaire est valide, vous pouvez envoyer les données
                  debugPrint("valide");
                  try {
                    // bool b = await themeRepository.getTheme(newTheme.toLowerCase());
                    // List<String> tmp = [...options, response];
                    List<String> tmp = [];
                    for(var option in options) {
                      if (option.trim() != "") {
                        tmp.add(option);
                      }
                    }
                    tmp.add(response);
                    debugPrint('**************************$tmp');
                    tmp.shuffle();
                    isThemeExists ?
                    {
                      questionRepository.addQuestion(question, response, newTheme, tmp, getImageLinkFromExistingThemeSelected()),
                      Fluttertoast.showToast(
                        msg: "question enregistrée",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      ),
                      Navigator.pop(context)
                    }:
                    {
                      imageLink = await fileRepository.registerFile(selectedImage!),
                      themeRepository.addTheme(newTheme, imageLink!),
                      questionRepository.addQuestion(question, response, newTheme, tmp, imageLink!),
                      Fluttertoast.showToast(
                        msg: "thème et question enregistrés",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      ),
                      Navigator.pop(context)
                    };
                  } on Exception {
                    debugPrint("Error ...");
                    Fluttertoast.showToast(
                      msg: "une erreur est survenue",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } finally {
                    addButtonClickable = true;
                  }
                }
                else {
                  debugPrint("invalide");
                  addButtonClickable = true;
                }
              }
              else {
                debugPrint("bouton d'enregistrement non clickable.");
              }
            },
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}