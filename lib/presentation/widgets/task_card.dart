//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:task_it/features/task/presentation/pages/task_details.screen.dart';

import '../../Data/Model/Task/task.model.dart';
import '../../features/home/presentation/bloc/Home Bloc/home.bloc.dart';
import '../../features/home/presentation/bloc/Home Bloc/src/events.dart';
import './priority_container.dart';
import './status_container.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class TaskCard extends StatelessWidget {
  //SECTION - Widget Arguments
  final Task task;
  final bool? clickable;

  //!SECTION
  //
  const TaskCard({
    Key? key,
    required this.task,
    this.clickable = true,
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
        if (clickable == true) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (BuildContext context) => TaskDetailsScreen(task: task),
            ),
          );
          if (result == true) {
            context.read<HomeBloc>().add(const LoadHome());
          }
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
                  task.status != null
                      ? StatusContainer(
                          status: task.status!,
                        )
                      : Container(),
                  const SizedBox(width: 8),
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.41,
                    ),
                  ),
                ],
              ),
              task.projectName != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/arrow-right-curved.svg',
                          width: 24,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Project: ',
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.08,
                                ),
                              ),
                              TextSpan(
                                text: task.projectName,
                                style: const TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.08,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFFF1EAFE)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFF1EAFE),
                                radius: 16,
                                child: (task.assigneePictureUrl == null)
                                    ? const Icon(
                                        size: 16,
                                        Icons.person_outlined,
                                        color: Color(0xff824AFD),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          task.assigneePictureUrl!,
                                          fit: BoxFit.cover,
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                task.assigneeName ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    task.deadline != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: DateFormat('yyyy-MM-dd')
                                          .parse(task.deadline!)
                                          .isBefore(DateTime.now().subtract(
                                              const Duration(days: 1)))
                                      ? const Color(0xffFF244D)
                                      : const Color(0xFFF1EAFE),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.date_range_outlined,
                                  size: 24,
                                  color: Color(0xffC7AEFE),
                                ),
                                Text(
                                  task.deadline!,
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
                    const SizedBox(width: 8),
                    task.priority != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFF1EAFE)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: PriorityContainer(
                              priority: task.priority!,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //!SECTION
  }
}
