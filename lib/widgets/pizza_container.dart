import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tutorial04/screens/home_screen.dart';

class PizzaContainer extends StatefulWidget{
  final HomeScreenState state;
  final String name,place;
  const PizzaContainer({required this.state, required this.name, required this.place});

  @override
  _PizzaContainerState createState() => _PizzaContainerState(place, name: name);
}

class _PizzaContainerState extends State<PizzaContainer>{

  String dropdownValue = "Circle";
  final String name,place;

  _PizzaContainerState(this.place, {required this.name});

  TextEditingController sizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  double result = 0; 

  final Icon _unmarkedHeart = Icon(Icons.favorite_border);
  final Icon _markedHeart = Icon(Icons.favorite, color: Colors.red);
  bool _ismarked = false;

  void handleDelete(){
    widget.state.deletePizzaItem(this.widget);
  }

  void updateResult() {
    setState(() {
      double size =
          double.tryParse(sizeController.text) ?? 0;
      double price =
          double.tryParse(priceController.text) ?? 0;
      // Perform division, handle division by zero if needed
      if(dropdownValue == "Circle")
        size = pow(size/2,2) * pi;
      if(dropdownValue == "Rectangle")
        size = 0;
      if(dropdownValue == "Square")
        size = 0; //obv just a placeholder for when i get motivated to do it lol
      if (size != 0) {
        result = price *10000 / size;
        int i = result.round();
        result = i /100;
      } else {
        result = double.infinity; // or any other value to indicate division by zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Dismissible(
      confirmDismiss: (direction) => showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text('Delete Pizza'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirm'),
            ),
          ],
        )
      ),
      background: Container(
        color: Colors.red,
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart, //Swipe right-to-left
      onDismissed: (_) => handleDelete(), //call delete function
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Change the color and opacity as needed
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // Changes the position of the shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Text('name: ${name}    from: ${place}'),
                  Spacer(),
                  IconButton(
                    icon: _ismarked ? _markedHeart : _unmarkedHeart,
                    onPressed: () {
                      setState((){
                        _ismarked = !_ismarked;
                      });
                    },
                  ),
                ]
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: sizeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Diameter",
                          ),
                          textInputAction: TextInputAction.go,
                          onSubmitted: (String text){updateResult();},
                      )
                  ),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Price",
                        ),
                        textInputAction: TextInputAction.go,
                        onSubmitted: (String text){updateResult();},
                    )
              ),
                ],
              ),
            
              Text("Price per slice: ${result} cent/cm^2"),
            ],
            ),
        )
      )
    );
    
  }


  

}

class DropdownButtonShape extends StatefulWidget {
  const DropdownButtonShape({super.key});

  @override
  State<DropdownButtonShape> createState() => _DropdownButtonShapeState();
}

class _DropdownButtonShapeState extends State<DropdownButtonShape> {

static const List<String> dropDownOptions = <String>[
    "Circle",
  ];

  String dropdownValue = dropDownOptions.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: dropDownOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}