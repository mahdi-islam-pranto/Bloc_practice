import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/country_details.dart';
import 'pages/country_list.dart';
import 'pages/todolist.dart';

void main() {
  runApp(const MyApp());
}

// bloc provider logic class using Cubit
class CounterLogic extends Cubit<int> {
  // initial state
  CounterLogic() : super(0);

  // all logic functions

  void increment_func() {
    return emit(state + 1);
  }

  void decrement_func() {
    return emit(state - 1);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // wrap the app with MultiBlocProvider for accessibility of bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterLogic()),
        BlocProvider(create: (context) => CountryListLogic()),
        BlocProvider(create: (context) => NavigateToCountryDetailsPageLogic()),
        BlocProvider(create: (context) => AddTaskLogic()),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              // make the header text center aligned

              child: Text('Learn BLoc'),
            ),
            ListTile(
              title: const Text('Country List API'),
              onTap: () {
                // got to country list page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CountryListPage()));
              },
            ),
            ListTile(
              title: const Text('Task list'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ToDoListPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // display the number count with BlocBuilder
            BlocBuilder<CounterLogic, int>(builder: (context, numberCount) {
              return Text("$numberCount", style: const TextStyle(fontSize: 40));
            }),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // call the increment function from the bloc
                  context.read<CounterLogic>().increment_func();
                },
                child: const Text('+')),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  // call the decrement function from the bloc
                  context.read<CounterLogic>().decrement_func();
                },
                child: const Text('-')),
          ],
        ),
      ),
    );
  }
}
