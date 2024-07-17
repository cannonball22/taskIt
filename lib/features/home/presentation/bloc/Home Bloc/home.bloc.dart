import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_it/Data/Model/Member/member.model.dart';
import 'package:task_it/Data/Repositories/team.repo.dart';
import 'package:task_it/Data/Repositories/user.repo.dart';

import '../../../../../Data/Model/Project/project.model.dart';
import '../../../../../Data/Model/Task/task.model.dart';
import '../../../../../Data/Model/Team/team.model.dart';
import '../../../../../Data/Repositories/project.repo.dart';
import '../../../../../Data/Repositories/tasks.repo.dart';
import '../../../../../core/Providers/src/condition_model.dart';
import '../../../../authentication/domain/repositories/AuthService.dart';
import 'src/events.dart';
import 'src/states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadHome>(_onLoadHome);

    add(const LoadHome());
  }

  void _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    List<String?>? projectIds = [];
    List<String?>? teamMembersIds = [];

    Team? team;
    String userId = AuthService().getCurrentUserId();
    Member? member = await MemberRepo().readSingle(userId);

    if (member != null) {
      if (member.teamId != null) {
        team = await TeamRepo().readSingle(member.teamId!);
        if (team?.membersIds != null) {
          teamMembersIds.addAll(team!.membersIds!);
        }
        if (team?.projectsIds != null) {
          projectIds.addAll(team!.projectsIds!);
        }
      }
    }

    List<Project?> projects = [];
    List<Member?>? members = [];
    List<Task?>? tasks = [];
    Set<String> addedTaskIds = <String>{};

    try {
      if (projectIds.isNotEmpty) {
        for (String? projectId in projectIds) {
          if (projectId != null) {
            projects.add(await ProjectRepo().readSingle(projectId));
          }
        }
      }

      if (teamMembersIds.isNotEmpty) {
        for (String? teamMembersId in teamMembersIds) {
          if (teamMembersId != null) {
            members.add(await MemberRepo().readSingle(teamMembersId));
          }
        }
      }

      if (projects.isNotEmpty) {
        for (Project? project in projects) {
          if (project?.tasksId != null) {
            for (String? taskId in project!.tasksId!) {
              if (taskId != null) {
                Task? projectTask = await TaskRepo().readSingle(taskId);
                if (projectTask != null &&
                    !addedTaskIds.contains(projectTask.id)) {
                  tasks.add(projectTask);
                  addedTaskIds.add(projectTask.id);
                }
              }
            }
          }
        }
      }

      List<Task?>? personalTasks = await TaskRepo().readAllWhere([
        QueryCondition.equals(
            field: "assigneeId", value: AuthService().getCurrentUserId())
      ]);

      if (personalTasks != null) {
        for (Task? personalTask in personalTasks) {
          if (personalTask != null && !addedTaskIds.contains(personalTask.id)) {
            tasks.add(personalTask);
            addedTaskIds.add(personalTask.id);
          }
        }
      }

      emit(HomeLoaded(projects, members, tasks, team));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
