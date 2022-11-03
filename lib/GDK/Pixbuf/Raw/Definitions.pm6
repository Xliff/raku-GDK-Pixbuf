use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GDK::Pixbuf::Raw::Definitions;

constant gdk-pixbuf is export = 'gdk_pixbuf-2.0',v0;

class GdkPixbuf          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GdkPixbufAnimation is repr<CPointer> is export does GLib::Roles::Pointers { }
class GdkPixbufLoader    is repr<CPointer> is export does GLib::Roles::Pointers { }

# Convert to struct!
class GdkPixbufModule    is repr<CPointer> is export does GLib::Roles::Pointers { }
