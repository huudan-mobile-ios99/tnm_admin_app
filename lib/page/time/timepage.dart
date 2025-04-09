import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/jackpot/dialog.confirm.dart';
import 'package:tnm_app_slot_aft/page/time/bloc_machine/machine_bloc.dart';
import 'package:tnm_app_slot_aft/page/time/bloc_timer/timer_bloc.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';
import 'package:http/http.dart' as http;

class TimePage extends StatelessWidget {
  SocketManagerSlot? mySocket;
  TimePage({required this.mySocket, super.key});



  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => TimerBloc(),
              child: TimePageBody(mySocket: mySocket)),
          BlocProvider( create: (context) => ListMachineBloc(httpClient: http.Client()))
        ],
        child: TimePageBody(mySocket: mySocket)
    );
  }
}


// ignore: must_be_immutable
class TimePageBody extends StatelessWidget {
  SocketManagerSlot? mySocket;
  TimePageBody({required this.mySocket, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ServiceAPIsSlot serviceApi = ServiceAPIsSlot();

    final TextEditingController controllerTimer =  TextEditingController(text: '${MyString.TIME_DEFAULT_MINUTES}');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          backgroundColor: MyColor.appBar,
          title: textcustomColor(text:'Time Setting',size:MyString.padding16,color:MyColor.white,isBold: true),
          actions: const [

          ],
        ),

    body: BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        switch (state.status) {
          case TimerStatus.finish:
            debugPrint('timer admin finish - disable all machine');
            break;
          default:
        }
      },
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          final minutes = (state.duration / 60).floor();
          final seconds = (state.duration % 60).floor();
          return BlocBuilder<ListMachineBloc, ListMachineState>(
            builder: (contextMachine, stateMachine) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: MyString.padding16, vertical: MyString.padding04),
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                Row(
                  children: [
                    Text(
                        // Display the timer countdown in MM:SS format
                        '$minutes:${seconds.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: MyString.padding24,
                          fontWeight: FontWeight.w500,
                        ),
                    ),
                    _buildControlButtons(context, state, stateMachine, controllerTimer, mySocket,serviceApi),
                  ],
                ),
                 const SizedBox(
                        height: MyString.padding24,
                 ),
                 mytextFieldTitleSizeIcon(
                          width: width,
                          icon: const Icon(Icons.airplay_rounded),
                          label: "Timer Minutes",
                          text: '',
                          controller: controllerTimer,
                          enable: true,
                          textinputType: TextInputType.number),

                const SizedBox(
                        height: MyString.padding24,
                ),

                Tooltip(
                    message: "Display time in client view",
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.airplay_rounded),
                        onPressed: () {
                          showConfirmationDialog(context, "Display & View Time", () {
                          serviceApi.updateTimeLatest(
                                  minutes: state.duration ~/ 60,
                                  seconds: state.duration % 60,
                                  status: MyString.TIME_SET)
                          .then((v) {mySocket!.emitTime();});
                          });
                        },
                        label: const Text('Display & View Time')),
                  ),
                ],
              ),
            );
          });
        },
      ),
    ));
  }
}






