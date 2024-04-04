import 'package:flutter/material.dart';

class ModalSheetButton extends StatefulWidget {
  final Function(String) addPizzaItem;
 const ModalSheetButton({required this.addPizzaItem, Key? key}) : super(key: key);

  @override
  State<ModalSheetButton> createState() => _ModalSheetButtonState();
}

class _ModalSheetButtonState extends State<ModalSheetButton> {
  final TextEditingController pizzaNameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showSettingssheet(context);
      },
      child: const Text("New Pizza"),
    );
  }

  Future<dynamic> showSettingssheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
              )
            ),
            height: 400,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("New Pizza"),
                  TextField(
                    controller: pizzaNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "name",
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String text){submitAndAdd(context);},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      submitAndAdd(context);
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }

  void submitAndAdd(BuildContext context) {
    final newPizzaName = pizzaNameController.text;
    pizzaNameController.clear();
    try {
      widget.addPizzaItem(newPizzaName);
    } catch (e) {
      print(e.toString());
    }
    Navigator.of(context).pop();
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}