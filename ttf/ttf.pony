use "lib:SDL2_ttf"
use "../"

use @TTF_Linked_Version[SDLVersion]()
use @TTF_Init[I32]()
use @TTF_WasInit[I32]()
use @TTF_Quit[None]()
use @TTF_GetError[Pointer[U8]]()

use @TTF_OpenFont[TTFFontRaw ref](file: Pointer[U8] tag, size: I32)
use @TTF_OpenFontIndex[TTFFontRaw ref](file: Pointer[U8] tag, size: I32, index: I64)
use @TTF_CloseFont[None](font: TTFFontRaw box)

use @TTF_ByteSwappedUNICODE[None](swapped: I32)

use @TTF_GetFontStyle[I32](font: TTFFontRaw box)
use @TTF_SetFontStyle[None](font: TTFFontRaw ref, style: I32)
use @TTF_GetFontOutline[I32](font: TTFFontRaw box)
use @TTF_SetFontOutline[None](font: TTFFontRaw ref, outline: I32)
use @TTF_GetFontHinting[I32](font: TTFFontRaw box)
use @TTF_SetFontHinting[None](font: TTFFontRaw ref, hinting: I32)
use @TTF_GetFontKerning[I32](font: TTFFontRaw box)
use @TTF_SetFontKerning[None](font: TTFFontRaw ref, kerning: I32)

use @TTF_FontHeight[I32](font: TTFFontRaw box)
use @TTF_FontAscent[I32](font: TTFFontRaw box)
use @TTF_FontDescent[I32](font: TTFFontRaw box)
use @TTF_FontLineSkip[I32](font: TTFFontRaw box)

use @TTF_FontFaces[I64](font: TTFFontRaw box)
use @TTF_FontFaceIsFixedWidth[I32](font: TTFFontRaw box)
use @TTF_FontFaceFamilyName[Pointer[U8]](font: TTFFontRaw box)
use @TTF_FontFaceStyleName[Pointer[U8]](font: TTFFontRaw box)

use @TTF_GlyphIsProvided[I32](font: TTFFontRaw box, char: U16)
use @TTF_GlyphMetrics[I32](font: TTFFontRaw box, char: U16, x_min: Pointer[I32], x_max: Pointer[I32], y_min: Pointer[I32], y_max: Pointer[I32], advance: Pointer[I32])

use @TTF_SizeUTF8[I32](font: TTFFontRaw box, text: Pointer[U8] tag, width: Pointer[I32], height: Pointer[I32])

// Pony uses UTF8 for their strings
use @TTF_RenderUTF8_Solid[SDLSurfaceRaw](font: TTFFontRaw box, text: Pointer[U8] tag, foreground: SDLColorRaw)
use @TTF_RenderUTF8_Shaded[SDLSurfaceRaw](font: TTFFontRaw box, text: Pointer[U8] tag, foreground: SDLColorRaw, background: SDLColorRaw)
use @TTF_RenderUTF8_Blended[SDLSurfaceRaw](font: TTFFontRaw box, text: Pointer[U8] tag, foreground: SDLColorRaw)

