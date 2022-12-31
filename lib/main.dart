import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3/cubit/question_cubit.dart';
import 'package:tp3/cubit/theme_cubit.dart';
import 'package:tp3/page/adding_page.dart';
import 'package:tp3/page/home_page.dart';
import 'package:tp3/page/question_page.dart';
import 'package:tp3/page/theme_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //   home: BlocProvider(
  //     create: (context) => ThemeCubit(),
  //     child: AddPage(),
  //   ),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => ThemeCubit(),),
          BlocProvider(create: (BuildContext context) => QuestionCubit(),),
        ],
        child: BlocBuilder<QuestionCubit, QuestionState>(
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            return MaterialApp(
              home: HomePage(),
            );
          },
        ),
      ),
    );
  }
}