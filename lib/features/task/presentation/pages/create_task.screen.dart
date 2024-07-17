//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';
import 'package:task_it/Data/Model/Member/member.model.dart';
import 'package:task_it/Data/Model/Task/task.model.dart';
import 'package:task_it/features/task/data/repositories/action.items.repo.dart';

import '../../../../Data/Model/Shared/priority.enum.dart';
import '../../../../Data/Model/Shared/status.enum.dart';
import '../../../../Data/Repositories/tasks.repo.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/priority_container.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/status_container.dart';
import '../../../authentication/domain/repositories/AuthService.dart';
import '../../data/models/ActionItem/action.iteam.mode.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class CreateTaskScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;

  //!SECTION
  //
  const CreateTaskScreen({
    Key? key,
    required this.member,
  }) : super(
          key: key,
        );

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  //
  //SECTION - State Variables
  Status? status;
  Priority? priority;
  String? deadline;
  bool addNewActionItem = false;
  List<ActionItem> actionItems = [];

  //t2 --Controllers
  late FormController _formController;
  List<TextEditingController> textControllers = [];

  final _formKey = GlobalKey<FormState>();

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
    _formController = FormController();
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
  createPersonalTask({required String title}) async {
    actionItems.removeWhere(
        (actionItem) => actionItem.title.isEmpty || actionItem.title == "");

    List<String> actionItemsIds = actionItems.map((item) => item.id).toList();

    await ActionItemsRepo().createMultible(actionItems, ids: actionItemsIds);

    String taskId = IdGeneratingService.generate();

    await TaskRepo().createSingle(
      Task(
        id: taskId,
        title: title,
        priority: priority,
        assigneeId: AuthService().getCurrentUserId(),
        deadline: deadline,
        status: status,
        assigneeName: widget.member.fullName,
        assigneePictureUrl: widget.member.pictureURL,
        actionItemsIds: actionItemsIds,
      ),
      itemId: taskId,
    );
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
        title: const Text("New Task"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.48,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: _formController.controller("title"),
                  hintText: "Add title*",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
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
                    child: DropdownButton<Status>(
                      value: status,
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
                          status = newStatus;
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
                const SizedBox(
                  height: 16,
                ),
                Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFF2F2F2),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFF1EAFE),
                              radius: 12,
                              child: (widget.member.pictureURL == null)
                                  ? const Icon(
                                      Icons.person_outlined,
                                      color: Color(0xff824AFD),
                                      size: 16,
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                        widget.member.pictureURL!,
                                        fit: BoxFit.cover,
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              width: 6.5,
                            ),
                            Text(
                              widget.member.fullName,
                              style: const TextStyle(
                                color: Color(0xFF828282),
                                fontSize: 16,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 0.09,
                                letterSpacing: -0.43,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              '(me)',
                              style: TextStyle(
                                color: Color(0xFF828282),
                                fontSize: 16,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 0.09,
                                letterSpacing: -0.43,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                Container(
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
                      value: priority,
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
                          priority = newPriority;
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
                const SizedBox(
                  height: 16,
                ),
                TextButton(
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
                      setState(() {
                        deadline =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deadline == null ? 'Set Deadline' : deadline!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF828282),
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.43,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFF828282),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionTitle(
                  title: "Action items",
                  onPressed: () {
                    setState(() {
                      addNewActionItem = true;
                      textControllers.add(TextEditingController());
                      actionItems.add(ActionItem(
                          id: IdGeneratingService.generate(), title: ""));
                    });
                  },
                ),
                actionItems.isEmpty
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
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      actionItems[index].status = value;
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
                                              actionItems[index].status ==
                                                          true &&
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
              ],
            ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              await createPersonalTask(
                title: _formController.controller("title").text.trim(),
              );
            }
          },
          child: const Text(
            'Create task',
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
    for (var controller in textControllers) {
      controller.dispose();
    }

    //!SECTION
    super.dispose();
  }
}
