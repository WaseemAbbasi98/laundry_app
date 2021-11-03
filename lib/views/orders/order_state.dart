import 'package:flutter/material.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class ToggleButtonsstate extends StatefulWidget {
  final state;
  final jobid;
  ToggleButtonsstate({this.state, this.jobid});
  @override
  _ToggleButtonsstateState createState() => _ToggleButtonsstateState();
}

class _ToggleButtonsstateState extends State<ToggleButtonsstate> {
  List<bool> isSelected = [true, false, false, false, false];
  @override
  void dispose() {
    Navigator.pop(context);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService().jobid = widget.jobid;
    var jobs = Provider.of<List<Jobs>>(context);
    switch (jobs[0].status) {
      case 'assigned':
        setState(() {
          isSelected[0] = true;
        });
        break;
      case 'accepted':
        setState(() {
          isSelected[1] = true;
        });
        break;
      case 'pending':
        setState(() {
          isSelected[2] = true;
          isSelected[1] = true;
        });
        break;
      case 'started':
        setState(() {
          isSelected[3] = true;
          isSelected[2] = true;
          isSelected[1] = true;
        });
        break;
      case 'completed':
        setState(() {
          isSelected[4] = true;
          isSelected[3] = true;
          isSelected[2] = true;
          isSelected[1] = true;
        });
        break;
      default:
        isSelected[0] = true;
    }

    return ToggleButtons(
      isSelected: isSelected,
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: Colors.amber.shade900,
      borderWidth: 3,
      borderColor: Colors.blueGrey,
      selectedBorderColor: Colors.orange,
      borderRadius: BorderRadius.circular(50),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text('Assigned', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text('Accepted', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text('Pending', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('Start', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('Complete', style: TextStyle(fontSize: 18)),
        ),
      ],
      onPressed: (int newIndex) {
        // final isOneSelected =
        //     isSelected.where((element) => element).length == 1;

        // if (isOneSelected && isSelected[newIndex]) return;

        // setState(() {
        //   for (int index = 0; index < isSelected.length; index++) {
        //     if (index == newIndex) {
        //       isSelected[index] = !isSelected[index];
        //     }
        //   }
        // });
      },
    );
  }
}
