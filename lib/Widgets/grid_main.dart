import 'package:flutter/material.dart';

import 'package:hck_case_management/Models/grid_model.dart';
import 'package:hck_case_management/Widgets/responsive.dart';

class GridMain extends StatelessWidget {
  final List<GridModel> rep;
  final Function onClicked;
  const GridMain({
    Key key, this.rep, this.onClicked,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Responsive(
      mobile: FileInfoCardGridView(
        crossAxisCount: _size.width < 650 ? 2 : 4,
        childAspectRatio: _size.width < 650 ? 1.4 : 1.1,
        rep: rep,
        onClicked: onClicked,
      ),
      tablet: FileInfoCardGridView( rep: rep,
        onClicked: onClicked,),
      desktop: FileInfoCardGridView(
        onClicked: onClicked,
        childAspectRatio: _size.width < 1400 ? 1.6 : 1.9,
        rep: rep,
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1, this.rep, this.onClicked,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List<GridModel> rep;
  final Function onClicked;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: rep.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: rep[index], onClicked: (){
        onClicked(index);
      },),
    );
  }
}



class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    @required this.info, this.onClicked,
  }) : super(key: key);

  final GridModel info;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius:  BorderRadius.circular(12),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        child: InkWell(
          onTap: (){onClicked();},
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          splashColor: Colors.red.withOpacity(1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,14,16,10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(info.image, height: 46,),
                  Text(info.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}