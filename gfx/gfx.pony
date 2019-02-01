use "../"

use @boxRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, x': I16, y': I16, red: U8, green: U8, blue: U8, alpha: U8)
use @filledEllipseRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, r': I16, red: U8, green: U8, blue: U8, alpha: U8)
use @ellipseRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, r': I16, red: U8, green: U8, blue: U8, alpha: U8)
use @aaellipseRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, r': I16, red: U8, green: U8, blue: U8, alpha: U8)
use @filledCircleRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, red: U8, green: U8, blue: U8, alpha: U8)
use @circleRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, red: U8, green: U8, blue: U8, alpha: U8)
use @aacircleRGBA[I32](surface: RawSDLRenderer ref, x: I16, y: I16, r: I16, red: U8, green: U8, blue: U8, alpha: U8)

primitive SDLgfx
  fun render_box_rgba(renderer: RawSDLRenderer ref, x: I16, y: I16, x': I16, y': I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @boxRGBA(renderer, x, y, x', y', r, g, b, a) == 0

  fun render_filled_ellipse(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, radius': I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @filledEllipseRGBA(renderer, x, y, radius, radius', r, g, b, a) == 0

  fun render_aa_ellipse(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, radius': I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @aaellipseRGBA(renderer, x, y, radius, radius', r, g, b, a) == 0

  fun render_ellipse(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, radius': I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @ellipseRGBA(renderer, x, y, radius, radius', r, g, b, a) == 0

  fun render_filled_circle(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @filledCircleRGBA(renderer, x, y, radius, r, g, b, a) == 0

  fun render_circle(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @circleRGBA(renderer, x, y, radius, r, g, b, a) == 0

  fun render_aa_circle(renderer: RawSDLRenderer ref, x: I16, y: I16, radius: I16, r: U8, g: U8, b: U8, a: U8): Bool =>
    @aacircleRGBA(renderer, x, y, radius, r, g, b, a) == 0
