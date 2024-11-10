import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> main() async {


  await Supabase.initialize(
    url: 'https://ckbvijuaedwjhymeqfhx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNrYnZpanVhZWR3amh5bWVxZmh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyMzA3NDAsImV4cCI6MjA0NjgwNjc0MH0.D6GoadsDebtk7C-wFF_DrRPTNUAk7yM-6IjXvuunipc',
  );


  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value)=> Get.put(AuthenticationRepository()));

  runApp(const App());
}


