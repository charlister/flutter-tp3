import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:group_button/group_button.dart';
import 'package:tp3/cubit/question_cubit.dart';
import 'package:tp3/model/question_model.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<QuestionModel> questions;
  late int score;
  late int questionIndex;
  late String userResponse;

  Color buttonNextColor = Colors.grey;
  bool buttonNextIsClickable = false;

  _QuestionPageState() {
    score = 0;
    questionIndex = 0;
    userResponse = "";
  }

  void resetChosenButton() {

  }

  @override
  Widget build(BuildContext context) {
    String themeName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(themeName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<QuestionCubit, QuestionState>(
          bloc: BlocProvider.of<QuestionCubit>(context),
          builder: (context, state) {
            if (state is QuestionInitial) {
              debugPrint("question page initial");
              return const SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              );
            }
            else if (state is QuestionLoading) {
              debugPrint("question page loading");
              return const SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              );
            }
            else if (state is QuestionLoaded) {
              questions = state.questions;
              return questions.length==(questionIndex) ? resultsWidget(context) : Column(
                children: [
                  buildThemeImage(),
                  buildQuestion(),
                  buildOptions(),
                  buildNextButton(),
                ],
              );
            }
            else {
              debugPrint("question page error");
              return const Text("erreur");
            }
          },
        ),
      ),
    );
  }

  void incrScore() {
    score++;
  }

  bool checkResponse() {
    if(questions[questionIndex].response == userResponse) {
      incrScore();
      return true;
    }
    return false;
  }

  bool nextQuestion() {
    if (questionIndex >= questions.length) {
      return false;
    }
    questionIndex += 1;
    return true;
  }

  Card buildThemeImage() {
    return Card(
      child: Column(
        children: [
          Image.network(
            questions[questionIndex].themeImageLink.toString(),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Card buildQuestion() {
    return Card(
      color: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [Colors.lightBlue, Colors.blue],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              '${questionIndex+1}/${questions.length}',
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              questions[questionIndex].text.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  void enableNextButton() {
    buttonNextColor = Colors.green;
    buttonNextIsClickable = true;
  }

  void disableNextButton() {
    buttonNextColor = Colors.grey;
    buttonNextIsClickable = false;
  }

  GroupButton buildOptions() {
    return GroupButton(
      isRadio: true,
      buttons: questions[questionIndex].options!,
      onSelected: (option, index, isSelected) {
        debugPrint('***************************button $index : $option is selected');
        userResponse = option;
        setState(() {
          enableNextButton();
        });
      },
      options: const GroupButtonOptions(
        elevation: 10,
        textPadding: EdgeInsets.all(10),
        selectedColor: Colors.deepOrange,
        selectedTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
        unselectedColor: Colors.black,
        unselectedTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
        spacing: 10,
        direction: Axis.vertical,
      ),
    );
  }

  TextButton buildNextButton() {
    return TextButton(
      onPressed: () {
        checkResponse();
        if (buttonNextIsClickable) {
          setState(() {
            disableNextButton();
            nextQuestion();
          });
        }
      },
      style: TextButton.styleFrom(
        elevation: 10,
        padding: const EdgeInsets.all(10),
        foregroundColor: Colors.white,
        backgroundColor: buttonNextColor,
        textStyle: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold
        ),
        shape: ContinuousRectangleBorder()
      ),
      child: const Text(
          "suivant"
      ),
    );
  }

  Column resultsWidget(BuildContext context) {
    return Column( // Résultats
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Score :',
            style: TextStyle(
                fontSize: 25
            ),
          ),
        ),
        Center(
          child: Text(
            '$score/${questions.length}',
            style: const TextStyle(
                fontSize: 25
            ),
          ),
        ),
        Center(
          child: Image(
            height: 50,
            width: 50,
            image: (score.toDouble()) >= questions.length.toDouble()/2.toDouble() ? const AssetImage('images/good.png') : const AssetImage('images/bad.png'),
          ),
        ),
      ],
    );
  }
}