//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';
import 'package:task_it/Data/Model/Member/member.model.dart';
import 'package:task_it/Data/Model/Team/team.model.dart';
import 'package:task_it/Data/Repositories/tasks.repo.dart';
import 'package:task_it/Data/Repositories/team.repo.dart';
import 'package:task_it/Data/Repositories/user.repo.dart';

import '../../../../Data/Model/Project/project.model.dart';
import '../../../../Data/Model/Shared/priority.enum.dart';
import '../../../../Data/Model/Shared/status.enum.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../Data/Repositories/project.repo.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../presentation/utils/SnackBar/snackbar.helper.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/priority_container.dart';
import '../../../../presentation/widgets/secondary_button.dart';
import '../../../../presentation/widgets/status_container.dart';
import '../../../../presentation/widgets/task_card.dart';
import '../../../../presentation/widgets/tertiary_button.dart';
import '../../../authentication/domain/repositories/AuthService.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class CreateProjectScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;
  final Team? team;
  final List<Member?>? teamMembers;

  //!SECTION
  //
  const CreateProjectScreen({
    Key? key,
    required this.member,
    required this.team,
    required this.teamMembers,
  }) : super(
          key: key,
        );

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  //
  //SECTION - State Variables
  Status projectStatus = Status.toDo;
  String? projectDeadline;

  bool addNewTask = false;
  Status? taskStatus;
  String? taskDeadline;
  Priority? taskPriority;
  String? taskAssigneeId;
  List<String> assigneePictureUrl = [];

  List<Task> createdTasks = [];

  //t2 --Controllers
  late FormController _projectFormController;
  late FormController _taskFormController;
  final _projectFormKey = GlobalKey<FormState>();
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
    _projectFormController = FormController();
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
  String projectId = IdGeneratingService.generate();

  //!SECTION
  createProject({
    required String title,
    required String description,
  }) async {
    List<String> taskIds = createdTasks.map((task) => task.id).toList();
    await ProjectRepo().createSingle(
      Project(
        id: projectId,
        projectOwnerId: AuthService().getCurrentUserId(),
        title: title,
        status: projectStatus,
        tasksId: taskIds,
        description: description,
        deadline: projectDeadline,
      ),
      itemId: projectId,
    );

    if (widget.member.teamId == null) {
      String teamId = IdGeneratingService.generate();

      widget.member.teamId = teamId;
      await MemberRepo().updateSingle(widget.member.id, widget.member);

      await TeamRepo().createSingle(
          Team(
            id: teamId,
            teamOwnerId: widget.member.id,
            projectsIds: [projectId],
          ),
          itemId: teamId);
    } else {
      widget.team?.projectsIds ??= [];
      widget.team?.projectsIds?.add(projectId);

      await TeamRepo().updateSingle(widget.member.teamId!, widget.team!);
    }

    for (Task task in createdTasks) {
      task.projectName = title;
    }
    await TaskRepo().createMultible(createdTasks, ids: taskIds);

    Navigator.pop(context, true);
  }

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
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text("New project"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _projectFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project details',
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
                  controller: _projectFormController.controller("title"),
                  hintText: "Add title*",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
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
                            value: projectStatus,
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
                                projectStatus = newStatus!;
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFCFCFC)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                        ),
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
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
                            projectDeadline =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            projectDeadline == null
                                ? 'Set Deadline'
                                : "$projectDeadline",
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
                CustomTextFormField(
                  controller: _projectFormController.controller("description"),
                  hintText: "Project description",
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Project tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.48,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            addNewTask = !addNewTask;
                          });
                          // Navigator.pushNamed(context, "/createProjectScreen");
                        },
                        icon: Icon(
                          Icons.add,
                          size: 24,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                addNewTask
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
                                      controller: _taskFormController
                                          .controller("title"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFCFCFC),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFF2F2F2),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        StatusContainer(
                                                          status: Status.toDo,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          'To do',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'SF Pro Text',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing:
                                                                -0.43,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: Status.inProgress,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        StatusContainer(
                                                          status:
                                                              Status.inProgress,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          'In progress',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF828282),
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'SF Pro Text',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing:
                                                                -0.43,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: Status.done,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        StatusContainer(
                                                          status: Status.done,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          'Done',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'SF Pro Text',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing:
                                                                -0.43,
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
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                // isExpanded: true,
                                                dropdownColor:
                                                    const Color(0xFFFCFCFC),
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
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color(0xFFFCFCFC)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                side: const BorderSide(
                                                    color: Color(0xFFF2F2F2)),
                                              ),
                                            ),
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsetsGeometry>(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 14)),
                                          ),
                                          onPressed: () async {
                                            DateTime? selectedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101),
                                            );
                                            if (selectedDate != null) {
                                              setState(() {
                                                taskDeadline =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(selectedDate);
                                              });
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFCFCFC),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFF2F2F2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                          value: taskAssigneeId,
                                          items: widget.teamMembers
                                              ?.map((member) =>
                                                  DropdownMenuItem<String>(
                                                    value: member?.id,
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFF1EAFE),
                                                          radius: 12,
                                                          child: (widget.member
                                                                      .pictureURL ==
                                                                  null)
                                                              ? const Icon(
                                                                  Icons
                                                                      .person_outlined,
                                                                  size: 16,
                                                                  color: Color(
                                                                      0xff824AFD),
                                                                )
                                                              : ClipOval(
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .member
                                                                        .pictureURL!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 24,
                                                                    height: 24,
                                                                  ),
                                                                ),
                                                        ),
                                                        const SizedBox(
                                                            width: 6.5),
                                                        Text(
                                                          member?.fullName ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF828282),
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'SF Pro Text',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing:
                                                                -0.43,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          dropdownColor:
                                              const Color(0xFFFCFCFC),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFCFCFC),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFF2F2F2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    PriorityContainer(
                                                      priority: Priority.low,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Low',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'SF Pro Text',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.43,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: Priority.normal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    PriorityContainer(
                                                      priority: Priority.normal,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Normal  Priority',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF828282),
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'SF Pro Text',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.43,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: Priority.high,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    PriorityContainer(
                                                      priority: Priority.high,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'High Priority',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'SF Pro Text',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.43,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: Priority.urgent,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    PriorityContainer(
                                                      priority: Priority.urgent,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Urgent',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'SF Pro Text',
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            // isExpanded: true,
                                            dropdownColor:
                                                const Color(0xFFFCFCFC),
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
                                          title: "Cancel",
                                          onPressed: () {
                                            addNewTask = false;
                                            setState(() {});
                                          },
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        SecondaryButton(
                                          title: "Create task",
                                          onPressed: () {
                                            if (taskAssigneeId == null) {
                                              SnackbarHelper.showTemplated(
                                                  context,
                                                  title:
                                                      "Assign task to a team member",
                                                  style:
                                                      const FlutterSnackBarStyle(
                                                    backgroundColor:
                                                        Color(0xffFF244D),
                                                    titleStyle: TextStyle(
                                                        color: Colors.white),
                                                  ));
                                            }
                                            if (_taskFormKey.currentState!
                                                    .validate() &&
                                                taskAssigneeId != null) {
                                              String newTaskId =
                                                  IdGeneratingService
                                                      .generate();
                                              Task newTask;
                                              if (widget.teamMembers != null ||
                                                  widget.teamMembers!
                                                      .isNotEmpty) {
                                                newTask = Task(
                                                  id: newTaskId,
                                                  title: _taskFormController
                                                      .controller("title")
                                                      .text,
                                                  status: taskStatus,
                                                  deadline: taskDeadline,
                                                  priority: taskPriority,
                                                  projectId: projectId,
                                                  assigneeId: taskAssigneeId,
                                                  assigneeName: widget
                                                      .teamMembers
                                                      ?.firstWhere((e) =>
                                                          e?.id ==
                                                          taskAssigneeId)
                                                      ?.fullName,
                                                  assigneePictureUrl: widget
                                                      .teamMembers
                                                      ?.firstWhere((e) =>
                                                          e?.id ==
                                                          taskAssigneeId)
                                                      ?.pictureURL,
                                                );
                                              } else {
                                                newTask = Task(
                                                  id: newTaskId,
                                                  title: _taskFormController
                                                      .controller("title")
                                                      .text,
                                                  status: taskStatus,
                                                  deadline: taskDeadline,
                                                  priority: taskPriority,
                                                  projectId: projectId,
                                                  assigneeId: taskAssigneeId,
                                                  assigneeName: widget
                                                      .teamMembers
                                                      ?.firstWhere((e) =>
                                                          e?.id ==
                                                          taskAssigneeId)
                                                      ?.fullName,
                                                  assigneePictureUrl: widget
                                                      .teamMembers
                                                      ?.firstWhere((e) =>
                                                          e?.id ==
                                                          taskAssigneeId)
                                                      ?.pictureURL,
                                                );
                                              }
                                              createdTasks.add(newTask);
                                              // assigneePictureUrl.add(widget
                                              //     .teamMembers
                                              //     ?.firstWhere((e) =>
                                              // e?.id == taskAssigneeId)
                                              //     !.pictureURL?? "");

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
                    : Container(),
                (createdTasks.isEmpty)
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2, color: Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Click the “+” icon to create a task',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.24,
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(
                          createdTasks.length,
                          (index) => TaskCard(
                            task: createdTasks[index],
                            clickable: false,
                          ),
                        ),
                      )
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
          onPressed: () {
            if (_projectFormKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              createProject(
                title: _projectFormController.controller("title").text.trim(),
                description:
                    _projectFormController.controller("description").text,
              );
            }
          },
          child: const Text(
            'Create project',
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
    _projectFormController.dispose();
    //!SECTION
    super.dispose();
  }
}
