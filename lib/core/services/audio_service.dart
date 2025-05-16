import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';

class AudioService extends GetxService {
  late AudioPlayer _backgroundPlayer;
  late AudioPlayer _effectPlayer;
  
  final StorageService _storageService = Get.find<StorageService>();
  
  // Music state
  final _isMusicPlaying = false.obs;
  bool get isMusicPlaying => _isMusicPlaying.value;
  
  // Volume state
  final _musicVolume = 0.5.obs;
  double get musicVolume => _musicVolume.value;
  
  // Sound paths
  final String _backgroundMusicPath = 'assets/audio/background_music.mp3';
  final String _correctAnswerSound = 'assets/audio/correct_answer.mp3';
  final String _wrongAnswerSound = 'assets/audio/wrong_answer.mp3';
  final String _timerTickSound = 'assets/audio/timer_tick.mp3';
  final String _gameOverSound = 'assets/audio/game_over.mp3';
  final String _buttonClickSound = 'assets/audio/button_click.mp3';
  
  @override
  void onInit() {
    super.onInit();
    _initAudioPlayers();
  }
  
  void _initAudioPlayers() {
    _backgroundPlayer = AudioPlayer();
    _effectPlayer = AudioPlayer();
    
    // Set initial volume based on saved preference
    final bool isAudioEnabled = _storageService.isAudioEnabled();
    _musicVolume.value = isAudioEnabled ? 0.5 : 0.0;
  }
  
  Future<void> playBackgroundMusic() async {
    if (!_isMusicPlaying.value && _musicVolume.value > 0) {
      await _backgroundPlayer.play(AssetSource(_backgroundMusicPath));
      await _backgroundPlayer.setVolume(_musicVolume.value);
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      _isMusicPlaying.value = true;
    }
  }
  
  Future<void> stopBackgroundMusic() async {
    if (_isMusicPlaying.value) {
      await _backgroundPlayer.stop();
      _isMusicPlaying.value = false;
    }
  }
  
  Future<void> pauseBackgroundMusic() async {
    if (_isMusicPlaying.value) {
      await _backgroundPlayer.pause();
      _isMusicPlaying.value = false;
    }
  }
  
  Future<void> resumeBackgroundMusic() async {
    if (!_isMusicPlaying.value && _musicVolume.value > 0) {
      await _backgroundPlayer.resume();
      _isMusicPlaying.value = true;
    }
  }
  
  Future<void> setMusicVolume(double volume) async {
    _musicVolume.value = volume;
    await _backgroundPlayer.setVolume(volume);
    
    // Save preference
    await _storageService.setAudioEnabled(volume > 0);
    
    // If volume is set to 0, pause music
    if (volume <= 0 && _isMusicPlaying.value) {
      await pauseBackgroundMusic();
    } 
    // If volume is increased from 0, resume music
    else if (volume > 0 && !_isMusicPlaying.value) {
      await resumeBackgroundMusic();
    }
  }
  
  Future<void> toggleMute() async {
    if (_musicVolume.value > 0) {
      // Store the current volume for unmuting
      double previousVolume = _musicVolume.value;
      await setMusicVolume(0);
      // Store in preferences - added these methods to StorageService
      await _savePreviousVolume(previousVolume);
    } else {
      // Restore previous volume or default to 0.5
      double previousVolume = await _getPreviousVolume() ?? 0.5;
      await setMusicVolume(previousVolume);
    }
  }
  
  // Helper methods for volume persistence
  Future<void> _savePreviousVolume(double volume) async {
    // Using our new methods in StorageService
    await _storageService.setBool('hasPreviousVolume', true);
    await _storageService.setDouble('previousVolume', volume);
  }
  
  Future<double?> _getPreviousVolume() async {
    bool hasPrevious = _storageService.getBool('hasPreviousVolume') ?? false;
    if (hasPrevious) {
      return _storageService.getDouble('previousVolume');
    }
    return null;
  }
  
  Future<void> playCorrectAnswerSound() async {
    if (_musicVolume.value > 0) {
      await _effectPlayer.play(AssetSource(_correctAnswerSound));
    }
  }
  
  Future<void> playWrongAnswerSound() async {
    if (_musicVolume.value > 0) {
      await _effectPlayer.play(AssetSource(_wrongAnswerSound));
    }
  }
  
  Future<void> playTimerTickSound() async {
    if (_musicVolume.value > 0) {
      await _effectPlayer.play(AssetSource(_timerTickSound));
    }
  }
  
  Future<void> playGameOverSound() async {
    if (_musicVolume.value > 0) {
      await _effectPlayer.play(AssetSource(_gameOverSound));
    }
  }
  
  Future<void> playButtonClickSound() async {
    if (_musicVolume.value > 0) {
      await _effectPlayer.play(AssetSource(_buttonClickSound));
    }
  }
  
  @override
  void onClose() {
    _backgroundPlayer.dispose();
    _effectPlayer.dispose();
    super.onClose();
  }
}