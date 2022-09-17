import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/shared/cubit/cubit.dart';


Widget defaultButton({
  double width = double.maxFinite,
  Color backgroundColor = Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      color: backgroundColor,
      child: ElevatedButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defulteditTextx({
  required TextEditingController Controller,
  required TextInputType keyboardType,
  GestureTapCallback? onTap,
  required FormFieldValidator<String> validator,
  required String Label,
  required IconData prefix,
  IconData? suffix,
  bool? isPassword = false,
  Function? suffixPressed()?,
  Function? onchanged(value)?,
  Function? onSubmitted(value)?,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword!,
      controller: Controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: Label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
      ),
    );
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model["id"].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['title']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${model['data']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: "done", id: model["id"]);
              },
              icon: Icon(Icons.check_box),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: "archive", id: model["id"]);
              },
              icon: Icon(Icons.archive),
              color: Colors.black45,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model["id"]);
      },
    );
Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      builder: (BuildContext context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      condition: tasks.length > 0,
      fallback: (BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )
          ],
        ),
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false,
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
