//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../Data/Model/Shared/status.enum.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class StatusContainer extends StatelessWidget {
  //SECTION - Widget Arguments
  final Status status;

  //!SECTION
  //
  const StatusContainer({
    Key? key,
    required this.status,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Container(
      width: 24,
      height: 24,
      decoration: ShapeDecoration(
        color: status.values['color'],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    //!SECTION
  }
}
