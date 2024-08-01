import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/step_counter/presentation/bloc/step_counter_/step_counter_bloc.dart';

import 'features/step_counter/presentation/pages/step_counter_page.dart';
import 'features/step_counter/data/datasources/step_counter_local_data_source.dart';
import 'features/step_counter/data/repositories/step_counter_repository_impl.dart';
import 'features/step_counter/domain/usecases/get_step_count.dart';
import 'features/step_counter/domain/usecases/set_step_goal.dart'; // Импортируем новый use case
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  final localDataSource = StepCounterLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final repository = StepCounterRepositoryImpl(localDataSource: localDataSource);

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    getStepCount: GetStepCount(repository: repository),

    setStepGoal: SetStepGoal(repository),
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final GetStepCount getStepCount;

  final SetStepGoal setStepGoal;

  MyApp({
    required this.sharedPreferences,
    required this.getStepCount,

    required this.setStepGoal,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Step Counter',
      home: BlocProvider(
        create: (context) => StepCounterBloc(
          getStepCount: getStepCount,

          sharedPreferences: sharedPreferences,
          setStepGoal: setStepGoal,
        ),
        child: StepCounterPage(),
      ),
    );
  }
}