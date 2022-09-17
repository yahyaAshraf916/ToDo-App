import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';


class HomeLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dataController = TextEditingController();
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..CreatDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: ScaffoldKey,
              appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShow) {
                    if (formKey.currentState!.validate()) {
                      cubit.inserToDatabase(
                          title: titleController.text,
                          data: dataController.text,
                          time: timeController.text);
                    }
                  } else {
                    ScaffoldKey.currentState
                        ?.showBottomSheet(
                          (context) => Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defulteditTextx(
                                    Controller: titleController,
                                    keyboardType: TextInputType.text,
                                    Label: "Task title",
                                    prefix: Icons.title,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Title must not be empty";
                                      } else {
                                        return null;
                                      }
                                    }, 
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defulteditTextx(
                                    
                                    Controller: timeController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();

                                        print(value.format(context));
                                      });
                                      print("timng tapped");
                                    },
                                    Label: "Task time",
                                    prefix: Icons.watch_later_outlined,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Time must not be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defulteditTextx(
                                    
                                    Controller: dataController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse("2025-01-30"))
                                          .then((value) {
                                        print(
                                            DateFormat.yMMMd().format(value!));
                                        dataController.text =
                                            DateFormat.yMMMd().format(value);
                                      });
                                    },
                                    Label: "Task date",
                                    prefix: Icons.calendar_today,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Date must not be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.mode_rounded);
                    });
                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: "Tasks",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: "Archived",
                  ),
                ],
              ),
            );
          },
        ));
  }
}
