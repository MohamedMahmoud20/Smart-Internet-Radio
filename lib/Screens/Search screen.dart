import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/Data/Data.dart';

import '../Controller/Provider.dart';
import 'search.dart';

class searchsc extends StatefulWidget {

  const searchsc({Key? key}) : super(key: key);

  @override
  _searchscState createState() => _searchscState();
}

class _searchscState extends State<searchsc> {

  late List<RadioData>searchradios;
  String query= '';

  @override
  void initState() {
    super.initState();
    searchradios=homeRadios;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Buildserach(),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image:DecorationImage(image:
                NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/1fR5Y7KaK9puRmCDaIof7j/09e2b2b9eaf42d450aba695056793607/vector1.jpg?fit=fill&w=800&h=300'),
                    fit: BoxFit.cover)
            ),
          )
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
            itemBuilder: (context, index){
              final radio=searchradios[index];
              return radioStation(
                type: radio.type,
                  image: radio.imageUrl,
                  name: radio.name,
                  index: index,
                  onTap: (){
                    Provider.of<DataProvider>(context, listen: false).currentChannel(radio.id - 1);
                  },
                  height: MediaQuery.of(context).size.height);
            },
                separatorBuilder:(context,index)=>const SizedBox(height: 10,),
                itemCount: searchradios.length),
          )
        ],
      ),
    );
  }

  Widget Buildserach()=>SearchWidget(
    hintText:'enter radio name' ,
    onChanged: searchprocess,
    text:query,

  );

  void searchprocess(String query) {
    final searchradios=homeRadios.where((radiodata)
    {
      final titlelower=radiodata.name.toLowerCase();
      final typelower=radiodata.type.toLowerCase();
      final searchlower=query.toLowerCase();

      return titlelower.contains(searchlower)||typelower.contains(searchlower);

    } ).toList();

    setState(() {
      this.query=query;
      this.searchradios=searchradios;

    });

  }


}
