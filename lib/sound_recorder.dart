import 'dart:io';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio='audio_example.aac' ;

class SoundRecorder{
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordingInitialised=false;
  bool get isRecording =>_audioRecorder!.isRecording;
  late String audioPath;

  Future init()async{
    _audioRecorder=FlutterSoundRecorder();
    if(await Permission.microphone.isDenied) {
      await Permission.microphone.request();
    }
    if(await Permission.audio.isDenied) {
      await Permission.audio.request();
    }
    if(await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
    if(await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    if(await Permission.mediaLibrary.isDenied) {
      await Permission.mediaLibrary.request();
    }
    if(await Permission.accessMediaLocation.isDenied) {
      await Permission.accessMediaLocation.request();
    }


    await _audioRecorder!.openRecorder();
    _isRecordingInitialised=true;
  }

  void dispose(){

    _audioRecorder!.closeRecorder();
    _audioRecorder=null;
    _isRecordingInitialised=false;
  }

  Future record() async{
    if(!_isRecordingInitialised)return ;
    // Start recording to file
    Directory? directory= await getApplicationCacheDirectory();
    String? path=directory?.path;
    Directory newPath=Directory('$path');
    await   _audioRecorder!.startRecorder(toFile:pathToSaveAudio);
  }

  Future stop() async{
    if(!_isRecordingInitialised)return null;

    try{
      String? pathStop =  await   _audioRecorder!.stopRecorder();;
      print("pathstop:   $pathStop");
      File file=await File(pathStop!);
      if(await file.existsSync()){
        print("file exists");
      }
      else{
        print(" file n'esxiste pas");
      }
      audioPath=pathStop!;

    }
    catch(e){
      print("error during stop recording: $e");
    }


  }

  Future toggleRecording()async{
    if(_audioRecorder!.isStopped){
      await record();
    }
    else{
      await stop();
    }
  }
}
