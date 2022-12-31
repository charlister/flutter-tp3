import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3/cubit/question_cubit.dart';
import 'package:tp3/cubit/theme_cubit.dart';
import 'package:tp3/model/theme_model.dart';
import 'package:tp3/page/question_page.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thèmes"),
        centerTitle: true,
      ),
      body: Container(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          // bloc: BlocProvider.of<ThemeCubit>(context),
          builder: (context, state) {
            if (state is ThemeInitial) {
              BlocProvider.of<ThemeCubit>(context).getThemes();
              print("theme page initial");
              return Text("initial");
            }
            else if (state is ThemeLoading) {
              print("theme page loading");
              return Text("loading");
            }
            else if (state is ThemeLoaded) {
              print("theme page loaded");
              return themeOptions(state.themes, context);
            }
            else {
              print("theme page error");
              return Text("error");
            }
          },
        ),

      ),
    );
  }

  TextButton themeOption(ThemeModel theme, BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<QuestionCubit>(context).getQuestions(theme.name.toString());
        print('=====================${theme.name}=====================');
        var route = MaterialPageRoute(
          maintainState: false,
          builder: (context) => QuestionPage(),
          settings: RouteSettings(
            arguments: theme.name.toString(),
          ),
        );
        Navigator.push(context, route);
      },
      child: Center(child: Text(theme.name.toString())),
    );
  }

  ListView themeOptions(List<ThemeModel> themes, BuildContext context) {
    List<TextButton> options = [];
    for(var theme in themes) {
      options.add(themeOption(theme, context));
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: options,
    );
  }
}