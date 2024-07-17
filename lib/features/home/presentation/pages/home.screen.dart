//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_it/features/profile/presentation/pages/profile.screen.dart';
import 'package:task_it/features/task/presentation/pages/create_task.screen.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Project/project.model.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../presentation/widgets/project_card.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/task_card.dart';
import '../../../authentication/domain/repositories/AuthService.dart';
import '../../../project/presentation/pages/create_project.screen.dart';
import '../../../team/presentation/pages/assigned_tasks.screen.dart';
import '../../../team/presentation/pages/invite_team_member.screen.dart';
import '../bloc/Home Bloc/home.bloc.dart';
import '../bloc/Home Bloc/src/events.dart';
import '../bloc/Home Bloc/src/states.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class HomeScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;
  final bool? firstTime;

  //!SECTION
  //
  const HomeScreen({
    Key? key,
    required this.member,
    this.firstTime,
  }) : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  //SECTION - State Variables

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
    if (widget.firstTime == true) {
      context.read<HomeBloc>().add(const LoadHome());
    }
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
  // Future<List<Project?>> getAllProjects(List<String?>? projectsIds) async {
  //   List<Project?> projects = [];
  //   if (projectsIds != null && projectsIds.isNotEmpty) {
  //     for (String? projectId in projectsIds) {
  //       if (projectId != null) {
  //         projects.add(await ProjectRepo().readSingle(projectId));
  //       }
  //     }
  //   }
  //   return projects;
  // }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 24.0, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hey ${widget.member.fullName} 👋',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.43,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProfileScreen(
                          member: widget.member,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFF1EAFE),
                    radius: 16,
                    child: (widget.member.pictureURL == null)
                        ? const Icon(
                            Icons.person_outlined,
                            color: Color(0xff824AFD),
                          )
                        : ClipOval(
                            child: Image.network(
                              widget.member.pictureURL!,
                              fit: BoxFit.cover,
                              width: 72,
                              height: 72,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: context.read<HomeBloc>(),
          builder: (context, state) {
            if (state is HomeLoaded) {
              final List<Project?>? projects = state.projects;
              final List<Task?>? tasks = state.tasks;
              final List<Member?>? teamMembers = state.members;
              final List<Task?>? filteredTasks = tasks
                  ?.where((task) =>
                      task?.assigneeId == AuthService().getCurrentUserId())
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SectionTitle(
                        title: "My projects",
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute<bool>(
                                builder: (BuildContext context) =>
                                    CreateProjectScreen(
                                  member: widget.member,
                                  team: state.team,
                                  teamMembers: teamMembers,
                                ),
                              ));
                          if (result == true) {
                            context.read<HomeBloc>().add(const LoadHome());
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      (projects != null && projects.isNotEmpty)
                          ? Column(
                              children: List.generate(
                                projects.length,
                                (index) => ProjectCard(
                                  project: projects[index]!,
                                  teamMembers: teamMembers,
                                ),
                              ),
                            )
                          : const SectionPlaceholder(
                              title:
                                  'Click the “+” icon to create your first project',
                            ),
                      const SizedBox(
                        height: 40,
                      ),
                      SectionTitle(
                        title: "My tasks",
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                              builder: (BuildContext context) =>
                                  CreateTaskScreen(
                                member: widget.member,
                              ),
                            ),
                          );
                          if (result == true) {
                            context.read<HomeBloc>().add(const LoadHome());
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      (filteredTasks != null && filteredTasks.isNotEmpty)
                          ? Column(
                              children: List.generate(
                                filteredTasks.length,
                                (index) => TaskCard(
                                  task: filteredTasks[index]!,
                                ),
                              ),
                            )
                          : const SectionPlaceholder(
                              title:
                                  'Click the “+” icon to create your first task',
                            ),
                      const SizedBox(
                        height: 40,
                      ),
                      SectionTitle(
                        title: "My team",
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                              builder: (BuildContext context) =>
                                  InviteTeamMemberScreen(
                                member: widget.member,
                                team: state.team,
                              ),
                            ),
                          );
                          if (result == true) {
                            context.read<HomeBloc>().add(const LoadHome());
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      (teamMembers != null && teamMembers.isNotEmpty)
                          ? Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: List.generate(
                                teamMembers.length,
                                (index) => GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute<bool>(
                                        builder: (BuildContext context) =>
                                            AssignedTasksScreen(
                                          member: teamMembers[index]!,
                                          projectIds: state.team?.projectsIds,
                                        ),
                                      ),
                                    );
                                    if (result == true) {
                                      context
                                          .read<HomeBloc>()
                                          .add(const LoadHome());
                                    }
                                  },
                                  child: Chip(
                                    color: MaterialStateProperty.all(
                                        const Color(0xffF1EBFF)),
                                    labelStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.10,
                                    ),
                                    label: Text(teamMembers[index]!.fullName),
                                    avatar: CircleAvatar(
                                      backgroundColor: const Color(0xFFF1EAFE),
                                      radius: 16,
                                      child: (teamMembers[index]!.pictureURL ==
                                              null)
                                          ? const Icon(
                                              size: 12,
                                              Icons.person_outlined,
                                              color: Color(0xff824AFD),
                                            )
                                          : ClipOval(
                                              child: Image.network(
                                                teamMembers[index]!.pictureURL!,
                                                fit: BoxFit.cover,
                                                width: 72,
                                                height: 72,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SectionPlaceholder(
                              title:
                                  'Click the “+” icon to create your first team member.',
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
          }),
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
