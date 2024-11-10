import 'package:flutter/material.dart';
import 'package:safevision/Entities/RecordData.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Recorddetail extends StatefulWidget {
  final RecordData recordData;
  const Recorddetail({super.key, required this.recordData});

  @override
  State<Recorddetail> createState() => _RecorddetailState();
}

class _RecorddetailState extends State<Recorddetail> {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.recordData.videoUrl));

    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final Dio _dio = Dio();

    Future<void> downloadAndMoveVideo(RecordData recordData) async {
      String getSafeFileName(String originalFileName) {
        return originalFileName
                .replaceAll(
                    RegExp(r'[:\s]'), '_')
                .replaceAll('.', '_')
            +
            '.mp4';
      }

      try {
        Directory externalDir = Directory('/storage/emulated/0/Download/SafeVision');
        String savePath =
            '${externalDir.path}/safevision_record_${getSafeFileName(recordData.date.toString())}';

        await _dio.download(recordData.videoUrl, savePath);

        print("Video downloaded to: $savePath");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Video saved to $savePath")),
        );
      } catch (e) {
        print("Download failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed: $e")),
        );
      }
    }

    String formattedTime =
        DateFormat('HH:mm:ss').format(widget.recordData.date);
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy').format(widget.recordData.date);

    return Scaffold(
      appBar: Appbarwidget(
        title: "Recorded Video",
        subtitle: "See what your guests are doing",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                height: 275,
                color: Color(
                    0XFFE2EDF2),
                child: Stack(
                  children: [
                    WebViewWidget(controller: controller),
                    if (_isLoading)
                      Container(
                        color: Color(
                            0XFFE2EDF2),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFF4D6D7A),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                width: double.infinity,
                color: Color(0XFFE2EDF2),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10.0, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.recordData.camera,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Actionbutton(
                textButton: "Download Recording",
                onPressed: () {
                  downloadAndMoveVideo(widget.recordData);
                },
                safe: true),
            SizedBox(
              height: 10,
            ),
            Actionbutton(
              textButton: "View From Admin Website",
              onPressed: () {},
              safe: true,
              sendVerif: true,
            )
          ],
        ),
      ),
    );
  }
}
