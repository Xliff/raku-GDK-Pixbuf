use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Types;
use GDK::Pixbuf::Raw::Core;
use GDK::Pixbuf::Raw::Transform;

use GLib::Roles::Implementor;

class GDK::Pixbuf {
  also does GLib::Roles::Implementor;

  has GdkPixbuf $!gp is implementor;

  method new (
    Int() $colorspace,
    Int() $has_alpha,
    Int() $bits_per_sample,
    Int() $width,
    Int() $height
  ) {
    my GdkColorspace  $c          =  $colorspace;
    my gboolean       $a          =  $has_alpha.so.Int;
    my gint          ($b, $w, $h) = ($bits_per_sample, $width, $height);

    my $gdk-pixbuf = gdk_pixbuf_new($c, $a, $b, $w, $h);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_bytes (
    GBytes() $data,
    Int()    $colorspace,
    Int()    $has_alpha,
    Int()    $bits_per_sample,
    Int()    $width,
    Int()    $height,
    Int()    $rowstride
  ) {
    my GdkColorspace  $c =  $colorspace;
    my gboolean       $a =  $has_alpha.so.Int;

    my gint ($b, $w, $h, $r) =
      ($bits_per_sample, $width, $height, $rowstride);

    my $gdk-pixbuf = gdk_pixbuf_new_from_bytes($data, $c, $a, $b, $w, $h, $r);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  constant \DC = %DEFAULT-CALLBACKS;

  proto method new_from_data (|)
  { * }
  multi method new_from_data (
              $data              where *.^can('Str'),
    Int()     $colorspace,
    Int()     $has_alpha,
    Int()     $bits_per_sample,
    Int()     $width,
    Int()     $height,
    Int()     $rowstride,
    gpointer  $destroy_fn_data                         = gpointer,
              &destroy_fn                              = DC<GDestroyNotify>,
             :$encoding                                = 'utf8'
  ) {
    my $ldata = $data;
    $ldata .= Str unless $data ~~ Str;
    samewith(
      $ldata.encode($encoding),
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height,
      $rowstride,
      &destroy_fn,
      $destroy_fn_data
    )
  }
  multi method new_from_data (
    Blob           $data,
    Int()          $colorspace,
    Int()          $has_alpha,
    Int()          $bits_per_sample,
    Int()          $width,
    Int()          $height,
    Int()          $rowstride,
                   &destroy_fn        = DC<GDestroyNotify>,
    gpointer       $destroy_fn_data   = gpointer
  ) {
    samewith(
      CArray[uint8].new($data);
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height,
      $rowstride,
      &destroy_fn,
      $destroy_fn_data
    );
  }
  multi method new_from_data (
                   @data,
    Int()          $colorspace,
    Int()          $has_alpha,
    Int()          $bits_per_sample,
    Int()          $width,
    Int()          $height,
    Int()          $rowstride,
                   &destroy_fn        = DC<GDestroyNotify>,
    gpointer       $destroy_fn_data   = gpointer
  ) {
    samewith(
      ArrayToCArray(uint8, @data),
      $colorspace,
      $has_alpha,
      $bits_per_sample,
      $width,
      $height,
      $rowstride,
      &destroy_fn,
      $destroy_fn_data
    );
  }
  multi method new_from_data (
    CArray[uint8]  $data,
    Int()          $colorspace,
    Int()          $has_alpha,
    Int()          $bits_per_sample,
    Int()          $width,
    Int()          $height,
    Int()          $rowstride,
                   &destroy_fn        = DC<GDestroyNotify>,
    gpointer       $destroy_fn_data   = gpointer
  ) {
    my GdkColorspace  $c =  $colorspace;
    my gboolean       $a =  $has_alpha.so.Int;

    my gint ($b, $w, $h, $r) =
      ($bits_per_sample, $width, $height, $rowstride);

    my $gdk-pixbuf = gdk_pixbuf_new_from_data(
      $data,
      $c,
      $a,
      $b,
      $w,
      $h,
      $r,
      &destroy_fn,
      $destroy_fn_data
    );

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_file($!gp, $filename, $error);
    set_error($error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_scale (
    Str()                   $filename,
    Int()                   $width,
    Int()                   $height,
    Int()                   $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error                  = gerror
  ) {
    my gint     ($w, $h) = ($width, $height);
    my gboolean  $p      =  $preserve_aspect_ratio.so.Int;

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_file_at_scale(
      $filename,
      $w,
      $h,
      $p,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_scale_utf8 (
    Str()                   $filename,
    Int()                   $width,
    Int()                   $height,
    Int()                   $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error                  = gerror
  ) {
    my gint     ($w, $h) = ($width, $height);
    my gboolean  $p      =  $preserve_aspect_ratio.so.Int;

    my $gdk-pixbuf = gdk_pixbuf_new_from_file_at_scale_utf8(
      $filename,
      $w,
      $h,
      $p,
      $error
    );
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_size (
    Str()                   $filename,
    Int()                   $width,
    Int()                   $height,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my gint ($w, $h) = ($width, $height);

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_file_at_size(
      $filename,
      $w,
      $h,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_size_utf8 (
    Str()                   $filename,
    Int()                   $width,
    Int()                   $height,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my gint ($w, $h) = ($width, $height);

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_file_at_size_utf8(
      $filename,
      $w,
      $h,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_utf8 (
    Str()                   $filename,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_file_utf8($filename, $error);
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method new_from_inline (|)
  { * }

  multi method new_from_inline (
                             $data where *.^can('Str'),
    CArray[Pointer[GError]]  $error                     = gerror,
                            :$encoding                  = 'utf8',
    Int()                   :copy(:copy-pixels(
                              :$copy_pixels
                            ))                          = False
  ) {
    my $ldata = $data;
    $ldata .= Str unless $data ~~ Str;
    samewith(
       $ldata.encode($encoding),
       $error,
      :$copy_pixels
    );
  }
  multi method new_from_inline (
    Blob                     $data,
    CArray[Pointer[GError]]  $error               = gerror,
    Int()                   :copy(:copy-pixels(
                              :$copy_pixels
                            ))                    = False
  ) {
    samewith(
      $data.bytes,
      CArray[uint8].new($data),
      $copy_pixels,
      $error
    );
  }
  multi method new_from_inline (
                             @data,
    CArray[Pointer[GError]]  $error               = gerror,
    Int()                   :copy(:copy-pixels(
                              :$copy_pixels
                            ))                    = False
  ) {
    samewith(
      @data.elems,
      ArrayToCArray(uint8, @data),
      $copy_pixels,
      $error
    );
  }
  multi method new_from_inline (
    Int()                   $data_length,
    CArray[uint8]           $data         is rw,
    Int()                   $copy_pixels,
    CArray[Pointer[GError]] $error               = gerror
  ) {
    my gint     $d = $data_length;
    my gboolean $c = $copy_pixels;

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_inline($d, $data, $c, $error);
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_resource (
    Str()                   $resource_path,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_resource($resource_path, $error);
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_resource_at_scale (
    Str()                   $resource_path,
    Int()                   $width,
    Int()                   $height,
    Int()                   $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error                  = gerror
  ) {
    my gint     ($w, $h) = ($width, $height);
    my gboolean  $p      =  $preserve_aspect_ratio.so.Int;

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_resource_at_scale(
      $resource_path,
      $w,
      $h,
      $p,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream (
    GInputStream()          $stream,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_stream(
      $stream,
      $cancellable,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method new_from_stream_async (|)
  { * }

  multi method new_from_stream_async (
    GInputStream()  $stream,
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($stream, $cancellable, &callback, $user_data);
  }
  multi method new_from_stream_async (
    GInputStream() $stream,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    my $gdk-pixbuf = gdk_pixbuf_new_from_stream_async(
      $stream,
      $cancellable,
      &callback,
      $user_data
    );
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream_at_scale (
    GInputStream()          $stream,
    Int()                   $width,
    Int()                   $height,
    Int()                   $preserve_aspect_ratio,
    GCancellable()          $cancellable            = GCancellable,
    CArray[Pointer[GError]] $error                  = gerror
  ) {
    my gint     ($w, $h) = ($width, $height);
    my gboolean  $p      =  $preserve_aspect_ratio.so.Int;

    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_stream_at_scale(
      $stream,
      $w,
      $h,
      $p,
      $cancellable,
      $error
    );
    set_error($error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method new_from_stream_at_scale_async (|)
  { * }

  multi method new_from_stream_at_scale_async (
    GInputStream()  $stream,
    Int()           $width,
    Int()           $height,
                    &callback,
    gpointer        $user_data                         = gpointer,
    Int()          :preserve(:preserve-aspect-ration(
                      :$preserve_aspect_ratio
                    ))                                 = True,
    GCancellable() :$cancellable                       = GCancellable
  ) {
    samewith(
      $stream,
      $width,
      $height,
      $preserve_aspect_ratio,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new_from_stream_at_scale_async (
    GInputStream() $stream,
    Int()          $width,
    Int()          $height,
    Int()          $preserve_aspect_ratio,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data              = gpointer
  ) {
    my gint     ($w, $h) = ($width, $height);
    my gboolean  $p      =  $preserve_aspect_ratio.so.Int;

    my $gdk-pixbuf = gdk_pixbuf_new_from_stream_at_scale_async(
      $stream,
      $w,
      $h,
      $p,
      $cancellable,
      &callback,
      $user_data
    );
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $gdk-pixbuf = gdk_pixbuf_new_from_stream_finish(
      $!gp,
      $async_result,
      $error
    );
    set_error($error);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method new_from_xpm_data (|)
  { * }

  multi method new_from_xpm_data (Str() $data) {
    samewith($data.lines);
  }
  multi method new_from_xpm_data (@data) {
    samewith( ArrayToCArray(Str, @data) );
  }
  multi method new_from_xpm_data (CArray[Str] $data) {
    my $gdk-pixbuf = gdk_pixbuf_new_from_xpm_data($data);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_subpixbuf (
    GdkPixbuf() $src_pixbuf,
    Int()       $src_x,
    Int()       $src_y,
    Int()       $width,
    Int()       $height
  ) {
    my gint ($sx, $sy, $w, $h) = ($src_x, $src_y, $width, $height);

    my $gdk-pixbuf = gdk_pixbuf_new_subpixbuf($src_pixbuf, $sx, $sy, $w, $h);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method add_alpha (|)
  { * }

  multi method add_alpha {
    samewith(False, 0, 0, 0);
  }
  multi method add_alpha (
    Int()   $substitute_color,
    Str()   $r,
    Str()   $g,
    Str()   $b,
           :$raw               = False
  ) {
    my gboolean $s             =  $substitute_color;

    propReturnObject(
      gdk_pixbuf_add_alpha($!gp, $s, $r, $g, $b),
      $raw,
      |self.getTypePair
    );
  }

  method apply_embedded_orientation {
    gdk_pixbuf_apply_embedded_orientation($!gp);
  }

  method calculate_rowstride (
    GdkColorspace() $colorspace,
    Int()           $has_alpha,
    Int()           $bits_per_sample,
    Int()           $width,
    Int()           $height
  ) {
    my gboolean  $a          =  $has_alpha;
    my gint     ($b, $w, $h) = ($bits_per_sample, $width, $height);

    gdk_pixbuf_calculate_rowstride($!gp, $a, $b, $w, $h);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gdk_pixbuf_copy($!gp),
      $raw,
      |self.getTypePair
    );
  }

  proto method composite (|)
  { * }

  multi method composite (
    GdkPixbuf()                      $src,
    Int()       :x(    :dest-x(     :$dest_x))        = 0,
    Int()       :y(    :dest-y(     :$dest_y))        = 0,
    Int()       :w(    :dest-width( :$dest_width))    = gdk_pixbuf_get_width(
                                                          $src
                                                        ),
    Int()       :h(    :dest-height(:$dest_height))   = gdk_pixbuf_get_height(
                                                          $src
                                                        ),
    Num()       :o(                 :$offset)         = 0e0,
    Num()       :ox(   :offset-x(   :$offset_x))      = $offset,
    Num()       :oy(   :offset-y(   :$offset_y))      = $offset,
    Num()       :s(                 :$scale)          = 1e0,
    Num()       :sx(   :scale-x(    :$scale_x))       = $scale,
    Num()       :sy(   :scale-y(    :$scale_y))       = $scale,
    Int()       :type( :interp-type(:$interp_type))   = 0,
    Int()       :a(    :alpha(      :$overall_alpha)) = 255
  ) {
    samewith(
      $src,
      $dest_x,
      $dest_y,
      $dest_width,
      $dest_height,
      $offset_x,
      $offset_y,
      $scale_x,
      $scale_y,
      $interp_type,
      $overall_alpha
    )
  }
  multi method composite (
    GdkPixbuf() $src,
    Int()       $dest_x,
    Int()       $dest_y,
    Int()       $dest_width,
    Int()       $dest_height,
    Num()       $offset_x,
    Num()       $offset_y,
    Num()       $scale_x,
    Num()       $scale_y,
    Int()       $interp_type,
    Int()       $overall_alpha
  ) {
    my GdkInterpType $i = $interp_type;

    my gint ($x, $y, $dw, $dh, $o) =
      ($dest_x, $dest_y, $dest_width, $dest_height, $overall_alpha);

    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);

    gdk_pixbuf_composite(
      $src,
      $!gp,
      $x,
      $y,
      $dw,
      $dh,
      $ox,
      $oy,
      $sx,
      $sy,
      $i,
      $o
    );
    self;
  }

  proto method composite_color (|)
  { * }

  multi method composite_color (
    GdkPixbuf() $src,
    Int()       :x(    :dest-x(     :$dest_x))        = 0,
    Int()       :y(    :dest-y(     :$dest_y))        = 0,
    Int()       :w(    :dest-width( :$dest_width))    = gdk_pixbuf_get_width(
                                                          $src
                                                        ),
    Int()       :h(    :dest-height(:$dest_height))   = gdk_pixbuf_get_height(
                                                          $src
                                                        ),
    Num()       :o(                 :$offset)         = 0e0,
    Num()       :ox(   :offset-x(   :$offset_x))      = $offset,
    Num()       :oy(   :offset-y(   :$offset_y))      = $offset,
    Num()       :s(                 :$scale)          = 1e0,
    Num()       :sx(   :scale-x(    :$scale_x))       = $scale,
    Num()       :sy(   :scale-y(    :$scale_y))       = $scale,
    Int()       :type( :interp-type(:$interp_type))   = 0,
    Int()       :a(    :alpha(      :$overall_alpha)) = 255,
    Int()       :cx(   :check-x(    :$check_x))       = 0,
    Int()       :cy(   :check-y(    :$check_y))       = 0,
    Int()       :cs(   :check-size( :$check_size))    = (
                                                          $dest_width,
                                                          $dest_height
                                                        ).min.Int div 8,
    Int()       :c1(                 :$color1),
    Int()       :c2(                 :$color2)
  ) {
    samewith(
      $src,
      $dest_x,
      $dest_y,
      $dest_width,
      $dest_height,
      $offset_x,
      $offset_y,
      $scale_x,
      $scale_y,
      $interp_type,
      $overall_alpha,
      $check_x,
      $check_y,
      $check_size,
      $color1,
      $color2
    );
  }
  multi method composite_color (
    GdkPixbuf() $src,
    Int()       $dest_x,
    Int()       $dest_y,
    Int()       $dest_width,
    Int()       $dest_height,
    Num()       $offset_x,
    Num()       $offset_y,
    Num()       $scale_x,
    Num()       $scale_y,
    Int()       $interp_type,
    Int()       $overall_alpha,
    Int()       $check_x,
    Int()       $check_y,
    Int()       $check_size,
    Int()       $color1,
    Int()       $color2
  ) {
    my GdkInterpType $i = $interp_type;

    my gint ($dx, $dy, $dw, $dh, $o) =
      ($dest_x, $dest_y, $dest_width, $dest_height, $overall_alpha);

    my gint ($cx, $cy, $cs) = ($check_x, $check_y, $check_size);

    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);

    my guint32 ($c1, $c2) = ($color1, $color2);

    gdk_pixbuf_composite_color(
      $src,
      $!gp,
      $dx,
      $dy,
      $dw,
      $dh,
      $ox,
      $oy,
      $sx,
      $sy,
      $i,
      $o,
      $cx,
      $cy,
      $cs,
      $c1,
      $c2
    );
    self;
  }

  proto method composite_color_simple (|)
  { * }

  multi method composite_color_simple (
    Int()       :w(    :dest-width( :$dest_width))    = self.get_width,
    Int()       :h(    :dest-height(:$dest_height))   = self.get_height,
    Int()       :type( :interp-type(:$interp_type))   = 0,
    Int()       :a(    :alpha(      :$overall_alpha)) = 255,
    Int()       :cs(   :check-size( :$check_size))    = (
                                                          $dest_width,
                                                          $dest_height
                                                        ).min.Int div 8,
    Int()       :c1(                :$color1),
    Int()       :c2(                :$color2)
  ) {
    samewith(
      $dest_width,
      $dest_height,
      $interp_type,
      $overall_alpha,
      $check_size,
      $color1,
      $color2
    );
  }
  multi method composite_color_simple (
    Int()       $dest_width,
    Int()       $dest_height,
    Int()       $interp_type,
    Int()       $overall_alpha,
    Int()       $check_size,
    Int()       $color1,
    Int()       $color2
  ) {
    my GdkInterpType $i = $interp_type;

    my gint ($dw, $dh, $o) = ($dest_width, $dest_height, $overall_alpha);

    my gint $c = $check_size;

    my guint32 ($c1, $c2) = ($color1, $color2);

    gdk_pixbuf_composite_color_simple($!gp, $dw, $dh, $i, $o, $c, $c1, $c2);
    self
  }

  # Add multi that returns GdkPixbuf
  method copy_area (
    Int()       $src_x,
    Int()       $src_y,
    Int()       $width,
    Int()       $height,
    GdkPixbuf() $dest_pixbuf,
    Int()       $dest_x       = $src_x,
    Int()       $dest_y       = $src_y
  ) {
    my gint ($sx, $sy, $w, $h, $dx, $dy) =
      ($src_x, $src_y, $width, $height, $dest_x, $dest_y);

    gdk_pixbuf_copy_area($!gp, $sx, $sy, $w, $h, $dest_pixbuf, $dx, $dy);
  }

  method copy_options (GdkPixbuf() $dest_pixbuf) {
    gdk_pixbuf_copy_options($!gp, $dest_pixbuf);
  }

  method error_quark is static {
    gdk_pixbuf_error_quark();
  }

  method fill (Int() $pixel) {
    my guint32 $p = $pixel;

    gdk_pixbuf_fill($!gp, $p);
  }

  method flip_h ( :$raw = False) {
    self.flip(True, :$raw);
  }
  method flip_v ( :$raw = False) {
    self.flip(False, :$raw);
  }
  method flip (Int() $horizontal, :$raw = False) {
    my gboolean $h = $horizontal.so.Int;

    propReturnObject(
      gdk_pixbuf_flip($!gp, $h),
      $raw,
      |self.getTypePair
    );
  }

  method get_bits_per_sample {
    gdk_pixbuf_get_bits_per_sample($!gp);
  }

  method get_byte_length {
    gdk_pixbuf_get_byte_length($!gp);
  }

  method get_colorspace {
    gdk_pixbuf_get_colorspace($!gp);
  }

  method get_has_alpha {
    gdk_pixbuf_get_has_alpha($!gp);
  }

  method get_height {
    gdk_pixbuf_get_height($!gp);
  }

  method get_n_channels {
    gdk_pixbuf_get_n_channels($!gp);
  }

  method get_option (Str() $key) {
    gdk_pixbuf_get_option($!gp, $key);
  }

  method get_options ( :$raw = False, :ghashtable(:$ghash) = False ) {
    my $h = propReturnObject(
      gdk_pixbuf_get_options($!gp),
      $raw,
      |GLib::HashTable.getTypePair
    );
    return $h if $raw;
    $ghash ?? $h !! $h.Hash;
  }

  method get_pixels ( :$buf = False ) {
    my $b = gdk_pixbuf_get_pixels($!gp);
    $b = Buf.new($b) if $buf;
    $b;
  }

  proto method get_pixels_with_length (|)
  { * }

  multi method get_pixels_with_length (:$buf = False) {
    samewith($, :$buf)
  }
  multi method get_pixels_with_length ($length is rw, :$buf = False) {
    my guint $l = 0;
    my       $b = gdk_pixbuf_get_pixels_with_length($!gp, $l);

    $length = $l;
    $b      = Buf.new($b) if $buf;
    ($b, $l);
  }

  method get_rowstride {
    gdk_pixbuf_get_rowstride($!gp);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pixbuf_get_type, $n, $t );
  }

  method get_width {
    gdk_pixbuf_get_width($!gp);
  }

  method read_pixel_bytes {
    gdk_pixbuf_read_pixel_bytes($!gp);
  }

  method read_pixels {
    gdk_pixbuf_read_pixels($!gp);
  }

  method ref {
    gdk_pixbuf_ref($!gp);
    self;
  }

  method remove_option (Str() $key) {
    gdk_pixbuf_remove_option($!gp, $key);
  }

  method rotate_simple (Int() $angle, :$raw = False) {
    my GdkPixbufRotation $a = $angle;

    propReturnObject(
      gdk_pixbuf_rotate_simple($!gp, $a),
      $raw,
      |self.getTypePair
    );
  }

  multi method scale (
    Int()       :x( :dest-x(                  :$dest_x))   = 0,
    Int()       :y( :dest-y(                  :$dest_y))   = 0,
    Num()       :ox(:offset-x(                :$offset_x)) = 0e0,
    Num()       :oy(:offset-y(                :$offset_y)) = 0e0,
    Num()       :s(                           :$scale)     = 1e0,
    Num()       :sx(:scale-x(                 :$scale_x))  = $scale // 1e0,
    Num()       :sy(:scale-y(                 :$scale_y))  = $scale // 1e0,
    Int()       :w( :dest-width( :dest_width( :$width)))   = self.get_width  * $scale_x,
    Int()       :h( :dest-height(:dest_height(:$height)))  = self.get_height * $scale_y,
    Int()       :t( :interp_type(             :$type))     = 0
  ) {
    samewith(
      $!gp,
      $dest_x,
      $dest_y,
      $width,
      $height,
      $offset_x,
      $offset_y,
      $scale_x,
      $scale_y,
      $type
    );
  }
  multi method scale (
    GdkPixbuf() $dest,
    Int()       $dest_x,
    Int()       $dest_y,
    Int()       $dest_width,
    Int()       $dest_height,
    Num()       $offset_x,
    Num()       $offset_y,
    Num()       $scale_x,
    Num()       $scale_y,
    Int()       $interp_type
  ) {
    my gint ($dx, $dy, $dw, $dh) =
      ($dest_x, $dest_y, $dest_width, $dest_height);

    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);

    my GdkInterpType $i = $interp_type;

    gdk_pixbuf_scale(
      $!gp,
      $dest,
      $dx,
      $dy,
      $dw,
      $dh,
      $ox,
      $oy,
      $sx,
      $sy,
      $i
    );
  }

  method scale_simple (
    Int()  $dest_width,
    Int()  $dest_height,
    Int()  $interp_type  = 0,
          :$raw          = False
  ) {
    my gint          ($dw, $dh)    = ($dest_width, $dest_height);
    my GdkInterpType  $i           =  $interp_type ;

    propReturnObject(
      gdk_pixbuf_scale_simple($!gp, $dw, $dh, $i),
      $raw,
      |self.getTypePair
    );
  }

  # cw: This will require another multi!
  method saturate_and_pixelate (
    GdkPixbuf() $dest,
    Int()       $saturation,
    Int()       $pixelate
  ) {
    my gfloat   $s = $saturation;
    my gboolean $p = $pixelate;

    gdk_pixbuf_saturate_and_pixelate($!gp, $dest, $s, $p);
  }

  # cw: Definmitely squirrely!
  method save_to_buffer (
    Str                      $type,
    CArray[Pointer[GError]]  $error              = gerror,
                            *@options,
                            :$buf                = False
  ) {
    X::GLib::InvalidNumberOfArguments.new(
      message => '@options must have an even number (key, value)!'
    ).throw unless @options.elems % 2 == 0;

    self.save_to_bufferv(
       $type,
       @options.Hash,
       $error,
      :$buf
    );
  }

  proto method save_to_bufferv (|)
  { * }

  multi method save_to_bufferv (
    Str()                    $type,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$buf          = False,
                            *%options
  ) {
    samewith(
      newCArray( CArray[uint8] ),
      $,
      $type,
      $error,
      %options,
      :$buf
    )
  }
  multi method save_to_bufferv (
    Str()                    $type,
                             %options = ().Hash,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$buf     = False
  ) {
    my @options = %options.pairs.sort( *.key );
    my @keys    = @options.map( *.key );
    my @values  = @options.map( *.value );

    return-with-all(
      samewith(
        newCArray( CArray[uint8] ),
        $,
        $type,
        $error,
        ArrayToCArray(Str, @keys  , :null),
        ArrayToCArray(Str, @values, :null),
        :all,
        :$buf
      )
    )
  }
  multi method save_to_bufferv (
    CArray[CArray[uint8]]    $buffer,
                             $buffer_size     is rw,
    Str()                    $type,
    CArray[Str]              $option_keys             = CArray[Str],
    CArray[Str]              $option_values           = CArray[Str],
    CArray[Pointer[GError]]  $error                   = gerror,
                            :$buf                     = False,
                            :$all                     = False
  ) {
    my gsize $b = 0;

    clear_error;
    my $rv = so gdk_pixbuf_save_to_bufferv(
      $!gp,
      $buffer,
      $b,
      $type,
      $option_keys,
      $option_values,
      $error
    );
    set_error($error);
    (my $return-buf, $buffer_size) = ($buffer, $b);
    $return-buf = Buf.new( $return-buf[0] ) if $buf;
    $all.not ?? $rv !! ($rv, $return-buf, $buffer_size)
  }

  method save_to_callback (
    Str()                     $type,
                              &save_func,
    gpointer                  $user_data  = gpointer,
    CArray[Pointer[GError]]   $error      = gerror,
                             *@options
  ) {
    X::GLib::InvalidNumberOfArguments.new(
      message => '@options must have an even number (key, value)!'
    ).throw unless @options.elems % 2 == 0;

    my %options = @options.Hash;

    self.save_to_callbackv(
      &save_func,
      $user_data,
      $type,
      %options,
      $error,
    );
  }

  proto method save_to_callbackv (|)
  { * }

  multi method save_to_callbackv (
    Str()                    $type,
                             &save_func,
    gpointer                 $user_data  = gpointer,
    CArray[Pointer[GError]]  $error      = gerror,
                            *%options
  ) {
    samewith(
       $type,
       &save_func,
       $user_data,
       $error,
      :%options
    );
  }
  multi method save_to_callbackv (
    Str()                    $type,
                             &save_func,
                             %options    = ().Hash,
    gpointer                 $user_data  = gpointer,
    CArray[Pointer[GError]]  $error      = gerror,
  ) {
    my @opt-array = %options.pairs;
    samewith(
      $type,
      &save_func,
      $user_data,
      k           => @opt-array.map( *.keys ),
      v           => @opt-array.map( *.values ),
      $error
    );
  }
  multi method save_to_callbackv (
    Str()                                $type,
                                         &save_func,
    gpointer                             $user_data       = gpointer,
    CArray[Pointer[GError]]              $error           = gerror,
                            :k(:keys(   :@option_keys))   = (),
                            :v(:values( :@option_values)) = (),
  ) {
    samewith(
      &save_func,
      $user_data,
      $type,
      ArrayToCArray(Str, @option_keys  , :null),
      ArrayToCArray(Str, @option_values, :null),
      $error
    );
  }
  multi method save_to_callbackv (
                            &save_func,
    gpointer                $user_data,
    Str()                   $type,
    CArray[Str]             $option_keys   = CArray[Str],
    CArray[Str]             $option_values = CArray[Str],
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = gdk_pixbuf_save_to_callbackv(
      $!gp,
      &save_func,
      $user_data,
      $type,
      $option_keys,
      $option_values,
      $error
    );
    set_error($error);
    $rv;
  }


  proto method save_to_stream_async (|)
  { * }

  multi method save_to_stream_async (
    GOutputStream()      $stream,
    Str()                $type,
                         &callback,
    gpointer             $user_data   = gpointer,
    GCancellable()      :$cancellable = GCancellable
  ) {
    samewith(
      $stream,
      $type,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method save_to_stream_async (
    GOutputStream()     $stream,
    Str()               $type,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data    = gpointer
  ) {
    gdk_pixbuf_save_to_stream_async(
      $!gp,
      $stream,
      $type,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method save_to_stream_finish (
    GAsyncResult()          $async_result,
    CArray[Pointer[GError]] $error         = gerror
  )
    is static
  {
    clear_error;
    my $rv = gdk_pixbuf_save_to_stream_finish($async_result, $error);
    set_error($error);
    $rv;
  }

  method save_to_stream (
    GOutputStream()           $stream,
    Str()                     $type,
    CArray[Pointer[GError]]   $error          = gerror,
    GCancellable()           :$cancellable    = GCancellable,
                             *@options
  ) {
    self.save_to_streamv(
       $stream,
       $type,
       @options.Hash,
       $error,
      :$cancellable
    )
  }

  proto method save_to_streamv (|)
  { * }

  multi method save_to_streamv (
    GOutputStream()           $stream,
    Str()                     $type,
    CArray[Pointer[GError]]   $error          = gerror,
    GCancellable()           :$cancellable    = GCancellable,
                             *%options
  ) {
    samewith(
       $stream,
       %options,
       $type,
       $error,
      :$cancellable
    );
  }
  multi method save_to_streamv (
    GOutputStream()          $stream,
    Str()                    $type,
                             %options,
    CArray[Pointer[GError]]  $error          = gerror,
    GCancellable()          :$cancellable    = GCancellable
  ) {
    my @opt-array = %options.pairs;
    samewith(
      $stream,
      $type,
      k             => @opt-array.map( *.keys ),
      v             => @opt-array.map( *.values ),
      $cancellable,
      $error
    )
  }
  multi method save_to_streamv (
    GOutputStream()                      $stream,
    Str()                                $type,
    GCancellable()                       $cancellable     = GCancellable,
    CArray[Pointer[GError]]              $error           = gerror,
                            :k(:keys(   :@option_keys))   = (),
                            :v(:values( :@option_values)) = (),
  ) {
    samewith(
      $stream,
      $type,
      ArrayToCArray(Str, @option_keys  , :null),
      ArrayToCArray(Str, @option_values, :null),
      $cancellable,
      $error
    )
  }
  multi method save_to_streamv (
    GOutputStream()         $stream,
    Str()                   $type,
    CArray[Str]             $option_keys    = CArray[Str],
    CArray[Str]             $option_values  = CArray[Str],
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = gdk_pixbuf_save_to_streamv(
      $!gp,
      $stream,
      $type,
      $option_keys,
      $option_values,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method save_to_streamv_async (|)
  { * }

  multi method save_to_streamv_async (
    GOutputStream()     $stream,
    Str()               $type,
                        &callback,
    gpointer            $user_data      = gpointer,
    GCancellable()     :$cancellable    = GCancellable,
                       *%options
  ) {
    samewith(
       $stream,
       $type,
       &callback,
       %options,
       $user_data,
      :$cancellable
    );
  }
  multi method save_to_streamv_async (
    GOutputStream()     $stream,
    Str()               $type,
                        &callback,
                        %options,
    gpointer            $user_data      = gpointer,
    GCancellable()     :$cancellable    = GCancellable
  ) {
    my @opt-array = %options.pairs;
    samewith(
      $stream,
      $type,
      &callback,
      $user_data,
      v            => @opt-array.map( *.values),
      k            => @opt-array.map( *.keys),
     :$cancellable
    );
  }
  multi method save_to_streamv_async (
    GOutputStream()     $stream,
    Str()               $type,
                        &callback,
    gpointer            $user_data                    = gpointer,
                       :v(:values( :@option_values))  = (),
                       :k(:keys(   :@option_keys))    = (),
    GCancellable()     :$cancellable                  = GCancellable
  ) {
    samewith(
      $stream,
      $type,
      ArrayToCArray(Str, @option_keys  , :null),
      ArrayToCArray(Str, @option_values, :null),
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method save_to_streamv_async (
    GOutputStream()     $stream,
    Str()               $type,
    CArray[Str]         $option_keys,
    CArray[Str]         $option_values,
    GCancellable        $cancellable,
                        &callback,
    gpointer            $user_data      = gpointer
  ) {
    gdk_pixbuf_save_to_streamv_async(
      $!gp,
      $stream,
      $type,
      $option_keys,
      $option_values,
      $cancellable,
      &callback,
      $user_data
    );
  }

  multi method save ($filename, $type, $error, *@options) {
    self.savev($filename, $type, @options.Hash, $error);
  }

  multi method save (
     $filename,
     $type,
     $error,
    *@options,
    :$utf8      is required
  ) {
    self.savev_utf8($filename, $type, @options.Hash, $error);
  }

  multi method savev (
    Str()                    $filename,
    Str()                    $type,
    CArray[Pointer[GError]]  $error     = gerror,
                            *%options
  ) {
    samewith(
      $filename,
      $type,
      %options,
      $error
    );
  }
  multi method savev (
    Str()                    $filename,
    Str()                    $type,
                             %options   = ().Hash,
    CArray[Pointer[GError]]  $error     = gerror,
  ) {
    my @opt-array = %options.pairs;
    samewith(
      $filename,
      $type,
      @opt-array.map( *.keys ),
      @opt-array.map( *.values ),
      $error
    );
  }
  multi method savev (
    Str()                   $filename,
    Str()                   $type,
                            @option_keys,
                            @option_values,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    samewith(
      $filename,
      $type,
      ArrayToCArray(Str, @option_keys,   :null),
      ArrayToCArray(Str, @option_values, :null),
      $error
    );
  }
  multi method savev (
    Str()                   $filename,
    Str()                   $type,
    CArray[Str]             $option_keys   = CArray[Str],
    CArray[Str]             $option_values = CArray[Str],
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = so gdk_pixbuf_savev(
      $!gp,
      $filename,
      $type,
      $option_keys,
      $option_values,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method savev_utf8 (|)
  { * }

  multi method savev_utf8 (
    Str()                    $filename,
    Str()                    $type,
    CArray[Pointer[GError]]  $error     = gerror,
                            *%options
  ) {
    samewith($filename, $type, %options, $error)
  }
  multi method savev_utf8 (
    Str()                   $filename,
    Str()                   $type,
                            %options   = ().Hash,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my @opt-array = %options.pairs;
    samewith(
      $filename,
      $type,
      k           => @opt-array.map( *.keys   ),
      v           => @opt-array.map( *.values ),
      $error
    );
  }
  multi method savev_utf8 (
    Str()                                 $filename,
    Str()                                 $type,
    CArray[Pointer[GError]]               $error           = gerror,
                            :v(:values( :@option_values))  = (),
                            :k(:keys(   :@option_keys))    = ()
  ) {
    samewith(
      $filename,
      $type,
      ArrayToCArray(Str, @option_keys,   :null),
      ArrayToCArray(Str, @option_values, :null),
      $error
    );
  }
  multi method savev_utf8 (
    Str()                   $filename,
    Str()                   $type,
    CArray[Str]             $option_keys   = CArray[Str],
    CArray[Str]             $option_values = CArray[Str],
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = gdk_pixbuf_savev_utf8(
      $!gp,
      $filename,
      $type,
      $option_keys,
      $option_values,
      $error
    );
    set_error($error);
    $rv
  }

  proto method set_options (|)
  { * }

  multi method set_options (*%options) {
    samewith(%options)
  }
  multi method set_options (%options) {
    self.set_option( .key, .value ) for %options.pairs;
  }

  method set_option (Str() $key, Str() $value) {
    gdk_pixbuf_set_option($!gp, $key, $value);
  }

  method unref {
    gdk_pixbuf_unref($!gp);
  }

}
