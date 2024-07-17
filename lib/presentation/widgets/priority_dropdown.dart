//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../Data/Model/Shared/priority.enum.dart';
import './priority_container.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class PriorityDropdown extends StatefulWidget {
  //SECTION - Widget Arguments
  final Priority? initialPriority;
  final ValueChanged<Priority?>? onChanged;

  //!SECTION
  //
  const PriorityDropdown({
    Key? key,
    this.initialPriority,
    this.onChanged,
  }) : super(
          key: key,
        );

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  Priority? taskPriority;

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    taskPriority = widget.initialPriority;
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --State
    //t2 --State
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

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
    return DropdownButtonHideUnderline(
      child: DropdownButton<Priority>(
        value: taskPriority,
        hint: const Text("Pick priority"),
        items: const [
          DropdownMenuItem(
            value: Priority.low,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PriorityContainer(priority: Priority.low),
                SizedBox(width: 8),
                Text(
                  'Low',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: Priority.normal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PriorityContainer(priority: Priority.normal),
                SizedBox(width: 8),
                Text(
                  'Normal  Priority',
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: Priority.high,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PriorityContainer(priority: Priority.high),
                SizedBox(width: 8),
                Text(
                  'High Priority',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: Priority.urgent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PriorityContainer(priority: Priority.urgent),
                SizedBox(width: 8),
                Text(
                  'Urgent',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
              ],
            ),
          ),
        ],
        onChanged: (Priority? newPriority) {
          setState(() {
            taskPriority = newPriority!;
            if (widget.onChanged != null) {
              widget.onChanged!(newPriority);
            }
          });
        },
        icon: const Icon(Icons.arrow_drop_down),
        dropdownColor: const Color(0xFFFCFCFC),
        style: const TextStyle(
          color: Color(0xFF828282),
          fontSize: 16,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.43,
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
