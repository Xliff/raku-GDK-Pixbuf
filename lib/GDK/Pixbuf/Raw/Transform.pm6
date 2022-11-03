use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Pixbuf::Raw::Enums;
use GDK::Pixbuf::Raw::Structs;

unit package GDK::Pixbuf::Raw::Transform;

### /usr/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf-transform.h

sub gdk_pixbuf_composite (
  GdkPixbuf     $src,
  GdkPixbuf     $dest,
  gint          $dest_x,
  gint          $dest_y,
  gint          $dest_width,
  gint          $dest_height,
  gdouble       $offset_x,
  gdouble       $offset_y,
  gdouble       $scale_x,
  gdouble       $scale_y,
  GdkInterpType $interp_type,
  gint          $overall_alpha
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_composite_color (
  GdkPixbuf     $src,
  GdkPixbuf     $dest,
  gint          $dest_x,
  gint          $dest_y,
  gint          $dest_width,
  gint          $dest_height,
  gdouble       $offset_x,
  gdouble       $offset_y,
  gdouble       $scale_x,
  gdouble       $scale_y,
  GdkInterpType $interp_type,
  gint          $overall_alpha,
  gint          $check_x,
  gint          $check_y,
  gint          $check_size,
  guint32       $color1,
  guint32       $color2
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_composite_color_simple (
  GdkPixbuf     $src,
  gint          $dest_width,
  gint          $dest_height,
  GdkInterpType $interp_type,
  gint          $overall_alpha,
  gint          $check_size,
  guint32       $color1,
  guint32       $color2
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_flip (
  GdkPixbuf $src,
  gboolean  $horizontal
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_rotate_simple (
  GdkPixbuf         $src,
  GdkPixbufRotation $angle
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_scale (
  GdkPixbuf     $src,
  GdkPixbuf     $dest,
  gint          $dest_x,
  gint          $dest_y,
  gint          $dest_width,
  gint          $dest_height,
  gdouble       $offset_x,
  gdouble       $offset_y,
  gdouble       $scale_x,
  gdouble       $scale_y,
  GdkInterpType $interp_type
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_scale_simple (
  GdkPixbuf     $src,
  gint          $dest_width,
  gint          $dest_height,
  GdkInterpType $interp_type
)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }
