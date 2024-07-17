//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../../Data/Model/Team/team.model.dart';
import '../../../../Data/Repositories/team.repo.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../presentation/utils/SnackBar/snackbar.helper.dart';
import '../../../../presentation/widgets/custom_text_form_field.dart';
import '../../../../presentation/widgets/primary_button.dart';
import '../../../../presentation/widgets/secondary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class InviteTeamMemberScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Member member;
  final Team? team;

  //!SECTION
  //
  const InviteTeamMemberScreen({
    Key? key,
    required this.member,
    required this.team,
  }) : super(
          key: key,
        );

  @override
  State<InviteTeamMemberScreen> createState() => _InviteTeamMemberScreenState();
}

class _InviteTeamMemberScreenState extends State<InviteTeamMemberScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  String teamId = IdGeneratingService.generate();

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
  void _showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCFCFC),
          title: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Color(0xff317F45)),
              SizedBox(width: 8),
              Expanded(child: Text('This user has been invited successfully!')),
            ],
          ),
          content: const Text(
            'They will become available in the app once they accept the invitation and set up their account.',
            style: TextStyle(
              color: Color(0xFF828282),
              fontSize: 16,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.43,
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: 'Invite someone new',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                title: "Go home",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        );
      },
    );
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
        title: const Text("Invite team member"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal details',
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
              controller: _formController.controller("email"),
              hintText: "Email*",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              List<Member?>? members = await MemberRepo().readAllWhere([
                QueryCondition.equals(
                    field: "email",
                    value: _formController.controller("email").text.trim())
              ]);

              if (members != null && members.isNotEmpty) {
                _showInviteDialog(context);

                Member? newMember = members.first;
                if (widget.member.teamId == null) {
                  widget.member.teamId = teamId;
                  newMember?.teamId = widget.member.teamId;

                  await MemberRepo()
                      .updateSingle(widget.member.id, widget.member);
                  await MemberRepo().updateSingle(newMember!.id, newMember);
                  Team newTeam = Team(
                      id: teamId,
                      teamOwnerId: widget.member.id,
                      membersIds: [widget.member.id, newMember.id]);
                  await TeamRepo()
                      .createSingle(newTeam, itemId: widget.member.teamId!);
                } else {
                  newMember?.teamId = widget.member.teamId;
                  await MemberRepo().updateSingle(newMember!.id, newMember);
                  widget.team?.membersIds?.add(newMember.id);
                  await TeamRepo()
                      .updateSingle(widget.member.teamId!, widget.team!);
                }
              } else {
                SnackbarHelper.showTemplated(
                  context,
                  title: "No user is found with this email",
                  style: const FlutterSnackBarStyle(
                    backgroundColor: Color(0xffFF244D),
                    titleStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Invite by email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.16,
              ),
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
    _formController.dispose();
    //!SECTION
    super.dispose();
  }
}
