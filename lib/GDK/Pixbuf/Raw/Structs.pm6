use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GDK::Pixbuf::Raw::Definitions;

unit package GDK::Pixbuf::Raw::Structs;

class GdkPixbufModulePattern is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str  $!prefix;
  has Str  $!mask;
  has gint $.relevance is rw;

  method prefix is rw {
    Proxy.new:
      FETCH => -> $           { $!prefix }
      STORE => -> $, Str() \v { $!prefix := v };
  }

  method mask is rw {
    Proxy.new:
      FETCH => -> $           { $!mask }
      STORE => -> $, Str() \v { $!mask := v };
  }

}

class GdkPixbufFormat is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str                    $!name;
  has GdkPixbufModulePattern $!signature;
  has Str                    $!domain;
  has Str                    $!description;
  has CArray[Str]            $!mime_types;
  has CArray[Str]            $!extensions;
  has guint32                $.flags        is rw;
  has gboolean               $.disabled     is rw;
  has Str                    $!license ;

  method name is rw {
    Proxy.new:
      FETCH => -> $           { $!name }
      STORE => -> $, Str() \v { $!name := v };
  }

  method domain is rw {
    Proxy.new:
      FETCH => -> $           { $!domain }
      STORE => -> $, Str() \v { $!domain := v };
  }

  method description is rw {
    Proxy.new:
      FETCH => -> $           { $!description }
      STORE => -> $, Str() \v { $!description := v };
  }

  method license is rw {
    Proxy.new:
      FETCH => -> $           { $!license }
      STORE => -> $, Str() \v { $!license := v };
  }

  method mime_types is rw {
    Proxy.new:
      FETCH => -> $ { $!mime_types },

      STORE => -> $, $v is copy {
        $v = ArrayToCArray(Str, $v) if $v ~~ Array;
        $!mime_types := $v;
      }
  }

  method extensions is rw {
    Proxy.new:
      FETCH => -> $ { $!extensions },

      STORE => -> $, $v is copy {
        $v = ArrayToCArray(Str, $v) if $v ~~ Array;
        $!extensions := $v;
      }
  }

  method signature is rw {
    Proxy.new:
      FETCH => -> $                              { $!signature      },
      STORE => -> $, GdkPixbufModulePattern() \v { $!signature := v }
  }

}
