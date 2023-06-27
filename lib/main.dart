import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parentoday_ai/pages/pages.dart';
import 'package:supercharged/supercharged.dart';

import 'cubits/ai_cubit.dart';
import 'cubits/datauser_dart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAg6n3kIS7eiabH4a-MtpL5eoDVE90EB84",
        authDomain: "master-ai-79740.firebaseapp.com",
        projectId: "master-ai-79740",
        storageBucket: "master-ai-79740.appspot.com",
        messagingSenderId: "195874678073",
        appId: "1:195874678073:web:67479ab569f676a84034e8",
        measurementId: "G-JSGV31T0LN"
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
      ],
      child: GetMaterialApp(
        color: 'FF6969'.toColor(),
        debugShowCheckedModeBanner: false,
        home: const LoginPage('1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4'),
      ),
    );
  }
}
