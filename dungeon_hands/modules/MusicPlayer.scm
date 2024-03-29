AGSScriptModule        9  // MusicPlayer variables
AudioChannel *acMusic;
AudioClip * currentMusic;
bool stopped;
int globalMusicVol;
int currentMusicVolue;

// SFXPlayer variables
AudioChannel *acSound;
int gloabalSoundVol;
int orignalMusicX;
int orignalMusicY;

//AudioChannel * GetPlayingInstance(this AudioClip*)
//{
//  int i = 0;
//  AudioChannel *ac;
// 
//  while (i < System.AudioChannelCount)
//  {
//    ac = System.AudioChannels[i];
//    
//    if (ac.PlayingClip == this)
//    {
//      return System.AudioChannels[i];
//    }
//    i++;
//  }
//  
//  return null;
//}

function updateAllVolumes(){
  int i = 0;
  AudioChannel *ac;

  while (i < System.AudioChannelCount)
  {
    ac = System.AudioChannels[i];
   
    if (ac.PlayingClip != currentMusic)
    {
      ac.Volume = gloabalSoundVol;
    } else {
      ac.Volume = globalMusicVol;
    }
    i++;
  }  
}


AudioClip * previousmusic ;


static AudioClip * MusicPlayer::getCurrentMusic(){
  return currentMusic;  
}

static void MusicPlayer::play(AudioClip * musicClip,  int position, bool crossfade){ 
  stopped = false;

  if(previousmusic==musicClip){
    //don't play music if it's already playing
    return;
  }
  
  //stop previous music
  if(previousmusic != null){
    if(!crossfade){
      previousmusic.Stop();
    }
  }
  
  previousmusic = musicClip;
  
  currentMusic = musicClip;
  if(position == 0){
    acMusic = musicClip.Play(eAudioPriorityHigh, eRepeat);
  } else {
    acMusic = musicClip.PlayFrom(position,eAudioPriorityHigh, eRepeat);
    
  }
  acMusic.Volume = globalMusicVol;
  updateAllVolumes();
}


static void MusicPlayer::playFromPreviousTime(AudioClip * musicClip, bool crossfade){ 
  int previousPosition = acMusic.Position;
  MusicPlayer.play(musicClip, previousPosition, crossfade);
}

static void MusicPlayer::setMusicPosition(int x, int y){
  acMusic.SetRoomLocation(x, y);
  orignalMusicX = x;
  orignalMusicY = y;
}


static void MusicPlayer::removeMusicPosition(){
  acMusic.SetRoomLocation(0, 0);
  orignalMusicX = 0;
  orignalMusicY = 0;
}

static void MusicPlayer::tweenMusicPosition(int x, int y,  float timing){
  if(x==0 && y==0){
    MusicPlayer.removeMusicPosition();
  }
  
  if(orignalMusicX ==0 && orignalMusicY==0){
    return;  
  }
  
  acMusic.TweenRoomLocation(timing, x, y, orignalMusicX, orignalMusicY);
  orignalMusicX = x;
  orignalMusicY = y;
}


static void MusicPlayer::stop(AudioClip * musicClip){
  stopped = true;
  previousmusic = null;
  musicClip.Stop();  
}

static void MusicPlayer::setVolume(int musicVolume){
  if(acMusic != null){
    currentMusicVolue = musicVolume;
    acMusic.Volume = FloatToInt(IntToFloat(currentMusicVolue) * IntToFloat(globalMusicVol)/100.0);
  }
}

static void MusicPlayer::tweenVolume(int musicVolume, float timing){
  if(acMusic != null){
    currentMusicVolue = musicVolume;
    acMusic.TweenVolume(timing, FloatToInt(IntToFloat(musicVolume) * IntToFloat(globalMusicVol)/100.0), eEaseLinearTween, eNoBlockTween);
  }
}

static void MusicPlayer::setGlobalVolume(int musicVolume){
  globalMusicVol = musicVolume;
  Game.SetAudioTypeVolume(eAudioTypeAmbientSound, globalMusicVol, eVolExistingAndFuture);
  Game.SetAudioTypeVolume(eAudioTypeMusic, globalMusicVol, eVolExistingAndFuture);
}

static int MusicPlayer::getGlobalVolume(){
  return globalMusicVol;  
}



static void SFXPlayer::play(AudioClip * soundClip){ 
  acSound = soundClip.Play(eAudioPriorityNormal, eOnce);
  acSound.Volume = gloabalSoundVol;
  updateAllVolumes();
}

static void SFXPlayer::stop(AudioClip * soundClip){
  soundClip.Stop();  
}

static void SFXPlayer::setGlobalVolume(int soundVolume){
  gloabalSoundVol = soundVolume;
  Game.SetAudioTypeVolume(eAudioTypeSound, gloabalSoundVol, eVolExistingAndFuture);
}

static void SFXPlayer::setVolume(int soundVolume){
  if(acSound != null){
    acSound.Volume = FloatToInt(IntToFloat(soundVolume) * IntToFloat(gloabalSoundVol)/100.0);
  }
}

static int SFXPlayer::getGlobalVolume(){
  return gloabalSoundVol;  
}

void  SPlayerSetGameVolume(int gameVolume){
  System.Volume = gameVolume;
}

int SPlayerGetGameVolume(){
  return System.Volume;
}

void SPlayerSetDefaults(){
  MusicPlayer.setGlobalVolume(70);
  SFXPlayer.setGlobalVolume(70);
  SPlayerSetGameVolume(70);
}

function game_start()
{
  SPlayerSetDefaults();
  sldAudio.Value = System.Volume;
  sldTestMainVolume.Value = System.Volume;
  sldTestMusicVolume.Value = globalMusicVol;
  sldTestSoundVolume.Value = gloabalSoundVol;
}


  �  // new module header

#define MusicPlayer_CROSSFADETIME 0


struct MusicPlayer
{
  import static void play(AudioClip * musicClip,  int position = 0, bool crossfade = false);
  import static void playFromPreviousTime(AudioClip * musicClip, bool crossfade = false);
  import static AudioClip * getCurrentMusic();
  import static void stop(AudioClip * musicClip);
  import static void setMusicPosition(int x, int y);
  import static void removeMusicPosition();
  import static void tweenMusicPosition(int x, int y,  float timing);
  import static void setGlobalVolume(int musicVolume);
  import static int  getGlobalVolume();
  import static void setVolume(int musicVolume);
  import static void tweenVolume(int musicVolume, float timing);
};

struct SFXPlayer
{
  import static void play(AudioClip * soundClip);
  import static void stop(AudioClip * soundClip);
  import static void setGlobalVolume(int soundVolume);
  import static int  getGlobalVolume();
  import static void setVolume(int soundVolume);
};

import void SPlayerSetGameVolume(int gameVolume);
import int SPlayerGetGameVolume();
import void SPlayerSetDefaults();
 RI�/        ej��