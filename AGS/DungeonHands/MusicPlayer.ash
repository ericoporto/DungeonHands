// new module header

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
