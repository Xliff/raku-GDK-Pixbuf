use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Pixbuf::Raw::Loader;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GDK::Pixbuf::Loader {
  also does GLib::Roles::Object;

  has GdkPixbufLoader $!gpl is implementor;

  method new {
    my $gdk-pixbuf-loader = gdk_pixbuf_loader_new();

    $gdk-pixbuf-loader ?? self.bless( :$gdk-pixbuf-loader ) !! Nil;
  }

  method new_with_mime_type (
    Str()                   $mime_type,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $gdk-pixbuf-loader = gdk_pixbuf_loader_new_with_mime_type(
      $mime_type,
      $error
    );
    set_error($error);

    $gdk-pixbuf-loader ?? self.bless( :$gdk-pixbuf-loader ) !! Nil;
  }

  method new_with_type (
    Str()                   $image_type,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $gdk-pixbuf-loader = gdk_pixbuf_loader_new_with_type(
      $image_type,
      $error
    );
    set_error($error);

    $gdk-pixbuf-loader ?? self.bless( :$gdk-pixbuf-loader ) !! Nil;
  }

  method close (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = gdk_pixbuf_loader_close($!gpl, $error);
    set_error($error);
    $rv;
  }

  method get_animation ( :$raw = False ) {
    propReturnObject(
      gdk_pixbuf_loader_get_animation($!gpl),
      $raw,
      |::('GDK::Pixbuf::Animation').getTypePair
    );
  }

  method get_format ( :$raw = False ) {
    propReturnObject(
      gdk_pixbuf_loader_get_format($!gpl),
      $raw,
      |::('GDK::Pixbuf::Format').getTypePair
    );
  }

  method get_pixbuf ( :$raw = False ) {
    propReturnObject(
      gdk_pixbuf_loader_get_pixbuf($!gpl),
      $raw,
      |::('GDK::Pixbuf').getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_loader_get_type, $n, $t );
  }

  method set_size (Int() $width, Int() $height)  {
    my gint ($w, $h) = ($width, $height);

    gdk_pixbuf_loader_set_size($!gpl, $w, $h);
  }

  multi method write (
    Str                      $buf,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$encoding = 'utf8'
  ) {
    samewith( $buf.encode($encoding), $buf.chars, $error);
  }
  multi method write (
    Blob                    $buf,
    CArray[Pointer[GError]] $error
  ) {
    samewith( CArray[uint8].new($buf), $buf.bytes, $error );
  }
  multi method write (
                            @buf,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(
      ArrayToCArray(uint8, @buf),
      @buf.elems,
      $error;
    );
  }
  multi method write (
    CArray[uint8]           $buf,
    Int()                   $count,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    samewith(cast(gpointer, $buf), $count, $error);
  }
  multi method write (
    gpointer                $buf,
    Int()                   $count,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    my gsize $c = $count;

    gdk_pixbuf_loader_write($!gpl, $buf, $c, $error);
  }

  method write_bytes (
    GBytes()                $buffer,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = gdk_pixbuf_loader_write_bytes($!gpl, $buffer, $error);
    set_error($error);
    $rv;
  }

}
