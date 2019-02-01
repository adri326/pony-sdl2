use "lib:SDL2"
use "lib:SDL2_gfx"

use @SDL_Init[I32](flags: U32)
use @SDL_GetError[Pointer[U8 val]]()
use @SDL_CreateWindow[_SDLWindow tag](name: Pointer[U8 val] tag, x: I32, y: I32, w: I32, h: I32, flags: U32)
use @SDL_CreateRenderer[RawSDLRenderer ref](window: _SDLWindow tag, index: I32, flags: U32)
use @SDL_RenderClear[I32](renderer: RawSDLRenderer ref)
use @SDL_RenderPresent[None](renderer: RawSDLRenderer ref)
use @SDL_SetRenderDrawColor[I32](renderer: RawSDLRenderer ref, red: U8, green: U8, blue: U8, alpha: U8)


struct _SDLWindow
struct RawSDLRenderer
// struct _SDLSurface

primitive SDL
  fun init(flags: (Array[SDLInitFlag] val | U32) = 100000)? =>
    if not _sdl_init(flags) then
      error
    end

  fun get_error(): String =>
    recover String.from_cstring(@SDL_GetError()) end

  fun _sdl_init(flags: (Array[SDLInitFlag] val | U32)): Bool =>
    var flag: U32 = 0
    match flags
    | let flags': Array[SDLInitFlag] val =>
      for flag' in flags'.values() do
        flag = flag or flag'()
      end
    | let flag': U32 => flag = flag'
    end
    @SDL_Init(flag) == 0

  fun create_window(name: String, x: (I32 | SDLWindowPosCentered | SDLWindowPosUndefined), y: (I32 | SDLWindowPosCentered | SDLWindowPosUndefined), w: I32, h: I32, flags: (Array[SDLWindowFlag] val | U32) = 0): _SDLWindow tag =>
    let x' = match x
    | let x'': I32 => x''
    | SDLWindowPosCentered => SDLWindowPosCentered()
    | SDLWindowPosUndefined => SDLWindowPosUndefined()
    end
    let y' = match y
    | let y'': I32 => y''
    | SDLWindowPosCentered => SDLWindowPosCentered()
    | SDLWindowPosUndefined => SDLWindowPosUndefined()
    end
    var flags': U32 = 0
    match flags
    | let flags'': Array[SDLWindowFlag] val =>
      for flag in flags''.values() do
        flags' = flags' or flag()
      end
    | let flags'': U32 => flags' = flags''
    end

    @SDL_CreateWindow(name.cstring(), x', y', w, h, flags')

  fun create_renderer(window: _SDLWindow tag, index: I32, flags: (Array[SDLRendererFlag] val | U32) = 1): RawSDLRenderer ref =>
    var flags': U32 = 0
    match flags
    | let flags'': Array[SDLRendererFlag] val =>
      for flag in flags''.values() do
        flags' = flags' or flag()
      end
    | let flags'': U32 => flags' = flags''
    end

    @SDL_CreateRenderer(window, index, flags')

  fun render_clear(renderer: RawSDLRenderer ref): Bool =>
    @SDL_RenderClear(renderer) == 0

  fun render_present(renderer: RawSDLRenderer ref) =>
    @SDL_RenderPresent(renderer)

  fun set_render_draw_color(renderer: RawSDLRenderer ref, r: U8, g: U8, b: U8, a: U8 = 255): Bool =>
    @SDL_SetRenderDrawColor(renderer, r, g, b, a) == 0

class SDLWindow
  let _window: _SDLWindow tag
  let width: I32
  let height: I32
  let name: String

  new create(name': String, x: (I32 | SDLWindowPosCentered | SDLWindowPosUndefined), y: (I32 | SDLWindowPosCentered | SDLWindowPosUndefined), width': I32, height': I32, flags: (Array[SDLWindowFlag] val | U32) = 0) =>
    width = width'
    height = height'
    name = name'
    _window = SDL.create_window(name, x, y, width, height, flags)

  fun get_raw(): _SDLWindow tag =>
    _window

class SDLColor
  let _r: U8
  let _g: U8
  let _b: U8
  let _a: U8
  new val create(r: U8, g: U8, b: U8, a: U8 = 255) =>
    _r = r
    _g = g
    _b = b
    _a = a

  fun red(): U8 => _r
  fun green(): U8 => _g
  fun blue(): U8 => _b
  fun alpha(): U8 => _a
