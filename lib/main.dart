import 'package:employee_management/pages/employee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/employee_list_bloc/employee_list_bloc.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeListBloc>(
      create: (context) => EmployeeListBloc(),
      lazy: false,
      child: MaterialApp(
        title: 'Simple Employee management',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: primarySwatchColor,
              titleTextStyle: appBarTitleTextStyle,
              elevation: 0),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: primarySwatchColor),
        ),
        home: const EmployeeList(),
      ),
    );
  }
}
