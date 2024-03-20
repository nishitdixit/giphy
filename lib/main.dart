import 'dart:math';

import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy/bloc/display_bloc.dart';
import 'package:giphy/util/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeNotifier(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness:
                    value.isLightTheme ? Brightness.light : Brightness.dark),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: BlocProvider<DisplayBloc>(
        create: (context) => DisplayBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Giphy demo"),
            actions: [
              Switch(
                  value: notifier.isLightTheme,
                  onChanged: (turnedOn) => notifier.lightTheme = turnedOn)
            ],
          ),
          body: BlocConsumer<DisplayBloc, DisplayState>(
            listener: (context, state) {
              print(state.responseType);
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        context.read<DisplayBloc>().add(SearchEvent(value));
                      },
                    ),
                  ),
                  Expanded(
                    child: FlexibleGridView(
                      shrinkWrap: true,
                      axisCount: GridLayoutEnum.threeElementsInRow,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: List.generate(
                        state.data.length,
                        (index) => Container(
                          color: Colors.blue,
                          height: 100 + Random().nextInt(100).toDouble(),
                          child: Image.network(state.data[index].url),
                        ),
                      ),
                    ),
                  ),
                  if (state.responseType == ResponseType.pending)
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
