use "../"

primitive _TTFFont
type TTFFontRaw is (Pointer[_TTFFont tag])

class TTFFont
  let _raw: TTFFontRaw ref
  var _style: TTFStyle
  var _outline: I32
  var _hinting: TTFHinting
  var _kerning: Bool

  new create(raw: TTFFontRaw ref) =>
    _raw = raw
    _style = SDLttf.get_style(raw)
    _outline = SDLttf.get_outline(raw)
    _hinting = SDLttf.get_hinting(raw)
    _kerning = SDLttf.get_kerning(raw)

  fun get_style(): TTFStyle box =>
    _style

  fun ref set_style(style': TTFStyle) =>
    if _style != style' then
      _style = style'
      SDLttf.set_style(_raw, _style)
    end

  fun get_outline(): I32 =>
    _outline

  fun ref set_outline(outline': I32) =>
    if _outline != outline' then
      _outline = outline'
      SDLttf.set_outline(_raw, _outline)
    end

  fun get_hinting(): TTFHinting =>
    _hinting

  fun ref set_hinting(hinting': TTFHinting) =>
    if not (_hinting is hinting') then
      _hinting = hinting'
      SDLttf.set_hinting(_raw, _hinting)
    end

  fun get_kerning(): Bool =>
    _kerning

  fun ref set_kerning(kerning': Bool) =>
    if _kerning != kerning' then
      _kerning = kerning'
      SDLttf.set_kerning(_raw, _kerning)
    end

  fun get_height(): I32 =>
    SDLttf.get_height(_raw)

  fun get_ascent(): I32 =>
    SDLttf.get_ascent(_raw)

  fun get_descent(): I32 =>
    SDLttf.get_descent(_raw)

  fun get_line_skip(): I32 =>
    SDLttf.get_line_skip(_raw)

  fun get_font_faces(): I64 =>
    SDLttf.get_font_faces(_raw)

  fun get_font_face_is_fixed_width(): I32 =>
    SDLttf.get_font_face_is_fixed_width(_raw)

  fun get_font_face_family_name(): String ref =>
    SDLttf.get_font_face_family_name(_raw)

  fun get_font_face_style_name(): String ref =>
    SDLttf.get_font_face_style_name(_raw)

  fun glyph_is_provided(glyph: TTFGlyph): Bool =>
    match _convert_glyph(glyph)
    | let glyph': U16 => SDLttf.get_glyph_is_provided(_raw, glyph')
    else false
    end

  fun get_glyph_metrics(glyph: TTFGlyph): (TTFMetrics | None) =>
    match _convert_glyph(glyph)
    | let glyph': U16 => SDLttf.get_glyph_metrics(_raw, glyph')
    end

  fun _convert_glyph(glyph: TTFGlyph): (U16 | None) =>
    match glyph
    | let glyph': (U16 | U32) => glyph'.u16()
    | (let glyph': U32, let bytes: U8) =>
      if (glyph' == 0xFFFD) and (bytes == 1) then
        None
      elseif bytes > 2 then
        None
      else
        glyph'.u16()
      end
    end

  fun get_size(text: String val): ((I32, I32) | None) =>
    SDLttf.get_size(_raw, text)

  fun render(text: String val, mode: TTFRenderMode, foreground: SDLColor val, background: SDLColor val = SDLColor(0, 0, 0)): (SDLSurface | None) =>
    SDLttf.render(_raw, text, mode, foreground, background)

  fun print(renderer: SDLRenderer ref, coordinates: (I32, I32), position: (TTFPositionHorizontal, TTFPositionVertical), text: String val, mode: TTFRenderMode, foreground: SDLColor val, background: SDLColor val = SDLColor(0, 0, 0)): Bool =>
    SDLttf.print(_raw, renderer, coordinates, position, text, mode, foreground, background)

  fun _final() =>
    SDLttf.close_font(_raw)
