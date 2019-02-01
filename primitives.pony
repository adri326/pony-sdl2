primitive SDLInitTimer
  fun apply(): U32 => 0b1
primitive SDLInitAudio
  fun apply(): U32 => 0b10000
primitive SDLInitVideo
  fun apply(): U32 => 0b100000
primitive SDLInitJoystick
  fun apply(): U32 => 0b1000000000
primitive SDLInitHaptic
  fun apply(): U32 => 0b1000000000000
primitive SDLInitGamecontroller
  fun apply(): U32 => 0b10000000000000
primitive SDLInitEvents
  fun apply(): U32 => 0b100000000000000
primitive SDLInitEverything
  fun apply(): U32 => 0b1111001000110001

type SDLInitFlag is (SDLInitTimer | SDLInitAudio | SDLInitVideo | SDLInitJoystick | SDLInitHaptic | SDLInitGamecontroller | SDLInitEvents | SDLInitEverything)


primitive SDLWindowPosCentered
  fun apply(): I32 => 0x2fff0000
primitive SDLWindowPosUndefined
  fun apply(): I32 => 0x1fff0000


primitive SDLWindowFullscreen
  fun apply(): U32 => 1
primitive SDLWindowFullscreenDesktop
  fun apply(): U32 => 4097
primitive SDLWindowOpenGL
  fun apply(): U32 => 2
primitive SDLWindowVulkan
  fun apply(): U32 => 268435456
primitive SDLWindowHidden
  fun apply(): U32 => 8
primitive SDLWindowBorderless
  fun apply(): U32 => 16
primitive SDLWindowResizable
  fun apply(): U32 => 32
primitive SDLWindowMinimized
  fun apply(): U32 => 64
primitive SDLWindowMaximized
  fun apply(): U32 => 128
primitive SDLWindowInputGrabbed
  fun apply(): U32 => 256
primitive SDLWindowAllowHighDPI
  fun apply(): U32 => 8192

type SDLWindowFlag is (SDLWindowFullscreen | SDLWindowFullscreenDesktop | SDLWindowOpenGL | SDLWindowVulkan | SDLWindowHidden | SDLWindowBorderless | SDLWindowResizable | SDLWindowMinimized | SDLWindowMaximized | SDLWindowInputGrabbed | SDLWindowAllowHighDPI)


primitive SDLRendererSoftware
  fun apply(): U32 => 1
primitive SDLRendererAccelerated
  fun apply(): U32 => 2
primitive SDLRendererPreventVSync
  fun apply(): U32 => 4
primitive SDLRendererTargetTexture
  fun apply(): U32 => 8

type SDLRendererFlag is (SDLRendererSoftware | SDLRendererAccelerated | SDLRendererPreventVSync | SDLRendererTargetTexture)
