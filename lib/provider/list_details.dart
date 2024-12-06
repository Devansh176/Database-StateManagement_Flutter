import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice2/provider/add_Data.dart';
import 'package:practice2/provider/list_map_provider.dart';
import 'package:provider/provider.dart';

class ListDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List',),
        centerTitle: true,
      ),
      body: Consumer<ListMapProvider>(
        builder: (ctx, provider, __){
          var allData = provider.getData();
          return allData.isNotEmpty ? ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index){
              return ListTile(
                title: Text('${allData[index]['name']}'),
                subtitle: Text('${allData[index]['phoneNo']}'),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<ListMapProvider>().updateData({
                            "name" : "New contact Name",
                            "phoneNo" : "9345892154",
                          }, index);
                        },
                        icon: Icon(Icons.edit,),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ListMapProvider>().deleteData(index);
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ) : Center(child: Text("No Contacts Yet !!"),);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddData(),
            ),
          );
        },
        child: Icon(Icons.navigate_next,),
      ),
    );
  }
}