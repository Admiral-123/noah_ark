import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:noah_ark/backend_handling_and_providers/supabase_handle.dart';
import 'package:noah_ark/backend_handling_and_providers/theme_provider.dart';
import 'package:noah_ark/home.dart';
import 'package:noah_ark/log_sign/login.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  Supabase.initialize(
      anonKey: dotenv.get('anon_key'), url: dotenv.get('project_url'));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SupabaseHandle()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme:
          context.watch<ThemeProvider>().isDark ? ThemeData.dark() : null,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
              backgroundColor: Color.fromARGB(255, 75, 174, 255))),
      color: const Color.fromARGB(255, 75, 174, 255),
      home: SplashScr(),
    );
  }
}

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  @override
  initState() {
    super.initState();
    switchScr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const CircularProgressIndicator(),
          )
        ],
      ),
    ));
  }

  Future<dynamic> switchScr() async {
    await Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => StreamBuilder(
                  stream: context.read<SupabaseHandle>().onAuthState(),
                  builder: (context, snapshot) {
                    var session =
                        snapshot.hasData ? snapshot.data!.session : null;

                    if (session != null) {
                      return Home();
                    } else {
                      return Login();
                    }
                  })));
    });
  }
}
