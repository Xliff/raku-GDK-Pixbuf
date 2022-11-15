use v6.c;

use GDK::Pixbuf::Raw::Types;
use GDK::Pixbuf::Raw::Animation::Simple;

use GDK::Pixbuf::Animation;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GDK::Pixbuf::Animation::Simple::Iter { ... }

class GDK::Pixbuf::Animation::Simple {
  also does GLib::Roles::Object;

  has GdkPixbufSimpleAnim $!gdk-pb-sa is implementor;

  multi method new (Int() $width, Int() $height, Num() $rate) {
    my gint   ($w, $h) = ($width, $height);
    my gfloat  $r      =  $rate;

    my $gdk-pix-simple-anim = gdk_pixbuf_simple_anim_new($w, $h, $r);

    $gdk-pix-simple-anim ?? self.bless( :$gdk-pix-simple-anim ) !! Nil;
  }

  method add_frame (
    GdkPixbufSimpleAnim() $animation,
    GdkPixbuf()           $pixbuf
  ) {
    gdk_pixbuf_simple_anim_add_frame($!gdk-pb-sa, $pixbuf);
  }

  method get_iter (Int() $start_time, :$raw = False) {
    propReturnObject(
      nextwith( $start_time, :raw ),
      $raw,
      |GDK::Pixbug::Animation::Simple.getTypePair
    );
  }

  method get_loop {
    so gdk_pixbuf_simple_anim_get_loop($!gdk-pb-sa);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_simple_anim_get_type, $n, $t );
  }

  method set_loop (Int() $loop) {
    my gboolean $l = $loop.so.Int;

    gdk_pixbuf_simple_anim_set_loop($!gdk-pb-sa, $l);
  }

}

class GDK::Pixbuf::Animation::Simple::Iter is GDK::Pixbuf::Animation::Iter {

  method new (
    GdkPixbufSimpleAnimIter  $gdk-pix-simple-anim-iter,
                            :$ref                       = True
   ) {
    $gdk-pix-simple-anim-iter ?? self.bless( :$gdk-pix-simple-anim-iter )
                              !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdk_pixbuf_simple_anim_iter_get_type,
      $n,
      $t
    );
  }

  method getTypePair {
    (GdkPixbufSimpleAnimIter, ::?CLASS)
  }

}