primitive SDLttf
  fun version(): (U8, U8, U8) =>
    let ver = @TTF_Linked_Version()
    (ver.major, ver.minor, ver.patch)

  fun init()? =>
    if not was_init() then
      if @TTF_Init() == -1 then
        error
      end
    end

  fun was_init(): Bool =>
    @TTF_WasInit() != 0

  fun quit() =>
    if was_init() then @TTF_Quit() end

  fun _final() =>
    quit()

  fun get_error(): String ref =>
    let s = @TTF_GetError()
    String.from_cstring(s)

  fun open_font(file: String val, size: I32): (TTFFont | None) =>
    let ptr = @TTF_OpenFont(file.cstring(), size)
    if ptr.is_null() then None else TTFFont(consume ptr) end

  // todo open_font_rw

  fun open_font_index(file: String val, size: I32, index: I64): (TTFFont | None) =>
    let ptr = @TTF_OpenFontIndex(file.cstring(), size, index)
    if ptr.is_null() then None else TTFFont(consume ptr) end

  fun get_style(font: TTFFontRaw box): TTFStyle =>
    TTFStyle.from_raw(@TTF_GetFontStyle(font))

  fun set_byte_swapped_unicode(swapped: Bool) =>
    @TTF_ByteSwappedUNICODE(if swapped then 1 else 0 end)

  fun set_style(font: TTFFontRaw ref, style: TTFStyle) =>
    @TTF_SetFontStyle(font, style.to_raw())

  fun get_outline(font: TTFFontRaw box): I32 =>
    @TTF_GetFontOutline(font)

  fun set_outline(font: TTFFontRaw ref, outline: I32) =>
    @TTF_SetFontOutline(font, outline)

  fun get_hinting(font: TTFFontRaw box): TTFHinting =>
    match @TTF_GetFontHinting(font)
    | 0 => TTFHintingNormal
    | 1 => TTFHintingLight
    | 2 => TTFHintingMono
    | 3 => None
    | let x: I32 val => x
    // | let x: I32 => x
    end

  fun set_hinting(font: TTFFontRaw ref, hinting: TTFHinting) =>
    @TTF_SetFontHinting(font, match hinting
      | TTFHintingNormal => 0
      | TTFHintingLight => 1
      | TTFHintingMono => 2
      | None => 3
      | let x: I32 val => x
    end)

  fun get_kerning(font: TTFFontRaw box): Bool =>
    @TTF_GetFontKerning(font) != 0

  fun set_kerning(font: TTFFontRaw ref, kerning: Bool) =>
    @TTF_SetFontKerning(font, if kerning then 1 else 0 end)

  fun get_height(font: TTFFontRaw box): I32 =>
    @TTF_FontHeight(font)

  fun get_ascent(font: TTFFontRaw box): I32 =>
    @TTF_FontAscent(font)

  fun get_descent(font: TTFFontRaw box): I32 =>
    @TTF_FontDescent(font)

  fun get_line_skip(font: TTFFontRaw box): I32 =>
    @TTF_FontLineSkip(font)

  fun get_font_faces(font: TTFFontRaw box): I64 =>
    @TTF_FontFaces(font)

  fun get_font_face_is_fixed_width(font: TTFFontRaw box): I32 =>
    @TTF_FontFaceIsFixedWidth(font)

  fun get_font_face_family_name(font: TTFFontRaw box): String ref =>
    String.from_cstring(@TTF_FontFaceFamilyName(font))

  fun get_font_face_style_name(font: TTFFontRaw box): String ref =>
    String.from_cstring(@TTF_FontFaceStyleName(font))

  fun get_glyph_is_provided(font: TTFFontRaw box, char: U16): Bool =>
    @TTF_GlyphIsProvided(font, char) != 0

  fun get_glyph_metrics(font: TTFFontRaw box, char: U16): (TTFMetrics | None) =>
    var x_min: I32 = 0
    var x_max: I32 = 0
    var y_min: I32 = 0
    var y_max: I32 = 0
    var advance: I32 = 0
    if @TTF_GlyphMetrics(font, char, addressof x_min, addressof x_max, addressof y_min, addressof y_max, addressof advance) == 0 then
      TTFMetrics(x_min, x_max, y_min, y_max, advance)
    else
      None
    end

  fun get_size(font: TTFFontRaw box, text: String val): ((I32, I32) | None) =>
    var width: I32 = 0
    var height: I32 = 0
    if @TTF_SizeUTF8(font, text.cstring(), addressof width, addressof height) == 0 then
      (width, height)
    else
      None
    end

  fun render(font: TTFFontRaw box, text: String val, mode: TTFRenderMode, foreground: SDLColor val, background: SDLColor val = SDLColor(0, 0, 0)): (SDLSurface | None) =>
    let res: SDLSurfaceRaw = match mode
    | TTFSolid => @TTF_RenderUTF8_Solid(font, text.cstring(), foreground.to_raw())
    | TTFShaded => @TTF_RenderUTF8_Shaded(font, text.cstring(), foreground.to_raw(), background.to_raw())
    | TTFBlended => @TTF_RenderUTF8_Blended(font, text.cstring(), foreground.to_raw())
    end
    if res.is_null() then
      None
    else
      SDLSurface(res)
    end

  fun print(font: TTFFontRaw box, renderer: SDLRenderer ref, coordinates: (I32, I32), position: (TTFPositionHorizontal, TTFPositionVertical), text: String val, mode: TTFRenderMode, foreground: SDLColor val, background: SDLColor val = SDLColor(0, 0, 0)): Bool =>
    // try to get the size of the text box; if error, it probably means that the input string has unrecognized glyphs
    match get_size(font, text)
    | (let width: I32, let height: I32) =>
      // position calculation
      let x = match position._1
      | TTFLeft => coordinates._1
      | TTFRight => coordinates._1 - width
      | TTFCenter => coordinates._1 - (width / 2)
      end

      let y = match position._2
      | TTFTop => coordinates._2
      | TTFBottom => coordinates._2 - height
      | TTFCenter => coordinates._2 - (height / 2)
      end

      // render the text to a surface
      match render(font, text, mode, foreground, background)
      | let surface: SDLSurface =>
        // convert the surface to a texture and copy it
        match renderer.texture_from_surface(surface)
        | let texture: SDLTexture => renderer.copy(texture, None, (x, y, width, height))
        | None => false
        end
      | None => false
      end
    | None => false
    end

  fun close_font(font: TTFFontRaw box) =>
    @TTF_CloseFont(font)


