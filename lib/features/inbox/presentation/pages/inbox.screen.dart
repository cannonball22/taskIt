//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_it/Data/Repositories/tasks.repo.dart';
import 'package:task_it/Data/Repositories/team.repo.dart';

import '../../../../Data/Model/Shared/status.enum.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/task_card.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class InboxScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  final String? teamId;

  const InboxScreen({
    Key? key,
    required this.teamId,
  }) : super(
          key: key,
        );

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  List<Task?>? allTasks = [];
  List<Task?>? doneTasks = [];
  List<Task?>? overdueTasks = [];
  bool isLoaded = false;
  Future<List<Task?>?>? _taskFuture;

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
    doneTasks?.clear();
    overdueTasks?.clear();
    allTasks?.clear();
    _taskFuture = fetchTasks();

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
  Future<List<Task?>?> fetchTasks() async {
    doneTasks?.clear();
    overdueTasks?.clear();
    allTasks?.clear();

    if (widget.teamId != null) {
      await TeamRepo().readSingle(widget.teamId!).then((team) async {
        if (team != null) {
          Set<String?> uniqueProjectIds =
              Set<String?>.from(team.projectsIds ?? []);

          for (String? projectId in uniqueProjectIds) {
            if (projectId != null) {
              List<Task?>? newTasks = await TaskRepo().readAllWhere(
                [QueryCondition.equals(field: "projectId", value: projectId)],
              );
              if (newTasks != null) {
                for (Task? task in newTasks) {
                  allTasks?.add(task);
                }
              }
            }
          }
        }
      });
    }
    return allTasks;
  }

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
          leading: null,
          title: const Text(
            "Inbox",
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _taskFuture,
            builder: (context, allTaskSnapshot) {
              if (allTaskSnapshot.connectionState == ConnectionState.done) {
                if (allTaskSnapshot.data != null) {
                  DateTime now = DateTime.now();

                  doneTasks?.addAll(allTaskSnapshot.data!
                      .where((task) => task?.status == Status.done));

                  overdueTasks?.addAll(allTaskSnapshot.data!.where((task) {
                    if (task?.deadline != null) {
                      DateTime taskDeadline =
                          DateFormat('yyyy-MM-dd').parse(task!.deadline!);
                      return taskDeadline.isBefore(now);
                    }
                    return false;
                  }));
                }
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ((doneTasks!.isEmpty) && (overdueTasks!.isEmpty))
                            ? const SectionPlaceholder(
                                title: "You are up to speed. Whoorayyy!")
                            : Column(
                                children: [
                                  Column(
                                    children: [
                                      const SectionTitle(
                                        title: "Overdue",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      (overdueTasks == null ||
                                              overdueTasks!.isEmpty)
                                          ? const SectionPlaceholder(
                                              title: "No results")
                                          : Column(
                                              children: List.generate(
                                                  overdueTasks!.length,
                                                  (index) => TaskCard(
                                                      task: overdueTasks![
                                                          index]!)),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Column(
                                    children: [
                                      const SectionTitle(
                                        title: "Done",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      (doneTasks == null || doneTasks!.isEmpty)
                                          ? const SectionPlaceholder(
                                              title: "No results")
                                          : Column(
                                              children: List.generate(
                                                  doneTasks!.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TaskCard(
                                                            task: doneTasks![
                                                                index]!),
                                                      )),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    doneTasks?.clear();
    overdueTasks?.clear();
    allTasks?.clear();
    super.dispose();
  }
}
