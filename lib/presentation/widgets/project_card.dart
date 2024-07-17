//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Data/Model/Member/member.model.dart';
import '../../Data/Model/Project/project.model.dart';
import '../../features/home/presentation/bloc/Home Bloc/home.bloc.dart';
import '../../features/home/presentation/bloc/Home Bloc/src/events.dart';
import '../../features/project/presentation/pages/project_details.screen.dart';
import './status_container.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class ProjectCard extends StatelessWidget {
  //SECTION - Widget Arguments
  final Project project;
  final List<Member?>? teamMembers;

  //!SECTION
  //
  const ProjectCard({
    Key? key,
    required this.project,
    required this.teamMembers,
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
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProjectDetailsScreen(
              project: project,
              teamMembers: teamMembers,
            ),
          ),
        );

        if (result == true) {
          context.read<HomeBloc>().add(const LoadHome());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusContainer(
                    status: project.status,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.41,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  //   decoration: ShapeDecoration(
                  //     shape: RoundedRectangleBorder(
                  //       side: const BorderSide(color: Color(0xFFF1EAFE)),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: List.generate(3, (index) {
                  //       return const Align(
                  //         widthFactor: 0.7,
                  //         child: CircleAvatar(
                  //           radius: 12,
                  //           backgroundImage:
                  //               AssetImage('assets/images/avatar.png'),
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  project.deadline != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: DateFormat('yyyy-MM-dd')
                                        .parse(project.deadline!)
                                        .isBefore(DateTime.now()
                                            .subtract(const Duration(days: 1)))
                                    ? Color(0xffFF244D)
                                    : const Color(0xFFF1EAFE),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 24,
                                color: Color(0xffC7AEFE),
                              ),
                              Text(
                                project.deadline!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.43,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    //!SECTION
  }
}
