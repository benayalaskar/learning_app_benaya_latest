import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_benaya_latest/bloc/bloc/login_bloc.dart';
import 'package:learning_app_benaya_latest/data/repository/api_repository.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => LoginBloc(
      ApiRepository(),
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//create login

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _identifierController =
      TextEditingController(text: 'admin');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Text(
              'Flutter E Learning App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'By Benaya Laskar Firdaus',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            //bloc builder untuk login page
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Column(
                    children: [
                      Text(state.loginResponse.user!.username.toString()),
                      Text(state.loginResponse.jwt.toString()),
                    ],
                  );
                }
                if (state is LoginFailed) {
                  return Text(state.message);
                }
                if (state is LoginInProgress) {
                  return const CircularProgressIndicator();
                }
                return const Text("");
              },
            ),
            Spacer(),
            TextField(
              controller: _identifierController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Identifier',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(LoginButtonPressed(
                        _identifierController.text,
                        _passwordController.text,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
