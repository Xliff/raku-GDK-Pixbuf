use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Pixbuf::Raw::Enums;

unit package GDK::Pixbuf::Raw::SimpleAnim;

### /usr/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf-simple-anim.h

sub gdk_pixbuf_simple_anim_add_frame (
  GdkPixbufSimpleAnim $animation,
  GdkPixbuf           $pixbuf
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_simple_anim_get_loop (GdkPixbufSimpleAnim $animation)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_simple_anim_get_type
  returns GType
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_simple_anim_iter_get_type
  returns GType
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_simple_anim_new (
  gint   $width,
  gint   $height,
  gfloat $rate
)
  returns GdkPixbufSimpleAnim
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_simple_anim_set_loop (
  GdkPixbufSimpleAnim $animation,
  gboolean            $loop
)
  is      native(gdk-pixbuf)
  is      export
{ * }
