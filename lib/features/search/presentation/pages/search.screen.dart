//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:task_it/Data/Repositories/project.repo.dart';
import 'package:task_it/Data/Repositories/team.repo.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Project/project.model.dart';
import '../../../../Data/Model/Task/task.model.dart';
import '../../../../Data/Repositories/tasks.repo.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/project_card.dart';
import '../../../../presentation/widgets/section_placeholder.dart';
import '../../../../presentation/widgets/section_title.dart';
import '../../../../presentation/widgets/task_card.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class SearchScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;

  //!SECTION
  //
  const SearchScreen({
    Key? key,
    required this.member,
  }) : super(
          key: key,
        );

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //
  //SECTION - State Variables
  List<Project?>? searchedProjects = [];
  List<Task?>? searchedTasks = [];
  List<Member?>? searchedTeamMembers = [];
  bool showResult = false;
  List<String?> projectIds = [];
  List<String?> memberIds = [];
  bool loading = false;

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
    TeamRepo().readSingle(widget.member.teamId!).then((team) {
      setState(() {
        if (team != null && team.projectsIds != null) {
          projectIds = team.projectsIds ?? [];
          memberIds = team.membersIds ?? [];
        }
      });
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
  Future<List<Project?>?> searchProjects(String value) async {
    List<Project?>? allProjects = await ProjectRepo()
        .readAllWhere([QueryCondition.equals(field: "title", value: value)]);

    if (allProjects == null) {
      return null;
    }

    List<Project?>? filteredProjects = allProjects
        .where((project) => project != null && projectIds.contains(project.id))
        .toList();

    return filteredProjects;
  }

  Future<List<Task?>?> searchTasks(String value) async {
    List<Task?>? allTasks = await TaskRepo()
        .readAllWhere([QueryCondition.equals(field: "title", value: value)]);

    if (allTasks == null) {
      return null;
    }

    List<Task?>? filteredTasks = allTasks
        .where((task) => task != null && projectIds.contains(task.projectId))
        .toList();

    return filteredTasks;
  }

  Future<List<Member?>?> searchTeamMembers(String value) async {
    List<Member?>? allTeamMembers = await MemberRepo()
        .readAllWhere([QueryCondition.equals(field: "fullName", value: value)]);

    if (allTeamMembers == null) {
      return null;
    }

    List<Member?>? filteredMembers = allTeamMembers
        .where((member) => member != null && memberIds.contains(member.id))
        .toList();

    return filteredMembers;
  }

  //!SECTION
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
        leading: null,
        title: const Text(
          "Search",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "Search for a task or a project",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a search keyword';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Icons.search),
                      onFieldSubmitted: (value) async {
                        setState(() {
                          showResult = true;
                          loading = true;
                        });
                        searchedProjects = await searchProjects(value);
                        searchedTasks = await searchTasks(value);
                        searchedTeamMembers = await searchTeamMembers(value);
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     prefixIcon: Icon(Icons.search),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    showResult
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Column(
                                children: [
                                  const SectionTitle(
                                    title: "Projects",
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  (searchedProjects == null ||
                                          searchedProjects!.isEmpty)
                                      ? const SectionPlaceholder(
                                          title: "No results")
                                      : Column(
                                          children: List.generate(
                                              searchedProjects!.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ProjectCard(
                                                      project:
                                                          searchedProjects![
                                                              index]!,
                                                      teamMembers:
                                                          searchedTeamMembers,
                                                    ),
                                                  )),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Column(
                                children: [
                                  const SectionTitle(
                                    title: "Tasks",
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  (searchedTasks == null ||
                                          searchedTasks!.isEmpty)
                                      ? const SectionPlaceholder(
                                          title: "No results")
                                      : Column(
                                          children: List.generate(
                                              searchedTasks!.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TaskCard(
                                                        task: searchedTasks![
                                                            index]!),
                                                  )),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Column(
                                children: [
                                  const SectionTitle(
                                    title: "My team",
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  (searchedTeamMembers == null ||
                                          searchedTeamMembers!.isEmpty)
                                      ? const SectionPlaceholder(
                                          title: "No results")
                                      : Wrap(
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          children: List.generate(
                                            searchedTeamMembers!.length,
                                            (index) => GestureDetector(
                                              child: Chip(
                                                labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.10,
                                                ),
                                                label: Text(
                                                    searchedTeamMembers![index]!
                                                        .fullName),
                                                avatar: CircleAvatar(
                                                  backgroundColor:
                                                      const Color(0xFFF1EAFE),
                                                  radius: 24,
                                                  child: (widget.member
                                                              .pictureURL ==
                                                          null)
                                                      ? const Icon(
                                                          Icons.person_outlined,
                                                          color:
                                                              Color(0xff824AFD),
                                                        )
                                                      : ClipOval(
                                                          child: Image.network(
                                                            widget.member
                                                                .pictureURL!,
                                                            fit: BoxFit.cover,
                                                            width: 24,
                                                            height: 24,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                  ],
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
    super.dispose();
  }
}
