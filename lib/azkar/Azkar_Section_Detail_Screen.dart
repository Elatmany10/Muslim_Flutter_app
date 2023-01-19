import 'package:flutter/material.dart';
import 'package:h_quran/azkar_models/section_detail_model.dart';
import 'dart:convert';

class AzkarSectionDetailScreen extends StatefulWidget {
  final int id;
  final String title;
  const AzkarSectionDetailScreen({Key key ,  this.id ,  this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AzkarSectionDetailScreenState createState() => _AzkarSectionDetailScreenState();
}

class _AzkarSectionDetailScreenState extends State<AzkarSectionDetailScreen> {

  List<SectionDetailModel> sectionDetails = [];

  @override
  void initState() {
    super.initState();
    loadSectionDetail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0 , 3),
                    )
                  ]
                ),
                child: ListTile(
                  title: Text("${sectionDetails[index].reference}", textDirection: TextDirection.rtl,),
                  leading: Text("التكرار ${sectionDetails[index].count}"),
                  subtitle: Text("${sectionDetails[index].content}" , textDirection: TextDirection.rtl,style: TextStyle(
                    fontSize: 20
                  ),),
                ),
              );
            },
            separatorBuilder: (context , index) => Divider(height: 1,color: Colors.grey.withOpacity(.8),),
            itemCount: sectionDetails.length
        ),
      ),
    );
  }

  loadSectionDetail() async {
    sectionDetails = [];
    DefaultAssetBundle.of(context)
        .loadString("assets/database/section_details_db.json")
        .then((data) {
      var response = json.decode(data);
      response.forEach((section) {
        SectionDetailModel _sectionDetail = SectionDetailModel.fromJson(section);

        if(_sectionDetail.sectionId == widget.id) {
          sectionDetails.add(_sectionDetail);
        }

      });
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

}