// Method to display the control buttons
Widget _buildControlButtons(
  BuildContext context,
  TimerState state,
  ListMachineState stateMachine,
  TextEditingController? controller,
  SocketManagerSlot? socket,
  ServiceAPIsSlot? serviceApi,
) {
  final timerBloc = context.read<TimerBloc>();
  final ServiceAPIsSlot serviceAPIs = ServiceAPIsSlot();

  if (state.status == TimerStatus.initial) {
    return TextButton.icon(
      icon: const Icon(Icons.play_arrow, color: MyColor.green),
      onPressed: () {
        late int customDuration   = int.tryParse(controller!.text) ?? MyString.TIME_DEFAULT_MINUTES;
        _showConfirmationDialogContent(context, "Start Game", () {
           customDuration = int.tryParse(controller!.text) ?? MyString.TIME_DEFAULT_MINUTES;
          final durationInSeconds = customDuration * 60; // Convert minutes to seconds
          int minutes = durationInSeconds ~/ 60; // Calculate how many full minutes
          int seconds = durationInSeconds % 60; // Get the remaining seconds
          timerBloc.add(StartTimer(durationInSeconds: durationInSeconds));
          serviceAPIs.updateTimeLatest(
                  minutes: minutes,
                  seconds: seconds,
                  status: MyString.TIME_START)
          .then((v) {
            if (v['status'] == 1) {
              socket!.emitTime();
            }
          }).catchError((error) {
            debugPrint(error);
          });
        }, Text('Are you sure you want to process?\n\n+Game Time: $customDuration (minutes)'));
      },
      label: const Text('START'),
    );
  } else if (state.status == TimerStatus.ticking) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.pause),
          onPressed: () {
            timerBloc.add(PauseTimer());
            serviceAPIs.updateTimeLatest(
                    minutes: state.duration ~/ 60,
                    seconds: state.duration % 60,
                    status: MyString.TIME_PAUSE)
                .then((v) {
              if (v['status'] == 1) {
                socket!.emitTime();
              }
            });

            updateStatusAll(context:context,service_api: serviceApi );
          },
          label: const Text('PAUSE'),
        ),
        const SizedBox(width: MyString.padding16),
        TextButton.icon(
          icon: const Icon(Icons.stop, color: MyColor.red),
          onPressed: () {
            _showConfirmationDialog(context, "Stop Game", () {
              timerBloc.add(StopTimer());
              final int customDuration = int.tryParse(controller!.text) ??
                  MyString.TIME_DEFAULT_MINUTES;
              serviceAPIs
                  .updateTimeLatest(
                      minutes: customDuration,
                      seconds: 0,
                      status: MyString.TIME_STOP)
                  .then((v) {
                if (v['status'] == 1) {
                  socket!.emitTime();
                }
              });
            });
          },
          label: const Text('STOP'),
        ),
      ],
    );
  } else if (state.status == TimerStatus.paused) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.play_arrow_outlined, color: MyColor.green),
          onPressed: () {
            timerBloc.add(ResumeTimer());
            serviceAPIs
                .updateTimeLatest(
                    minutes: state.duration ~/ 60,
                    seconds: state.duration % 60,
                    status: MyString.TIME_RESUME)
                .then((v) {
              if (v['status'] == 1) {
                socket!.emitTime();
              }
            });
          },
          label: const Text('RESUME'),
        ),
        const SizedBox(width: MyString.padding16),
        TextButton.icon(
          icon: const Icon(Icons.stop, color: MyColor.red),
          onPressed: () {
            _showConfirmationDialog(context, "Stop Game", () {
              timerBloc.add(StopTimer());
              final int customDuration = int.tryParse(controller!.text) ??
                  MyString.TIME_DEFAULT_MINUTES;
              serviceAPIs
                  .updateTimeLatest(
                      minutes: customDuration,
                      seconds: 0,
                      status: MyString.TIME_STOP)
                  .then((v) {
                if (v['status'] == 1) {
                  socket!.emitTime();
                }
              });
            });
          },
          label: const Text('STOP'),
        ),
      ],
    );
  } else if (state.status == TimerStatus.finish) {
    return TextButton.icon(
      icon: const Icon(Icons.play_arrow, color: MyColor.green_accent),
      onPressed: () {
        _showConfirmationDialog(context, "Restart Game", () {
          final int customDuration = int.tryParse(controller!.text) ?? 5;
          final durationInSeconds =
              customDuration * 60; // Convert minutes to seconds
          int minutes =
              durationInSeconds ~/ 60; // Calculate how many full minutes
          int seconds = durationInSeconds % 60; // Get the remaining seconds
          timerBloc.add(StartTimer(durationInSeconds: durationInSeconds));
          serviceAPIs
              .updateTimeLatest(
                  minutes: minutes,
                  seconds: seconds,
                  status: MyString.TIME_START)
              .then((v) {
            if (v['status'] == 1) {
              socket!.emitTime();
            }
          });
        });
      },
      label: const Text('RESTART'),
    );
  }

  return Container();
}

void updateStatusAll({BuildContext? context,required ServiceAPIsSlot?  service_api}) {
  //update status all APIs
  service_api!.updateStatusAll(status: 0).then((v) {
    if (v['result']['affectedRows'] > 0) {
      // _onRefreshMachineList(context);
      // showSnackBar(context:context,message: "Pause/Stop & Disable all machine");
    }
  });
}

void _onRefreshMachineList(context) {
  context.read<ListMachineBloc>().add(ListMachineFetched());
}

// Method to show a confirmation dialog
Future<void> _showConfirmationDialog(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(actionTitle),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // User pressed NO
            },
            child: const Text('NO'),
          ),
          TextButton.icon(
            icon: const Icon(Icons.add_sharp, color: MyColor.red_accent),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // User pressed YES
            },
            label: const Text('YES'),
          ),
        ],
      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}




// Method to show a confirmation dialog
Future<void> _showConfirmationDialogContent(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
  Widget widget
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(actionTitle),
        content: widget,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // User pressed NO
            },
            child: const Text('NO'),
          ),
          TextButton.icon(
            icon: const Icon(Icons.add_sharp, color: MyColor.red_accent),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // User pressed YES
            },
            label: const Text('YES'),
          ),
        ],
      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}
