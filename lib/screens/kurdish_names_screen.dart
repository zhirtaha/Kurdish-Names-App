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

  String? gender;
  String g = "M";
  List genderList = ["Both", "Male", "Female"];
  String? limit;
  String lim = "10";
  List limitList = ["10", "20", "30", "40"];
  String? sort;
  String s = "positive";
  List sortList = ["positive", "negative"];
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  hint: Text('Gender'),
                  value: gender,
                  items: genderList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      if (gender == "Male") {
                        g = "M";
                      } else if (gender == "Female") {
                        g = "F";
                      } else {
                        g = "O";
                      }
                    });
                  },
                ),
                DropdownButton(
                  hint: Text('Limit'),
                  value: limit,
                  items: limitList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      limit = value.toString();
                      if (limit == "10") {
                        lim = "10";
                      } else if (limit == "20") {
                        lim = "20";
                      } else if (limit == "30") {
                        lim = "30";
                      } else if (limit == "40") {
                        lim = "40";
                      }
                    });
                  },
                ),
                DropdownButton(
                  hint: Text('Sort By'),
                  value: sort,
                  items: sortList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      sort = value.toString();
                      if (sort == "positive") {
                        s = "positive";
                      } else if (sort == "negative") {
                        s = "negative";
                      }
                    });
                  },
                )
              ],
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder<KurdishNamesModel>(
                    future: kurdishNamesServices.getNames(
                        gender: g, limit: lim, sort: s),
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
                          Name name = snapshot.data!.names[index];
                          return ExpansionTile(
                            leading: Text(name.nameId.toString().toString()),
                            title: Text(name.name),
                            children: [Text(name.desc)],
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
