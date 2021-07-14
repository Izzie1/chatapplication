import 'package:flutter/material.dart';
import 'package:funchat/models/call.dart';
import 'package:funchat/models/log.dart';
import 'package:funchat/screens/chat/cached_image.dart';
import 'package:funchat/services/call_methods.dart';
import 'package:funchat/services/local_db/repository/log_repository.dart';
import 'package:funchat/ultilities/permissions.dart';

import '../call.dart';

class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({
    @required this.call,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();
  addToLocalStorage({@required String callStatus}) {
    Log log = Log(
      callerName: widget.call.callerName,
      callerPic: widget.call.callerPic,
      receiverName: widget.call.receiverName,
      receiverPic: widget.call.receiverPic,
      timestamp: DateTime.now().toString(),
      callStatus: callStatus,
    );

    LogRepository.addLogs(log);
  }

  bool isCallMissed = true;

  void dispose(){
    if (isCallMissed) {
      addToLocalStorage(callStatus: "missed");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            CachedImage(
              widget.call.callerPic,
              isRound: true,
              height: 150,
              width: 150,
              radius: 180,
            ),
            SizedBox(height: 15),
            Text(
              widget.call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    isCallMissed = false;
                    addToLocalStorage(callStatus: "received");
                    await callMethods.endCall(call: widget.call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () async {
                    isCallMissed = false;
                    addToLocalStorage(callStatus: "received");

                    await Permissions.cameraAndMicrophonePermissionsGranted()
                        ?
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CallScreen(call: widget.call,)))
                        : {};
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}