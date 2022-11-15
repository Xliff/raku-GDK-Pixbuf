use v6.c;

use Method::Also;
use NativeCall;

use GDK::Pixbuf::Raw::Types;
use GDK::Pixbuf::Raw::Animation;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GDK::Pixbuf::Animation::Iter { ... }

our subset GdkPixbufAnimationAncestry is export of Mu
  where GdkPixbufAnimation | GObject;

class GDK::Pixbuf::Animation {
  also does GLib::Roles::Object;

  has GdkPixbufAnimation $!gpa is implementor;

  submethod BUILD ( :$gdk-pixbuf-anim ) {
    self.setGdkPixbufAnimation($gdk-pixbuf-anim) if $gdk-pixbuf-anim
  }

  method setGdkPixbufAnimation (GdkPixbufAnimationAncestry $_) {
    my $to-parent;

    $!gpa = do {
      when GdkPixbufAnimation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkPixbufAnimation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Pixbuf::Raw::Definitions::GdkPixbufAnimation
    is also<GdkPixbufAnimation>
  { $!gpa }

  multi method new (
    GdkPixbufAnimationAncestry  $gdk-pixbuf-anim,
                               :$ref              = True
  ) {
    return unless $gdk-pixbuf-anim;

    my $o = self.bless( :$gdk-pixbuf-anim );
    $o.ref if $ref;
    $o;
  }

  method new_from_file (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<new-from-file>
  {
    clear_error;
    my $gdk-pixbuf-anim = gdk_pixbuf_animation_new_from_file(
      $filename,
      $error
    );

    $gdk-pixbuf-anim ?? self.bless( :$gdk-pixbuf-anim ) !! Nil;
  }

  method new_from_file_utf8 (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<new-from-file-utf8>
  {
    clear_error;
    my $gdk-pixbuf-anim = gdk_pixbuf_animation_new_from_file_utf8(
      $filename,
      $error
    );
    set_error($error);

    $gdk-pixbuf-anim ?? self.bless( :$gdk-pixbuf-anim ) !! Nil;
  }

  method new_from_resource (
    Str()                   $resource_path,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<new-from-resource>
  {
    clear_error;
    my $gdk-pixbuf-anim = gdk_pixbuf_animation_new_from_resource(
      $resource_path,
      $error
    );
    set_error($error);

    $gdk-pixbuf-anim ?? self.bless( :$gdk-pixbuf-anim ) !! Nil;
  }

  method new_from_stream (
    GInputStream()          $stream,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<new-from-stream>
  {
    clear_error;
    my $gdk-pixbuf-anim = gdk_pixbuf_animation_new_from_stream(
      $stream,
      $cancellable,
      $error
    );
    set_error($error);

    $gdk-pixbuf-anim ?? self.bless( :$gdk-pixbuf-anim ) !! Nil;
  }

  proto method new_from_stream_async (|)
    is also<new-from-stream-async>
  { * }

  multi method new_from_stream_async (
    GInputStream()  $stream,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable() :$cancellable  = GCancellable
  ) {
    samewith($stream, $cancellable, &callback, $user_data);
  }
  multi method new_from_stream_async (
    GInputStream() $stream,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gdk_pixbuf_animation_new_from_stream_async(
      $stream,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method new_from_stream_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<new-from-stream-finish>
  {
    clear_error;
    my $gdk-pixbuf-anim = gdk_pixbuf_animation_new_from_stream_finish(
      $async_result,
      $error
    );
    set_error($error);
    $gdk-pixbuf-anim ?? self.bless( :$gdk-pixbuf-anim ) !! Nil;
  }

  method get_height is also<get-height> {
    gdk_pixbuf_animation_get_height($!gpa);
  }

  method get_iter (Int() $start_time, :$raw = False)
    is also<get-iter>
  {
    my GTimeVal $s = $start_time;

    propReturnObject(
      gdk_pixbuf_animation_get_iter($!gpa, $s),
      $raw,
      |GDK::Pixbuf::Animation::Iter.getTypePair
    );
  }

  method get_static_image ( :$raw = False ) is also<get-static-image> {
    propReturnObject(
      gdk_pixbuf_animation_get_static_image($!gpa),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_animation_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gdk_pixbuf_animation_get_width($!gpa);
  }

  method is_static_image is also<is-static-image> {
    so gdk_pixbuf_animation_is_static_image($!gpa);
  }

  method old-ref
    is DEPRECATED<g_object_ref>

    is also<old_ref>
  {
    gdk_pixbuf_animation_ref($!gpa);
    self
  }

  method old-unref
    is DEPRECATED<g_object_unref>

    is also<old_unref>
  {
    gdk_pixbuf_animation_unref($!gpa);
  }
}

class GDK::Pixbuf::Animation::Iter {
  also does GLib::Roles::Implementor;

  has GdkPixbufAnimationIter $!gpai;

  submethod BUILD ( :$gdk-animation-iter ) {
    $!gpai = $gdk-animation-iter if $gdk-animation-iter
  }

  method new (GdkPixbufAnimationIter $gdk-animation-iter) {
    $gdk-animation-iter ?? self.bless( :$gdk-animation-iter ) !! Nil;
  }

  method advance (Int() $current_time) {
    my GTimeVal $c = $current_time;

    gdk_pixbuf_animation_iter_advance($!gpai, $c);
  }

  method get_delay_time is also<get-delay-time> {
    gdk_pixbuf_animation_iter_get_delay_time($!gpai);
  }

  method get_pixbuf ( :$raw = False ) is also<get-pixbuf> {
    propReturnObject(
      gdk_pixbuf_animation_iter_get_pixbuf($!gpai),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdk_pixbuf_animation_iter_get_type,
      $n,
      $t
    );
  }

  method on_currently_loading_frame is also<on-currently-loading-frame> {
    gdk_pixbuf_animation_iter_on_currently_loading_frame($!gpai);
  }

}

# cw: Class needs completion!
class GDK::Pixbuf::NonAnim {

  method get_type is also<get-type> {
    gdk_pixbuf_non_anim_get_type();
  }

  method new (GdkPixbuf() $pixbuf) {
    gdk_pixbuf_non_anim_new($pixbuf);
  }

}
