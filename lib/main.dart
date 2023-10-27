import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parentoday_ai/cubits/listHistory_cubit.dart';
import 'package:parentoday_ai/pages/pages.dart';
import 'package:parentoday_ai/theme/color.dart';
import 'package:supercharged/supercharged.dart';

import 'cubits/ai_cubit.dart';
import 'cubits/datauser_dart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBN7s37HC8tyzo-b-XmKP6qEj8fyAk_X-g",
      authDomain: "timun-app.firebaseapp.com",
      projectId: "timun-app",
      storageBucket: "timun-app.appspot.com",
      messagingSenderId: "475090703789",
      appId: "1:475090703789:web:77296c36abcd066b3dbd24",
      measurementId: "G-G8R2JKNE2Z",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AiCubit()),
        BlocProvider(create: (_) => DataUserCubit()),
        BlocProvider(create: (_) => HistoryCubit()),
      ],
      child: GetMaterialApp(
        color: 'FF6969'.toColor(),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
