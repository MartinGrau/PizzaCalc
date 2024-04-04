import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/modal_sheet_button.dart';
import '../widgets/pizza_container.dart';

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();

  
}

class HomeScreenState extends State<HomeScreen> {

  List<PizzaContainer> pizzaItems = [];
  String pageTitle = "Price per slice";

  final TextEditingController pizzaNameController = TextEditingController();
  final TextEditingController pizzaPlaceController = TextEditingController();

  void addPizzaItem(String pizzaName, String pizzaPlace){
    setState(() { 
      pizzaItems.add(
        PizzaContainer(state: this, name: pizzaName, place: pizzaPlace)
      );
    });
  }

  void deletePizzaItem(PizzaContainer pizza){
    setState(() {
      pizzaItems.remove(pizza);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Pizza Calc'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'show settings',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('There are no settings yet :(')));
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            tooltip: 'help',
            onPressed: () {
              showDialog(
                context: context, // Pass the context to showDialog
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Help"),
                    content: Text("Slide Items to the left to delete them.\n\nIf you mark a pizza as your favorite it gets saved for the next time"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pizzaItems.length,
                itemBuilder: (BuildContext context, int index){
                  return pizzaItems[index];
                },
              )
            ),
            ElevatedButton(
              
              onPressed: () => showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: const Text('New Pizza'),
                  contentPadding: const EdgeInsets.all(8.0),
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'funghi'
                       ),
                       controller: pizzaNameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Place',
                        hintText: "Luigi's"
                       ),
                       controller: pizzaPlaceController,
                    ),
                    TextButton(
                      onPressed: (){
                        final newPizzaName = pizzaNameController.text;
                        final newPizzaPlace = pizzaPlaceController.text;
                        pizzaNameController.clear();
                        pizzaPlaceController.clear();
                        try {
                          addPizzaItem(newPizzaName, newPizzaPlace);
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.of(context).pop();
                      }, 
                      child: const Text('Done')
                    )
                  ],
                ),
              ),
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Adjust for desired roundness
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0), // Margin around the button content
              ),
            ),
          ],
        ),
      ),
    );
  }
  
 
}
