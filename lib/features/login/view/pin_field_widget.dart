import 'package:diyo_test/features/login/bloc/pin_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinFieldWidget extends StatelessWidget {
  PinFieldWidget({super.key});

  final List<int> numpadList = List.generate(12, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Enter PIN",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<PinFieldBloc, PinFieldState>(
          builder: (context, state) {
            return SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("state : ${state.value}");

                  bool isFilled() {
                    // return state.value.length >= index + 1;
                    return state.value.length >= index + 1;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isFilled() ? Colors.black87 : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 400,
          width: 300,
          child: GridView.builder(
            itemCount: numpadList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              String getTitleNumpad() {
                int num = index + 1;

                if (num == 10 || num == 12) return "";

                if (num == 11) return "0";

                return num.toString();
              }

              return GestureDetector(
                onTap: () {
                  BlocProvider.of<PinFieldBloc>(context)
                      .add(PinFieldInputEvent(getTitleNumpad()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      getTitleNumpad(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
