import 'package:diyo_test/features/login/bloc/pin_field_bloc.dart';
import 'package:diyo_test/features/login/view/pin_field_widget.dart';
import 'package:diyo_test/features/main/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PinFieldBloc(),
        ),
      ],
      child: BlocListener<PinFieldBloc, PinFieldState>(
        listener: (context, state) {
          switch (state) {
            case PinFieldIncorrectState():
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Your pin is incorrect"),
                backgroundColor: Colors.red.shade400,
                duration: const Duration(milliseconds: 990),
              ));
              break;

            case PinFieldCorrectState():
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ));
              break;
            default:
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "DIYO",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PinFieldWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
