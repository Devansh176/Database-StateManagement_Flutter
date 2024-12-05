import 'package:flutter/material.dart';
import 'package:practice2/provider/list_provider.dart';
import 'package:practice2/provider/secondPage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> numbers = [1,2,3,4];

  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Consumer<NumberListProvider>(
      builder: (context, numbersProviderModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            numbersProviderModel.add();
          },
          child: const Icon(Icons.add,),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Provider'),
        ),
        body: SizedBox(
            child: Column(
              children: [
                Text(numbersProviderModel.numbers.last.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: numbersProviderModel.numbers.length,
                    itemBuilder: (context, index) {
                      return Text(numbersProviderModel.numbers[index].toString(),
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SecondPage(),
                      ),
                    );
                  },
                  child: Text('Second Page'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
