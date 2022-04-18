// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

bool isEmptyList = true;

final List completedItemList = [];

class CompletedEvents extends StatelessWidget {
  static const String id = 'CompletedTodos';
  const CompletedEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CompletedEvents Bulid Run");
    return isEmptyList
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Lottie.asset('animations/completed-task.json'),
                  width: 200,
                  height: 200,
                ),
                const Text(
                  'No Event Completed',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Container();
            },
            separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
            itemCount: completedItemList.length);
  }
}