primitive TTFHintingNormal
primitive TTFHintingLight
primitive TTFHintingMono

type TTFHinting is (TTFHintingNormal | TTFHintingLight | TTFHintingMono | None | I32 val)

type TTFGlyph is (U16 | U32 | (U32, U8))

class TTFStyle
  let bold: Bool
  let italic: Bool
  let underline: Bool
  let strikethrough: Bool

  new create(bold': Bool = false, italic': Bool = false, underline': Bool = false, strikethrough': Bool = false) =>
    bold = bold'
    italic = italic'
    underline = underline'
    strikethrough = strikethrough'

  new from_raw(num: I32) =>
    bold = (num and 1) == 1
    italic = (num and 2) == 2
    underline = (num and 4) == 4
    strikethrough = (num and 8) == 8

  fun to_raw(): I32 =>
    (if bold then 1 else 0 end)
    + (if italic then 2 else 0 end)
    + (if underline then 4 else 0 end)
    + (if strikethrough then 8 else 0 end)

  fun eq(style: TTFStyle): Bool =>
    (bold == style.bold) and (italic == style.italic) and (underline == style.underline) and (strikethrough == style.strikethrough)

  fun ne(style: TTFStyle): Bool =>
    not eq(style)

class TTFMetrics
  let x_min: I32
  let x_max: I32
  let y_min: I32
  let y_max: I32
  let advance: I32

  new create(x_min': I32, x_max': I32, y_min': I32, y_max': I32, advance': I32) =>
    x_min = x_min'
    x_max = x_max'
    y_min = y_min'
    y_max = y_max'
    advance = advance'

primitive TTFSolid
primitive TTFShaded
primitive TTFBlended
type TTFRenderMode is (TTFSolid | TTFShaded | TTFBlended)

primitive TTFLeft
primitive TTFRight
primitive TTFCenter
primitive TTFTop
primitive TTFBottom
type TTFPositionHorizontal is (TTFLeft | TTFRight | TTFCenter)
type TTFPositionVertical is (TTFTop | TTFBottom | TTFCenter)
