//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:task_it/Data/Repositories/tasks.repo.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/task_card.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class AssignedTasksScreen extends StatelessWidget {
  //SECTION - Widget Arguments
  final Member member;
  final List<String?>? projectIds;

  //!SECTION
  //
  const AssignedTasksScreen({
    Key? key,
    required this.member,
    required this.projectIds,
  }) : super(
          key: key,
        );

  Future<List<Task?>?> getAssignedTasks() async {
    List<Task?>? allTasks = await TaskRepo().readAllWhere([
      QueryCondition.equals(field: "assigneeId", value: member.id),
    ]);
    List<Task?>? filteredTasks = [];
    if (allTasks != null && allTasks.isNotEmpty && projectIds != null) {
      {
        for (Task? task in allTasks) {
          if (task?.projectId != null &&
              projectIds!.contains(task!.projectId)) {
            filteredTasks.add(task);
          }
        }
      }
    }
    return filteredTasks;
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
        title: Text(member.fullName),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAssignedTasks(),
        builder: (context, taskSnapshot) {
          if (taskSnapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: "Assigned tasks"),
                        const SizedBox(
                          height: 8,
                        ),
                        (taskSnapshot.data != null &&
                                taskSnapshot.data!.isNotEmpty)
                            ? Column(
                                children: List.generate(
                                  taskSnapshot.data!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TaskCard(
                                        task: taskSnapshot.data![index]!),
                                  ),
                                ),
                              )
                            : const SectionPlaceholder(
                                title: "There is no assigned tasks yet",
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    //!SECTION
  }
}
