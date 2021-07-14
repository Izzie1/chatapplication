import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funchat/components/tile.dart';
import 'package:funchat/models/log.dart';
import 'package:funchat/screens/call/pickup/pickup_layout.dart';
import 'package:funchat/screens/chat/cached_image.dart';
import 'package:funchat/services/local_db/repository/log_repository.dart';
import 'package:funchat/ultilities/utils.dart';
class LogScreen extends StatefulWidget {
  @override
  _LogScreen createState() => _LogScreen();
}
class _LogScreen extends State<LogScreen> {
  getIcon(String callStatus) {
    Icon _icon;
    double _iconSize = 15;

    switch (callStatus) {
      case "dialled":
        _icon = Icon(
          Icons.call_made,
          size: _iconSize,
          color: Colors.green,
        );
        break;

      case "missed":
        _icon = Icon(
          Icons.call_missed,
          color: Colors.red,
          size: _iconSize,
        );
        break;

      default:
        _icon = Icon(
          Icons.call_received,
          size: _iconSize,
          color: Colors.grey,
        );
        break;
    }
    return _icon;
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        body: FutureBuilder<dynamic>(
          future: LogRepository.getLogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List<dynamic> logList = snapshot.data;
              if (logList.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(12),
                    itemCount: logList.length,
                    itemBuilder: (context, index) {
                      Log _log = logList[index];
                      bool hasDialled = _log.callStatus == "dialled";
                      return Tile(
                          mini: false,
                          onTap: () {},
                          title: Text(
                            hasDialled ? _log.receiverName : _log.callerName,
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontFamily: "Arial",
                                fontSize: 19),
                          ),
                          leading: Container(
                            child: CachedImage(
                              hasDialled ? _log.receiverPic : _log.callerPic,
                              isRound: true,
                              radius: 45,
                            ),
                          ),
                          icon: getIcon(_log.callStatus),
                          subtitle: Text(
                            Utils.formatDateString(_log.timestamp),
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete this Log?"),
                            content:
                            Text("Are you sure you wish to delete this log?"),
                            actions: [
                              FlatButton(
                                child: Text("YES"),
                                onPressed: () async {
                                  Navigator.maybePop(context);
                                  await LogRepository.deleteLogs(_log.logId);
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                              ),
                              FlatButton(
                                child: Text("NO"),
                                onPressed: () => Navigator.maybePop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Text("");
            }
            return Text("");
          },
        ),
      ),
    );
  }
}
