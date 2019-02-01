class SDLRenderer
  let _renderer: RawSDLRenderer ref
  let index: I32
  var draw_color: SDLColor val = SDLColor(0, 0, 0)

  new create(window: SDLWindow, index': I32, flags: (Array[SDLRendererFlag] val | U32) = 1) =>
    index = index'
    _renderer = SDL.create_renderer(window.get_raw(), index, flags)

  fun ref set_draw_color(color: SDLColor val): Bool =>
    draw_color = color
    SDL.set_render_draw_color(_renderer, color.red(), color.green(), color.blue(), color.alpha())

  fun get_draw_color(): SDLColor val =>
    draw_color

  fun ref clear(): Bool =>
    SDL.render_clear(_renderer)

  fun ref present() =>
    SDL.render_present(_renderer)

  fun ref get_raw(): RawSDLRenderer =>
    _renderer
