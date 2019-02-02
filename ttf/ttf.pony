use "lib:SDL2_ttf"
use "../"

use @TTF_Linked_Version[SDLVersion]()
use @TTF_Init[I32]()
use @TTF_WasInit[I32]()
use @TTF_Quit[None]()
use @TTF_GetError[Pointer[U8]]()
use @TTF_OpenFont[Pointer[_TTFFont tag] ref](file: Pointer[U8] tag, size: I32)
use @TTF_OpenFontIndex[Pointer[_TTFFont tag] ref](file: Pointer[U8] tag, size: I32, index: I64)
use @TTF_CloseFont[None](font: Pointer[_TTFFont tag] box)
use @TTF_ByteSwappedUNICODE[None](swapped: I32)
use @TTF_GetFontStyle[I32](font: Pointer[_TTFFont tag] box)
use @TTF_SetFontStyle[None](font: Pointer[_TTFFont tag] ref, style: I32)
use @TTF_GetFontOutline[I32](font: Pointer[_TTFFont tag] box)
use @TTF_SetFontOutline[None](font: Pointer[_TTFFont tag] box, outline: I32)
use @TTF_GetFontHinting[I32](font: Pointer[_TTFFont tag] box)
use @TTF_SetFontHinting[None](font: Pointer[_TTFFont tag] box, outline: I32)

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

  fun get_style(font: Pointer[_TTFFont tag] box): TTFStyle =>
    TTFStyle.from_raw(@TTF_GetFontStyle(font))

  fun set_byte_swapped_unicode(swapped: Bool) =>
    @TTF_ByteSwappedUNICODE(if swapped then 1 else 0 end)

  fun set_style(font: Pointer[_TTFFont tag] ref, style: TTFStyle) =>
    @TTF_SetFontStyle(font, style.to_raw())

  fun get_outline(font: Pointer[_TTFFont tag] box): I32 =>
    @TTF_GetFontOutline(font)

  fun set_outline(font: Pointer[_TTFFont tag] ref, outline: I32) =>
    @TTF_SetFontOutline(font, outline)

  fun get_hinting(font: Pointer[_TTFFont tag] box): TTFHinting =>
    match @TTF_GetFontHinting(font)
    | 0 => TTFHintingNormal
    | 1 => TTFHintingLight
    | 2 => TTFHintingMono
    | 3 => None
    | let x: I32 val => x
    // | let x: I32 => x
    end

  fun set_hinting(font: Pointer[_TTFFont tag] ref, hinting: TTFHinting) =>
    @TTF_SetFontHinting(font, match hinting
      | TTFHintingNormal => 0
      | TTFHintingLight => 1
      | TTFHintingMono => 2
      | None => 3
      | let x: I32 val => x
    end)

primitive _TTFFont

class TTFFont
  let _raw: Pointer[_TTFFont tag] ref
  var style: TTFStyle
  var outline: I32
  var hinting: TTFHinting

  new create(raw: Pointer[_TTFFont tag] ref) =>
    _raw = raw
    style = SDLttf.get_style(raw)
    outline = SDLttf.get_outline(raw)
    hinting = SDLttf.get_hinting(raw)

  fun _final() =>
    @TTF_CloseFont(_raw)

  fun get_style(): TTFStyle =>
    SDLttf.get_style(_raw)

  fun ref set_style(style': TTFStyle) =>
    if style != style' then
      style = style'
      SDLttf.set_style(_raw, style)
    end

  fun get_outline(): I32 =>
    SDLttf.get_outline(_raw)

  fun ref set_outline(outline': I32) =>
    if outline != outline' then
      outline = outline'
      SDLttf.set_outline(_raw, outline)
    end

  fun get_hinting(): TTFHinting =>
    SDLttf.get_hinting(_raw)

  fun ref set_hinting(hinting': TTFHinting) =>
    if hinting is hinting' then
      hinting = hinting'
      SDLttf.set_hinting(_raw, hinting)
    end

primitive TTFHintingNormal
primitive TTFHintingLight
primitive TTFHintingMono

type TTFHinting is (TTFHintingNormal | TTFHintingLight | TTFHintingMono | None | I32 val)

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
