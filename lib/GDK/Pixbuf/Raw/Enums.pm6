use v6.c;

use GLib::Raw::Definitions;

unit package GDK::Pixbuf::Raw::Enums;

constant GdkColorspace is export := guint32;
our enum GdkColorspaceEnum is export <
  GDK_COLORSPACE_RGB
>;

constant GdkInterpType is export := guint32;
our enum GdkInterpTypeEnum is export <
  GDK_INTERP_NEAREST
  GDK_INTERP_TILES
  GDK_INTERP_BILINEAR
  GDK_INTERP_HYPER
>;

constant GdkPixbufAlphaMode is export := guint32;
our enum GdkPixbufAlphaModeEnum is export <
  GDK_PIXBUF_ALPHA_BILEVEL
  GDK_PIXBUF_ALPHA_FULL
>;

constant GdkPixbufError is export := guint32;
our enum GdkPixbufErrorEnum is export <
  GDK_PIXBUF_ERROR_CORRUPT_IMAGE
  GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY
  GDK_PIXBUF_ERROR_BAD_OPTION
  GDK_PIXBUF_ERROR_UNKNOWN_TYPE
  GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION
  GDK_PIXBUF_ERROR_FAILED
  GDK_PIXBUF_ERROR_INCOMPLETE_ANIMATION
>;

constant GdkPixbufFormatFlags is export := guint32;
our enum GdkPixbufFormatFlagsEnum is export <
  GDK_PIXBUF_FORMAT_WRITABLE
  GDK_PIXBUF_FORMAT_SCALABLE
  GDK_PIXBUF_FORMAT_THREADSAFE
>;

constant GdkPixbufRotation is export := guint32;
our enum GdkPixbufRotationEnum is export <
  GDK_PIXBUF_ROTATE_NONE
  GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE
  GDK_PIXBUF_ROTATE_UPSIDEDOWN
  GDK_PIXBUF_ROTATE_CLOCKWISE
>;

constant GdkPixdataDumpType is export := guint32;
our enum GdkPixdataDumpTypeEnum is export <
  GDK_PIXDATA_DUMP_PIXDATA_STREAM
  GDK_PIXDATA_DUMP_PIXDATA_STRUCT
  GDK_PIXDATA_DUMP_MACROS
  GDK_PIXDATA_DUMP_GTYPES
  GDK_PIXDATA_DUMP_CTYPES
  GDK_PIXDATA_DUMP_STATIC
  GDK_PIXDATA_DUMP_CONST
  GDK_PIXDATA_DUMP_RLE_DECODER
>;

constant GdkPixdataType is export := guint32;
our enum GdkPixdataTypeEnum is export <
  GDK_PIXDATA_COLOR_TYPE_RGB
  GDK_PIXDATA_COLOR_TYPE_RGBA
  GDK_PIXDATA_COLOR_TYPE_MASK
  GDK_PIXDATA_SAMPLE_WIDTH_8
  GDK_PIXDATA_SAMPLE_WIDTH_MASK
  GDK_PIXDATA_ENCODING_RAW
  GDK_PIXDATA_ENCODING_RLE
  GDK_PIXDATA_ENCODING_MASK
>;
