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

  method flip (gboolean  $horizontal) {
    gdk_pixbuf_flip($!gp, $horizontal);
  }

  method rotate_simple (GdkPixbufRotation $angle) {
    gdk_pixbuf_rotate_simple($!gp, $angle);
  }

  method scale (
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
  ) {
    gdk_pixbuf_scale($!gp, $dest, $dest_x, $dest_y, $dest_width, $dest_height, $offset_x, $offset_y, $scale_x, $scale_y, $interp_type);
  }

  method scale_simple (
    gint          $dest_width,
    gint          $dest_height,
    GdkInterpType $interp_type
  ) {
    gdk_pixbuf_scale_simple($!gp, $dest_width, $dest_height, $interp_type);
  }

