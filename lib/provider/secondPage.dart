import 'package:flutter/material.dart';
import 'package:practice2/provider/list_provider.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    print('Build called !!');
    return Consumer<NumberListProvider>(
      builder: (context, numbersListProvider, child) => Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'Add',
              onPressed: (){
                numbersListProvider.add();
              },
              child: const Icon(Icons.add,),
            ),
            FloatingActionButton(
              heroTag: 'Subtract',
              onPressed: (){
                numbersListProvider.subtract();
              },
              child: const Icon(Icons.remove,),
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Provider'),
        ),
        body: SizedBox(
          child: Column(
            children: [
              Text(numbersListProvider.numbers.last.toString(),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: numbersListProvider.numbers.length,
                  itemBuilder: (context, index) {
                    return Text(numbersListProvider.numbers[index].toString(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
