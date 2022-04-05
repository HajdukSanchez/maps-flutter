import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/screens.dart';
import 'package:maps_app/services/services.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(create: (context) => SearchBloc(trafficService: TrafficService())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: Scaffold(body: LoadingScreen()),
    );
  }
}
