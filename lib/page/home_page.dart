import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3/cubit/theme_cubit.dart';
import 'package:tp3/page/adding_page.dart';
import 'package:tp3/page/theme_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  BlocProvider.of<ThemeCubit>(context).reset();
                  var route = MaterialPageRoute(
                    maintainState: false,
                    builder: (context) => ThemePage(),
                  );
                  Navigator.push(context, route);
                },
                child: const Text(
                  "Démarrer un quiz",
                )
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ThemeCubit>(context).reset();
                  var route = MaterialPageRoute(
                    maintainState: false,
                    builder: (context) => AddPage(),
                  );
                  Navigator.push(context, route);
                },
                child: const Text(
                  "Ajouter des questions",
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}