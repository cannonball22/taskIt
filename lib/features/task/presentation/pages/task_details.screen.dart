//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_it/features/task/data/repositories/action.items.repo.dart';

import '../../../../Data/Model/Shared/priority.enum.dart';
import '../../../../Data/Model/Shared/status.enum.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../Data/Repositories/tasks.repo.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';

import '../../../../presentation/widgets/priority_container.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/status_container.dart';
import '../../data/models/ActionItem/action.iteam.mode.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class TaskDetailsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Task task;

  //!SECTION
  //
  const TaskDetailsScreen({
    Key? key,
    required this.task,
  }) : super(
          key: key,
        );

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  //
  //SECTION - State Variables
  late Status? taskStatus;
  late Priority? taskPriority;
  bool addNewActionItem = false;
  List<ActionItem> actionItems = [];

  List<ActionItem> createdActionItems = [];

  List<TextEditingController> textControllers = [];
  List<TextEditingController> newTextControllers = [];

  late String? taskDeadline;
  bool isLoaded = false;

  // bool addNewTask = false;

  //t2 --Controllers
  // late FormController _taskFormController;
  // final _taskFormKey = GlobalKey<FormState>();
  // List<Task?> projectTasks = [];

  //t2 --Controllers
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
    taskStatus = widget.task.status;
    taskDeadline = widget.task.deadline;
    taskPriority = widget.task.priority;
    ActionItemsRepo().readAll().then((items) {
      if (items != null) {
        List<ActionItem> newActionItems = [];

        for (var actionItem in items) {
          if (actionItem != null &&
              widget.task.actionItemsIds?.contains(actionItem.id) == true) {
            newActionItems.add(actionItem);
          }
        }
        actionItems.addAll(newActionItems);
      }
      textControllers =
          List.generate(actionItems.length, (index) => TextEditingController());
      for (int i = 0; i < actionItems.length; i++) {
        textControllers[i].text = actionItems[i].title;
      }
      setState(() {});
    });

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
  updateTask() async {
    widget.task.status = taskStatus;
    widget.task.deadline = taskDeadline;
    widget.task.priority = taskPriority;

    for (ActionItem actionItem in actionItems) {
      if (actionItem.title.trim() != "") {
        await ActionItemsRepo().updateSingle(actionItem.id, actionItem);
      }
    }

    for (ActionItem createdActionItem in createdActionItems) {
      if (createdActionItem.title.trim() != "") {
        widget.task.actionItemsIds ??= [];
        widget.task.actionItemsIds?.add(createdActionItem.id);
        await ActionItemsRepo()
            .createSingle(createdActionItem, itemId: createdActionItem.id);
      }
    }
    await TaskRepo().updateSingle(widget.task.id, widget.task);

    Navigator.pop(context, true);
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Task details',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFCFCFC),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFF2F2F2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Status>(
                          value: taskStatus,
                          hint: const Text("Set status"),
                          items: const [
                            DropdownMenuItem(
                              value: Status.toDo,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StatusContainer(
                                    status: Status.toDo,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'To do',
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
                              value: Status.inProgress,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StatusContainer(
                                    status: Status.inProgress,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'In progress',
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
                              value: Status.done,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StatusContainer(
                                    status: Status.done,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Done',
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
                          onChanged: (Status? newStatus) {
                            setState(() {
                              taskStatus = newStatus!;
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
                      ),
                    ),
                  ),
                  Flexible(
                      child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFCFCFC)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFF2F2F2)),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14)),
                    ),
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        if (selectedDate.isAfter(DateTime.now())) {
                          setState(() {
                            taskDeadline =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          taskDeadline == null
                              ? 'Set Deadline'
                              : "$taskDeadline",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF828282),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.43,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFF828282),
                        )
                      ],
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCFCFC),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFF2F2F2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Priority>(
                      value: taskPriority,
                      hint: const Text("Pick priority"),
                      items: const [
                        DropdownMenuItem(
                          value: Priority.low,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PriorityContainer(
                                priority: Priority.low,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Low priority',
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
                              PriorityContainer(
                                priority: Priority.normal,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Normal priority',
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
                          value: Priority.high,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PriorityContainer(
                                priority: Priority.high,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'High priority',
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
                              PriorityContainer(
                                priority: Priority.urgent,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Urgent priority',
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
                          taskPriority = newPriority;
                        });
                      },
                      icon: const Icon(Icons.arrow_drop_down),
                      // isExpanded: true,
                      dropdownColor: const Color(0xFFFCFCFC),
                      style: const TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 16,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.43,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: "Action items",
                onPressed: () {
                  setState(() {
                    newTextControllers.add(TextEditingController());
                    createdActionItems.add(ActionItem(
                        id: IdGeneratingService.generate(), title: ""));
                  });
                },
              ),
              actionItems.isEmpty && createdActionItems.isEmpty
                  ? const SectionPlaceholder(
                      title: "Click the “+” icon to create a check list item")
                  : Column(
                      children: List.generate(actionItems.length, (index) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: actionItems[index].status,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.grey.shade400),
                                ),
                                // activeColor: const Color(0xff317F45),
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                onChanged: (bool? value) {
                                  setState(() {
                                    actionItems[index].status = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                      onChanged: (value) {
                                        actionItems[index].title =
                                            textControllers[index].text;
                                      },
                                      controller: textControllers[index],
                                      decoration: const InputDecoration(
                                        hintText: "Add action",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 16,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.41,
                                        decoration:
                                            actionItems[index].status == true &&
                                                    textControllers[index]
                                                        .text
                                                        .isNotEmpty
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
              createdActionItems.isNotEmpty
                  ? Column(
                      children:
                          List.generate(createdActionItems.length, (index) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: createdActionItems[index].status,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    createdActionItems[index].status = value;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                      onChanged: (value) {
                                        createdActionItems[index].title =
                                            newTextControllers[index].text;
                                      },
                                      controller: newTextControllers[index],
                                      decoration: const InputDecoration(
                                        hintText: "Add action",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: const Color(0xFF333333),
                                        fontSize: 16,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.41,
                                        decoration:
                                            createdActionItems[index].status ==
                                                        true &&
                                                    newTextControllers[index]
                                                        .text
                                                        .isNotEmpty
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 80, right: 80),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            updateTask();
          },
          child: const Text(
            'Update task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    for (final controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
