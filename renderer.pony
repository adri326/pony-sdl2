class SDLRenderer
  let _raw: SDLRendererRaw ref
  let index: I32
  var draw_color: SDLColor val = SDLColor(0, 0, 0)

  new create(window: SDLWindow, index': I32, flags: (Array[SDLRendererFlag] val | U32) = 1) =>
    index = index'
    _raw = SDL.create_renderer(window, index, flags)

  fun ref set_draw_color(color: SDLColor val): Bool =>
    draw_color = color
    SDL.set_render_draw_color(_raw, color.red(), color.green(), color.blue(), color.alpha())

  fun get_draw_color(): SDLColor val =>
    draw_color

  fun ref clear(): Bool =>
    SDL.render_clear(_raw)

  fun ref present() =>
    SDL.render_present(_raw)

  fun ref get_raw(): SDLRendererRaw ref =>
    _raw

  fun texture_from_surface(surface: SDLSurface): (SDLTexture | None) =>
    let res = @SDL_CreateTextureFromSurface(_raw, surface.get_raw())
    if res.is_null() then
      None
    else
      SDLTexture(res)
    end

  fun ref copy(texture: SDLTexture, dimensions: (SDLRect | (I32, I32, I32, I32) | None) = None, crop: (SDLRect | (I32, I32, I32, I32) | None) = None): Bool =>
    let dimensions' = match dimensions
    | let rect: SDLRect => rect
    | (let x: I32, let y: I32, let width: I32, let height: I32) => SDLRect(x, y, width, height)
    | None => SDLRect.none()
    end
    let crop' = match crop
    | let rect: SDLRect => rect
    | (let x: I32, let y: I32, let width: I32, let height: I32) => SDLRect(x, y, width, height)
    | None => SDLRect.none()
    end
    @SDL_RenderCopy(_raw, texture.get_raw(), dimensions'.get_raw(), crop'.get_raw()) == 0
