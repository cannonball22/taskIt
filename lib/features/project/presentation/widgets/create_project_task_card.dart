//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Shared/priority.enum.dart';
import '../../../../Data/Model/Shared/status.enum.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/priority_container.dart';
import '../../../../presentation/widgets/secondary_button.dart';
import '../../../../presentation/widgets/status_container.dart';
import '../../../../presentation/widgets/tertiary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class CreateProjectTaskCard extends StatefulWidget {
  //SECTION - Widget Arguments
  final List<Member?>? teamMembers;
  final String projectId;
  final Member member;
  final List<Task> createdTasks;

  //!SECTION
  //
  const CreateProjectTaskCard({
    Key? key,
    this.teamMembers,
    required this.projectId,
    required this.member,
    required this.createdTasks,
  }) : super(
          key: key,
        );

  @override
  State<CreateProjectTaskCard> createState() => _CreateProjectTaskCardState();
}

class _CreateProjectTaskCardState extends State<CreateProjectTaskCard> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  Status? taskStatus;
  String? taskDeadline;
  Priority? taskPriority;
  String? taskAssigneeId;
  List<String> assigneePictureUrl = [];
  bool addNewTask = false;

  late FormController _taskFormController;

  final _taskFormKey = GlobalKey<FormState>();

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
    _taskFormController = FormController();
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
  resetCreateTask() {
    addNewTask = false;
    _taskFormController.controller("title").clear();
    taskDeadline = null;
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
    return addNewTask
        ? Form(
            key: _taskFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFCFCFC),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFF2F2F2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          controller: _taskFormController.controller("title"),
                          hintText: "Add task title*",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a task title';
                            }
                            return null;
                          },
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                            Flexible(
                                child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFFCFCFC)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Color(0xFFF2F2F2)),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
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
                                      taskDeadline = DateFormat('yyyy-MM-dd')
                                          .format(selectedDate);
                                    });
                                  } else {
                                    // alert Dialog
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    (taskDeadline == null)
                                        ? 'Set Deadline'
                                        : taskDeadline!,
                                    style: const TextStyle(
                                      color: Color(0xff828282),
                                      fontSize: 16,
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
                                    color: Color(0xff828282),
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
                                child: DropdownButton<String>(
                              value: taskAssigneeId,
                              items: widget.teamMembers
                                  ?.map((member) => DropdownMenuItem<String>(
                                        value: member?.id,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xFFF1EAFE),
                                              radius: 12,
                                              child: (widget
                                                          .member.pictureURL ==
                                                      null)
                                                  ? const Icon(
                                                      Icons.person_outlined,
                                                      size: 16,
                                                      color: Color(0xff824AFD),
                                                    )
                                                  : ClipOval(
                                                      child: Image.network(
                                                        widget
                                                            .member.pictureURL!,
                                                        fit: BoxFit.cover,
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                            ),
                                            const SizedBox(width: 6.5),
                                            Text(
                                              member?.fullName ?? "",
                                              style: const TextStyle(
                                                color: Color(0xFF828282),
                                                fontSize: 16,
                                                fontFamily: 'SF Pro Text',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.43,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              icon: const Icon(Icons.arrow_drop_down),
                              dropdownColor: const Color(0xFFFCFCFC),
                              style: const TextStyle(
                                color: Color(0xFF828282),
                                fontSize: 16,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.43,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  taskAssigneeId = value;
                                });
                              },
                            )),
                          ),
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
                                        PriorityContainer(
                                          priority: Priority.normal,
                                        ),
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
                                        PriorityContainer(
                                          priority: Priority.high,
                                        ),
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
                                        PriorityContainer(
                                          priority: Priority.urgent,
                                        ),
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
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TertiaryButton(
                              title: 'Cancel',
                              onPressed: () {
                                addNewTask = false;
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            SecondaryButton(
                              title: 'Create task',
                              onPressed: () {
                                if (_taskFormKey.currentState!.validate()) {
                                  String newTaskId =
                                      IdGeneratingService.generate();
                                  Task newTask = Task(
                                    id: newTaskId,
                                    title: _taskFormController
                                        .controller("title")
                                        .text,
                                    status: taskStatus,
                                    deadline: taskDeadline,
                                    priority: taskPriority,
                                    projectId: widget.projectId,
                                    assigneeId: taskAssigneeId,
                                    assigneeName: widget.teamMembers
                                        ?.firstWhere(
                                            (e) => e?.id == taskAssigneeId)
                                        ?.fullName,
                                    assigneePictureUrl: widget.teamMembers
                                        ?.firstWhere(
                                            (e) => e?.id == taskAssigneeId)
                                        ?.pictureURL,
                                  );
                                  widget.createdTasks.add(newTask);

                                  resetCreateTask();

                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    _taskFormController.dispose();
    //!SECTION
    super.dispose();
  }
}
