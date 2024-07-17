//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../Data/Model/Shared/priority.enum.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class PriorityContainer extends StatelessWidget {
  //SECTION - Widget Arguments
  final Priority priority;
  final bool showText;

  //!SECTION
  //
  const PriorityContainer({
    Key? key,
    required this.priority,
    this.showText = false,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.flag,
          color: priority.values['color'],
        ),
        showText
            ? const SizedBox(
                width: 8,
              )
            : Container(),
        showText
            ? Text(
                priority.values['label'],
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.43,
                ),
              )
            : Container(),
      ],
    );
    //!SECTION
  }
}
