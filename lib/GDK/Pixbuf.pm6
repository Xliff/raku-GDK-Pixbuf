use v6.c;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Types;
use GDK::Pixbuf::Raw::Core;
use GDK::Pixbuf::Raw::Transform;

use GLib::Roles::Implementor;

class GDK::Pixbuf {
  also does GLib::Roles::Implementor;

  has GdkPixbuf $!gp is implementor;

  method new (
    GdkColorspace $colorspace,
    gboolean      $has_alpha,
    gint          $bits_per_sample,
    gint          $width,
    gint          $height
  ) {
    gdk_pixbuf_new($!gp, $has_alpha, $bits_per_sample, $width, $height);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_bytes (
    GdkColorspace $colorspace,
    gboolean      $has_alpha,
    gint          $bits_per_sample,
    gint          $width,
    gint          $height,
    gint          $rowstride
  ) {
    gdk_pixbuf_new_from_bytes($!gp, $data, $colorspace, $has_alpha, $bits_per_sample, $width, $height, $rowstride);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_data (
    Str                    $data,
    GdkColorspace          $colorspace,
    gboolean               $has_alpha,
    gint                   $bits_per_sample,
    gint                   $width,
    gint                   $height,
    gint                   $rowstride,
    GdkPixbufDestroyNotify $destroy_fn,
    gpointer               $destroy_fn_data
  ) {
    gdk_pixbuf_new_from_data($!gp, $data, $colorspace, $has_alpha, $bits_per_sample, $width, $height, $rowstride, $destroy_fn, $destroy_fn_data);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file (
    Str                     $filename,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_file($!gp, $filename, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_scale (
    Str                     $filename,
    gint                    $width,
    gint                    $height,
    gboolean                $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_file_at_scale($!gp, $filename, $width, $height, $preserve_aspect_ratio, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_scale_utf8 (
    Str                     $filename,
    gint                    $width,
    gint                    $height,
    gboolean                $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_file_at_scale_utf8($!gp, $filename, $width, $height, $preserve_aspect_ratio, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_size (
    Str                     $filename,
    gint                    $width,
    gint                    $height,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_file_at_size($!gp, $filename, $width, $height, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_at_size_utf8 (
    Str                     $filename,
    gint                    $width,
    gint                    $height,
    CArray[Pointer[GError]] $error
  ) {

    gdk_pixbuf_new_from_file_at_size_utf8($!gp, $filename, $width, $height, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_file_utf8 (
    Str                     $filename,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_file_utf8($!gp, $filename, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_inline (
    gint                    $data_length,
    guint8                  $data is rw,
    gboolean                $copy_pixels,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_inline($!gp, $data_length, $data, $copy_pixels, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_resource (
    Str                     $resource_path,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_resource($!gp, $resource_path, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_resource_at_scale (
    Str                     $resource_path,
    gint                    $width,
    gint                    $height,
    gboolean                $preserve_aspect_ratio,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_resource_at_scale($!gp, $resource_path, $width, $height, $preserve_aspect_ratio, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream (
    GInputStream            $stream,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_stream($!gp, $stream, $cancellable, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream_async (
    GInputStream        $stream,
    GCancellable        $cancellable,
    GAsyncReadyCallback $callback,
    gpointer            $user_data
  ) {
    gdk_pixbuf_new_from_stream_async($!gp, $stream, $cancellable, $callback, $user_data);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream_at_scale (
    GInputStream            $stream,
    gint                    $width,
    gint                    $height,
    gboolean                $preserve_aspect_ratio,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_new_from_stream_at_scale($!gp, $stream, $width, $height, $preserve_aspect_ratio, $cancellable, $error);
    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  method new_from_stream_at_scale_async (
    GInputStream        $stream,
    gint                $width,
    gint                $height,
    gboolean            $preserve_aspect_ratio,
    GCancellable        $cancellable,
    GAsyncReadyCallback $callback,
    gpointer            $user_data
  ) {
    gdk_pixbuf_new_from_stream_at_scale_async($!gp, $stream, $width, $height, $preserve_aspect_ratio, $cancellable, $callback, $user_data);
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

  method new_from_xpm_data (Str() $data) {
    samewith($data.lines);
  }
  method new_from_xpm_data (@data) [
    samewith( ArrayToCArray(Str, @data) );
  }
  method new_from_xpm_data (CArray[Str] $data) {
    my $gdk-pixbuf = gdk_pixbuf_new_from_xpm_data($!gp, $data);

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
    Int()  $substitute_color,
    Int()  $r,
    Int()  $g,
    Int()  $b
  ) {
    my gboolean $s             =  $substitute_color;
    my uint8   ($rr, $gg, $bb) = ($r, $g, $b);

    propReturnObject(
      gdk_pixbuf_add_alpha($!gp, $s, $rr, $gg, $bb),
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
    my gboolean  $h          =  $has_alpha;
    my gint     ($b, $w, $h) = ($bits_per_sample, $width, $height);

    gdk_pixbuf_calculate_rowstride($!gp, $h, $b, $w, $h);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gdk_pixbuf_copy($!gp),
      $raw,
      |self.getTypePair
    );
  }

  method composite (
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
  ) {
    gdk_pixbuf_composite($!gp, $dest, $dest_x, $dest_y, $dest_width, $dest_height, $offset_x, $offset_y, $scale_x, $scale_y, $interp_type, $overall_alpha);
  }

  method composite_color (
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
  ) {
    gdk_pixbuf_composite_color($!gp, $dest, $dest_x, $dest_y, $dest_width, $dest_height, $offset_x, $offset_y, $scale_x, $scale_y, $interp_type, $overall_alpha, $check_x, $check_y, $check_size, $color1, $color2);
  }

  method composite_color_simple (
    gint          $dest_width,
    gint          $dest_height,
    GdkInterpType $interp_type,
    gint          $overall_alpha,
    gint          $check_size,
    guint32       $color1,
    guint32       $color2
  ) {
    gdk_pixbuf_composite_color_simple($!gp, $dest_width, $dest_height, $interp_type, $overall_alpha, $check_size, $color1, $color2);
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
  )
    my gint ($sx, $sy, $w, $h, $dx, $dy) =
      ($src_x, $src_y, $width, $height, $dest_x, $dest_y)

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

  method scale (
    GdkPixbuf() $dest,
    Int()       :dx(:dest-x(:$dest_x))                  = 0,
    Int()       :dy(:dest-y(:$dest_y))                  = 0,
    Num()       :ox(:offset-x(:$offset_x))              = 0e0,
    Num()       :oy(:offset-y(:$offset_y))              = 0e0,
    Num()       :f(:s(:fac(:scale(:$factor))))          = 1e0,
    Num()       :sx(:scale-x(:$scale_x))                = $factor // 1e0,
    Num()       :sy(:scale-y(:$scale_y))                = $factor // 1e0,
    Int()       :w(:dest-width(:dest_width(:$width)))   = self.get_width  * $scale_x,
    Int()       :h(:dest-height(:dest_height(:$height)) = self.get_height * $scale_y,
    Int()       :t(:interp_type(:$type))                = 0
  ) {
    samewith(
      $dest,
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
  method scale (
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

  method saturate_and_pixelate (Int() $saturation, Int() $pixelate) {
    my gfloat   $s = $saturation;
    my gboolean $p = $pixelate;

    gdk_pixbuf_saturate_and_pixelate($!gp, $dest, $s, $p);
  }

  method save (
    Str()                   $filename,
    Str()                   $type,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    gdk_pixbuf_save($!gp, $filename, $type, $error, Str);
  }

  method save_to_buffer (
    CArray[CArray[uint8]]    $buffer,
                             $buffer_size is rw,
    Str                      $type,
    CArray[Pointer[GError]]  $error              = gerror,
                            :$all                = False,
                            :$buf                = False
  ) {
    my gsize $b = 0;

    clear_error;
    my $rv = so gdk_pixbuf_save_to_buffer($!gp, $buffer, $b, $type, $error);
    set_error($error);
    (my $return-buf, $buffer_size) = ($buffer, $b);
    $return-buf = Buf.new( $return-buf[0] ) if $buf;
    $all.not ?? $rv !! ($rv, $return-buf, $buffer_size);
  }

  proto method save_to_bufferv (|)
  { * }

  multi method save_to_bufferv (
    Str()                    $type,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$buf          = False,
                            *%options      = ().Hash
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
  method save_to_bufferv (
    Str()                    $type,
    Hash()                   $options,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$buf      = False
  ) {
    my @options = %options.pairs.sort( *.key );
    my @keys    = @options.map( *.key );
    my @values  = @options.map( *.value );

    return-with-all
      samewith(
        newCArray( CArray[uint8] ),
        $,
        $type,
        $error,
        ArrayToCArray(Str, @keys),
        ArrayToCArray(Str, @values),
        :all,
        :$buf
      )
    )
  }
  method save_to_bufferv (
    CArray[CArray[uint8]]    $buffer,
                             $buffer_size     is rw,
    Str()                    $type,
    CArray[Str]              $option_keys,
    CArray[Str]              $option_values,
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
    GdkPixbufSaveFunc       $save_func,
    gpointer                $user_data,
    Str                     $type,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_save_to_callback($!gp, $save_func, $user_data, $type, $error);
  }

  method save_to_callbackv (
    GdkPixbufSaveFunc       $save_func,
    gpointer                $user_data,
    Str                     $type,
    CArray[Str]             $option_keys,
    CArray[Str]             $option_values,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_save_to_callbackv($!gp, $save_func, $user_data, $type, $option_keys, $option_values, $error);
  }

  method save_to_stream (
    GOutputStream           $stream,
    Str                     $type,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_save_to_stream($!gp, $stream, $type, $cancellable, $error);
  }

  method save_to_stream_async (
    GOutputStream       $stream,
    Str                 $type,
    GCancellable        $cancellable,
    GAsyncReadyCallback $callback,
    gpointer            $user_data
  ) {
    gdk_pixbuf_save_to_stream_async($!gp, $stream, $type, $cancellable, $callback, $user_data);
  }

  method save_to_stream_finish (
    GAsyncResult            $async_result,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_save_to_stream_finish($!gp, $error);
  }

  method save_to_streamv (
    GOutputStream           $stream,
    Str                     $type,
    CArray[Str]             $option_keys,
    CArray[Str]             $option_values,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_save_to_streamv($!gp, $stream, $type, $option_keys, $option_values, $cancellable, $error);
  }

  method save_to_streamv_async (
    GOutputStream       $stream,
    Str                 $type,
    CArray[Str]         $option_keys,
    CArray[Str]         $option_values,
    GCancellable        $cancellable,
    GAsyncReadyCallback $callback,
    gpointer            $user_data
  ) {
    gdk_pixbuf_save_to_streamv_async($!gp, $stream, $type, $option_keys, $option_values, $cancellable, $callback, $user_data);
  }

  method savev (
    Str                     $filename,
    Str                     $type,
    CArray[Str]             $option_keys,
    CArray[Str]             $option_values,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_savev($!gp, $filename, $type, $option_keys, $option_values, $error);
  }

  method savev_utf8 (
    Str                     $filename,
    Str                     $type,
    CArray[Str]             $option_keys,
    CArray[Str]             $option_values,
    CArray[Pointer[GError]] $error
  ) {
    gdk_pixbuf_savev_utf8($!gp, $filename, $type, $option_keys, $option_values, $error);
  }

  method set_option (Str () $key, Str() $value) {
    gdk_pixbuf_set_option($!gp, $key, $value);
  }

  method unref {
    gdk_pixbuf_unref($!gp);
  }

}
