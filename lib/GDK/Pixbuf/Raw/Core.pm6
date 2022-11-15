use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Pixbuf::Raw::Enums;
use GDK::Pixbuf::Raw::Structs;

unit package GDK::Pixbuf::Raw::Core;

### /usr/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf-core.h

sub gdk_pixbuf_add_alpha (
  GdkPixbuf $pixbuf,
  gboolean  $substitute_color,
  Str       $r,
  Str       $g,
  Str       $b
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_apply_embedded_orientation (GdkPixbuf $src)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_calculate_rowstride (
  GdkColorspace $colorspace,
  gboolean      $has_alpha,
  gint          $bits_per_sample,
  gint          $width,
  gint          $height
)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_copy (GdkPixbuf $pixbuf)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_copy_area (
  GdkPixbuf $src_pixbuf,
  gint      $src_x,
  gint      $src_y,
  gint      $width,
  gint      $height,
  GdkPixbuf $dest_pixbuf,
  gint      $dest_x,
  gint      $dest_y
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_copy_options (
  GdkPixbuf $src_pixbuf,
  GdkPixbuf $dest_pixbuf
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_error_quark
  returns GQuark
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_fill (
  GdkPixbuf $pixbuf,
  guint32   $pixel
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_bits_per_sample (GdkPixbuf $pixbuf)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_byte_length (GdkPixbuf $pixbuf)
  returns gsize
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_colorspace (GdkPixbuf $pixbuf)
  returns GdkColorspace
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_has_alpha (GdkPixbuf $pixbuf)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_height (GdkPixbuf $pixbuf)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_n_channels (GdkPixbuf $pixbuf)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_option (
  GdkPixbuf $pixbuf,
  Str       $key
)
  returns Str
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_options (GdkPixbuf $pixbuf)
  returns GHashTable
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_pixels (GdkPixbuf $pixbuf)
  returns Str
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_pixels_with_length (
  GdkPixbuf $pixbuf,
  guint     $length is rw
)
  returns Str
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_rowstride (GdkPixbuf $pixbuf)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_type
  returns GType
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_get_width (GdkPixbuf $pixbuf)
  returns gint
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new (
  GdkColorspace $colorspace,
  gboolean      $has_alpha,
  gint          $bits_per_sample,
  gint          $width,
  gint          $height
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_bytes (
  GBytes        $data,
  GdkColorspace $colorspace,
  gboolean      $has_alpha,
  gint          $bits_per_sample,
  gint          $width,
  gint          $height,
  gint          $rowstride
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_data (
  CArray[uint8]          $data,
  GdkColorspace          $colorspace,
  gboolean               $has_alpha,
  gint                   $bits_per_sample,
  gint                   $width,
  gint                   $height,
  gint                   $rowstride,
                         &destroy_fn (gpointer),
  gpointer               $destroy_fn_data
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file (
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file_at_scale (
  Str                     $filename,
  gint                    $width,
  gint                    $height,
  gboolean                $preserve_aspect_ratio,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file_at_scale_utf8 (
  Str                     $filename,
  gint                    $width,
  gint                    $height,
  gboolean                $preserve_aspect_ratio,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file_at_size (
  Str                     $filename,
  gint                    $width,
  gint                    $height,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file_at_size_utf8 (
  Str                     $filename,
  gint                    $width,
  gint                    $height,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_file_utf8 (
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_inline (
  gint                    $data_length,
  CArray[guint8]          $data,
  gboolean                $copy_pixels,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_resource (
  Str                     $resource_path,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_resource_at_scale (
  Str                     $resource_path,
  gint                    $width,
  gint                    $height,
  gboolean                $preserve_aspect_ratio,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_stream (
  GInputStream            $stream,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_stream_async (
  GInputStream        $stream,
  GCancellable        $cancellable,
  GAsyncReadyCallback $callback,
  gpointer            $user_data
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_stream_at_scale (
  GInputStream            $stream,
  gint                    $width,
  gint                    $height,
  gboolean                $preserve_aspect_ratio,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_stream_at_scale_async (
  GInputStream        $stream,
  gint                $width,
  gint                $height,
  gboolean            $preserve_aspect_ratio,
  GCancellable        $cancellable,
  GAsyncReadyCallback $callback,
  gpointer            $user_data
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_stream_finish (
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_from_xpm_data (CArray[Str] $data)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_new_subpixbuf (
  GdkPixbuf $src_pixbuf,
  gint      $src_x,
  gint      $src_y,
  gint      $width,
  gint      $height
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_read_pixel_bytes (GdkPixbuf $pixbuf)
  returns GBytes
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_read_pixels (GdkPixbuf $pixbuf)
  returns guint8
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_ref (GdkPixbuf $pixbuf)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_remove_option (
  GdkPixbuf $pixbuf,
  Str       $key
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_saturate_and_pixelate (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  gfloat    $saturation,
  gboolean  $pixelate
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save (
  GdkPixbuf               $pixbuf,
  Str                     $filename,
  Str                     $type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_buffer (
  GdkPixbuf               $pixbuf,
  CArray[Str]             $buffer,
  gsize                   $buffer_size,
  Str                     $type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_bufferv (
  GdkPixbuf               $pixbuf,
  CArray[Str]             $buffer,
  gsize                   $buffer_size,
  Str                     $type,
  CArray[Str]             $option_keys,
  CArray[Str]             $option_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_callback (
  GdkPixbuf               $pixbuf,
                          &save_func (
                            Str,
                            gsize,
                            CArray[Pointer[GError]],
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data,
  Str                     $type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_callbackv (
  GdkPixbuf               $pixbuf,
                          &save_func (
                            Str,
                            gsize,
                            CArray[Pointer[GError]],
                            gpointer
                            --> gboolean
                          ),
  gpointer                $user_data,
  Str                     $type,
  CArray[Str]             $option_keys,
  CArray[Str]             $option_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_stream (
  GdkPixbuf               $pixbuf,
  GOutputStream           $stream,
  Str                     $type,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_stream_async (
  GdkPixbuf           $pixbuf,
  GOutputStream       $stream,
  Str                 $type,
  GCancellable        $cancellable,
                      &callback (GdkPixbuf, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_stream_finish (
  GAsyncResult            $async_result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_streamv (
  GdkPixbuf               $pixbuf,
  GOutputStream           $stream,
  Str                     $type,
  CArray[Str]             $option_keys,
  CArray[Str]             $option_values,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_save_to_streamv_async (
  GdkPixbuf           $pixbuf,
  GOutputStream       $stream,
  Str                 $type,
  CArray[Str]         $option_keys,
  CArray[Str]         $option_values,
  GCancellable        $cancellable,
                      &callback (GdkPixbuf, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_savev (
  GdkPixbuf               $pixbuf,
  Str                     $filename,
  Str                     $type,
  CArray[Str]             $option_keys,
  CArray[Str]             $option_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_savev_utf8 (
  GdkPixbuf               $pixbuf,
  Str                     $filename,
  Str                     $type,
  CArray[Str]             $option_keys,
  CArray[Str]             $option_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_set_option (
  GdkPixbuf $pixbuf,
  Str       $key,
  Str       $value
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_unref (GdkPixbuf $pixbuf)
  is      native(gdk-pixbuf)
  is      export
{ * }
