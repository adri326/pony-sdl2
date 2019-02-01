use "../"

class SDLgfxRenderer
  let renderer: SDLRenderer
  var antialising: Bool = true

  fun ref set_draw_color(color: SDLColor val): Bool =>
    renderer.set_draw_color(color)

  fun get_draw_color(): SDLColor val =>
    renderer.get_draw_color()

  fun ref clear(): Bool =>
    renderer.clear()

  fun ref present() =>
    renderer.present()

  fun ref enable_antialising() =>
    antialising = true

  fun ref disable_antialising() =>
    antialising = false

  new create(renderer': SDLRenderer ref) =>
    renderer = renderer'

  fun ref fill_rectangle(x: I16, y: I16, width: I16, height: I16, color: (SDLColor val | None) = None) =>
    let color' = _resolve_color(color)
    SDLgfx.render_box_rgba(renderer.get_raw(), x, y, x + width, y + height, color'.red(), color'.green(), color'.blue(), color'.alpha())

  fun ref fill_ellipse(x: I16, y: I16, r: I16, r': I16, color: (SDLColor val | None) = None) =>
    let color' = _resolve_color(color)
    SDLgfx.render_filled_ellipse(renderer.get_raw(), x, y, r, r', color'.red(), color'.green(), color'.blue(), color'.alpha())

  fun ref stroke_ellipse(x: I16, y: I16, r: I16, r': I16, color: (SDLColor val | None) = None) =>
    let color' = _resolve_color(color)
    if antialising then
      SDLgfx.render_aa_ellipse(renderer.get_raw(), x, y, r, r', color'.red(), color'.green(), color'.blue(), color'.alpha())
    else
      SDLgfx.render_ellipse(renderer.get_raw(), x, y, r, r', color'.red(), color'.green(), color'.blue(), color'.alpha())
    end

  fun ref fill_circle(x: I16, y: I16, r: I16, color: (SDLColor val | None) = None) =>
    let color' = _resolve_color(color)
    SDLgfx.render_filled_circle(renderer.get_raw(), x, y, r, color'.red(), color'.green(), color'.blue(), color'.alpha())

  fun ref stroke_circle(x: I16, y: I16, r: I16, color: (SDLColor val | None) = None) =>
    let color' = _resolve_color(color)
    if antialising then
      SDLgfx.render_aa_circle(renderer.get_raw(), x, y, r, color'.red(), color'.green(), color'.blue(), color'.alpha())
    else
      SDLgfx.render_circle(renderer.get_raw(), x, y, r, color'.red(), color'.green(), color'.blue(), color'.alpha())
    end

  fun _resolve_color(color: (SDLColor val | None)): SDLColor val =>
    match color
    | let c: SDLColor val => c
    | None => renderer.get_draw_color()
    end
