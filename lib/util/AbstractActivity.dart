import 'package:flutter/material.dart';

import '../util/References.dart';

class AbstractActivityDescriptor {

  final String activityName;
  final String iconImageURL;
  final StatefulWidget resultingPage;

  const AbstractActivityDescriptor({
    this.activityName,
    this.iconImageURL,
    this.resultingPage
  });
}

class AbstractActivity extends StatelessWidget {

  static final TextStyle activityNameTextStyle = TextStyle(
      fontSize: 18,
      color: SECONDARY_COLOR
  );
  static final double iconSize = 175.0;

  final bool isFirstRow;
  final String activityName;
  final String iconImageURL;
  final StatefulWidget resultingPage;

  const AbstractActivity({
    this.isFirstRow,
    this.activityName,
    this.iconImageURL,
    this.resultingPage
  });

  AbstractActivity.fromDescriptor(
      AbstractActivityDescriptor descriptor, bool isFirstRow) : this(
      isFirstRow: isFirstRow,
      activityName: descriptor.activityName,
      iconImageURL: descriptor.iconImageURL,
      resultingPage: descriptor.resultingPage
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
              return resultingPage;
            })
        ),
        child: Column(
            children: <Widget> [
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      20.0,
                      this.isFirstRow ? 0.0 : 20.0,
                      20.0,
                      0.0
                  ),
                  child: SizedBox(
                    child: Image.asset(
                      this.iconImageURL,
                      fit: BoxFit.contain,
                    ),
                    height: iconSize,
                    width: iconSize,
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                      this.activityName,
                      style: activityNameTextStyle,
                      overflow: TextOverflow.ellipsis
                  )
              )
            ]
        )
    );
  }

  static Table generateTable(
      List<AbstractActivityDescriptor> descriptors) {
    List<TableRow> tableContents = List<TableRow>();
    int i = 0;

    for (AbstractActivityDescriptor descriptor in descriptors) {
      if (i % 2 == 0) {
        tableContents.add(TableRow(children: List<Widget>()));
      }

      tableContents.last.children.add(
          AbstractActivity.fromDescriptor(descriptor, i < 2)
      );

      i++;
    }

    if (i % 2 == 1) {
      tableContents.last.children.add(
          SizedBox(width: iconSize, height: iconSize)
      );
    }

    return Table(children: tableContents);
  }
}