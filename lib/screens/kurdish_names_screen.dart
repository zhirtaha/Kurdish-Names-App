import 'package:flutter/material.dart';
import 'package:kurdish_names/models/kurdish_names_model.dart';
import 'package:kurdish_names/services/names_api_helper.dart';

class KurdishNamesList extends StatefulWidget {
  const KurdishNamesList({Key? key}) : super(key: key);

  @override
  State<KurdishNamesList> createState() => _KurdishNamesListState();
}

class _KurdishNamesListState extends State<KurdishNamesList> {
  KurdishNamesServices kurdishNamesServices = KurdishNamesServices();

  var gender = "Male";
  List genderList = ["Both", "Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kurdish Names List'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton(
                  items: genderList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {},
                  value: gender,
                ),
              ],
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder<KurdishNamesModel>(
                    future: kurdishNamesServices.getNames(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.data == null) {
                        return Text('There is No Data');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            leading: Text(snapshot
                                .data!.names[index].positive_votes
                                .toString()),
                            title: Text(snapshot.data!.names[index].name),
                            children: [Text(snapshot.data!.names[index].desc)],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
