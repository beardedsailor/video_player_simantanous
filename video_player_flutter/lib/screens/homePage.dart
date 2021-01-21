import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _controller1;
  VideoPlayerController _controller2;
  VideoPlayerController _controller3;
  Future<void> _initializeVideoPlayerFuture1;
  Future<void> _initializeVideoPlayerFuture2;
  Future<void> _initializeVideoPlayerFuture3;

  @override
  void initState() {
    _controller1 = VideoPlayerController.asset("assets/sample-mp4-file2.mp4",videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _controller2 = VideoPlayerController.asset("assets/sample-mp4-file1.mp4",videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _controller3 = VideoPlayerController.asset("assets/sample-mp4-file3.mp4",videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _initializeVideoPlayerFuture1 = _controller1.initialize();
    _initializeVideoPlayerFuture2 = _controller2.initialize();
    _initializeVideoPlayerFuture3 = _controller3.initialize();
    _controller1.setLooping(true);
    _controller1.setVolume(1.0);
    _controller2.setLooping(true);
    _controller2.setVolume(1.0);
    _controller3.setLooping(true);
    _controller3.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Video Demo"),
        ),
        body: SingleChildScrollView(
          child: new Column(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture1,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(children: [
                      AspectRatio(
                        aspectRatio: _controller1.value.aspectRatio,
                        child: VideoPlayer(_controller1),
                      ),
                      AspectRatio(
                        aspectRatio: _controller2.value.aspectRatio,
                        child: VideoPlayer(_controller2),
                      ),
                       AspectRatio(
                        aspectRatio: _controller3.value.aspectRatio,
                        child: VideoPlayer(_controller3),
                      ),
                    ]);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),          
             
              new RaisedButton(
                  child: _controller1.value.isPlaying
                      ? new Text(
                          "Stop all",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : new Text(
                          "Play all",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_controller1.value.isPlaying &&
                        _controller2.value.isPlaying &&
                        _controller3.value.isPlaying) {
                      setState(() {
                        _controller1.pause();
                        _controller2.pause();
                        _controller3.pause();
                      });
                    } else {
                      // If the video is paused, play it.
                      setState(() {
                        _controller2.play();
                        _controller3.play();
                        _controller1.play();
                      });
                    }
                  })
            ],
          ),
        ));
  }
}
