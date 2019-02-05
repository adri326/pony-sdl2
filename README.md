# pony-sdl2, A Pony wrapper for SDL2

*Sees their free time being eaten by this thing.*

**Too lazy to do the FFI definitions and calls by yourself?**
Here you go, all of this stuff done for you and put in pretty primitives and classes.

This project tries to be as Pony-compliant as possible: error cases are handled, which means that there shouldn't be any SegFault.

## Installation & Usage

Clone this repository:

```sh
git clone https://github.com/adri326/pony-sdl2
```

And include it in your code:

```pony
use "pony-sdl2"
use "time"

actor Main
  new create(env: Env) =>
    try
      SDL.init()?
      let window = SDLWindow("My SDL2 project", SDLWindowPosCentered, SDLWindowPosCentered, 512, 512)
      let renderer = SDLRenderer(window, -1)
      renderer.set_draw_color(SDLColor(16, 16, 16))
      renderer.clear()
      renderer.present()
      Timers()(Timer(Waiter, 1_000_000_000))
    else
      env.out.print("Error initializing SDL2: " + SDL.get_error())
    end

class Waiter is TimerNotify
  fun apply(t: Timer, count: U64): Bool => false

// displays a gray window for 1 second
```
