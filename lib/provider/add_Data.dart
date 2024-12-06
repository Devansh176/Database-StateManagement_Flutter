import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_map_provider.dart';

class AddData extends StatelessWidget {
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(
          onPressed: (){
            context.read<ListMapProvider>().addData({
              "name" : "Contact Name",
              "phoneNo" : "7532025525",
            });
          },
          icon: Icon(Icons.add,),
        ),
      ),
    );
  }
}
