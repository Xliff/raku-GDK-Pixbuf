use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Pixbuf::Raw::Enums;
use GDK::Pixbuf::Raw::Structs;

unit package GDK::Pixbuf::Raw::Loader;

### /usr/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf-loader.h

sub gdk_pixbuf_loader_close (
  GdkPixbufLoader         $loader,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_get_animation (GdkPixbufLoader $loader)
  returns GdkPixbufAnimation
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_get_format (GdkPixbufLoader $loader)
  returns GdkPixbufFormat
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_get_pixbuf (GdkPixbufLoader $loader)
  returns GdkPixbuf
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_get_type
  returns GType
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_new
  returns GdkPixbufLoader
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_new_with_mime_type (
  Str                     $mime_type,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufLoader
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_new_with_type (
  Str                     $image_type,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbufLoader
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_set_size (
  GdkPixbufLoader $loader,
  gint            $width,
  gint            $height
)
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_write (
  GdkPixbufLoader         $loader,
  gpointer                $buf,
  gsize                   $count,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }

sub gdk_pixbuf_loader_write_bytes (
  GdkPixbufLoader         $loader,
  GBytes                  $buffer,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk-pixbuf)
  is      export
{ * }
