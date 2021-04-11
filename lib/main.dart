import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/provider/image_upload_provider.dart';
import 'package:funchat/screens/home.dart';
import 'package:funchat/screens/login.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Login()
      ),
    );
  }
}
