! Do not modify this file automatically generated by cfwrapper.py using:
! GTK 3.24.18, GLib 2.64.2, Ubuntu 20.04 x86_64
! This file is part of the gtk-fortran library, distributed under
! GNU General Public License version 3.

module gtk_os_dependent
implicit none
interface

! GDK_PIXBUF_AVAILABLE_IN_ALL
!GdkPixbuf *gdk_pixbuf_new_from_file (const char *filename, GError **error);
function gdk_pixbuf_new_from_file(filename, error) bind(c,&
& name='gdk_pixbuf_new_from_file_utf8')
  use iso_c_binding, only: c_ptr, c_char
  type(c_ptr) :: gdk_pixbuf_new_from_file
  character(kind=c_char), dimension(*) :: filename
  type(c_ptr), value :: error
end function

! GDK_PIXBUF_AVAILABLE_IN_2_4
!GdkPixbuf *gdk_pixbuf_new_from_file_at_size (const char *filename, int width, int height, GError **error);
function gdk_pixbuf_new_from_file_at_size(filename, width, height, error)&
& bind(c, name='gdk_pixbuf_new_from_file_at_size_utf8')
  use iso_c_binding, only: c_ptr, c_char, c_int
  type(c_ptr) :: gdk_pixbuf_new_from_file_at_size
  character(kind=c_char), dimension(*) :: filename
  integer(c_int), value :: width
  integer(c_int), value :: height
  type(c_ptr), value :: error
end function

! GDK_PIXBUF_AVAILABLE_IN_2_6
!GdkPixbuf *gdk_pixbuf_new_from_file_at_scale (const char *filename, int width, int height, gboolean preserve_aspect_ratio, GError **error);
function gdk_pixbuf_new_from_file_at_scale(filename, width, height,&
& preserve_aspect_ratio, error) bind(c, name='gdk_pixbuf_new_from_file_at_scale&
&_utf8')
  use iso_c_binding, only: c_ptr, c_char, c_int
  type(c_ptr) :: gdk_pixbuf_new_from_file_at_scale
  character(kind=c_char), dimension(*) :: filename
  integer(c_int), value :: width
  integer(c_int), value :: height
  integer(c_int), value :: preserve_aspect_ratio
  type(c_ptr), value :: error
end function

! GDK_PIXBUF_AVAILABLE_IN_ALL
!gboolean gdk_pixbuf_savev (GdkPixbuf *pixbuf, const char *filename, const char *type, char **option_keys, char **option_values, GError **error);
function gdk_pixbuf_savev(pixbuf, filename, type, option_keys, option_values,&
& error) bind(c, name='gdk_pixbuf_savev_utf8')
  use iso_c_binding, only: c_int, c_ptr, c_char
  integer(c_int) :: gdk_pixbuf_savev
  type(c_ptr), value :: pixbuf
  character(kind=c_char), dimension(*) :: filename
  character(kind=c_char), dimension(*) :: type
  type(c_ptr), dimension(*) :: option_keys
  type(c_ptr), dimension(*) :: option_values
  type(c_ptr), value :: error
end function

end interface
end module gtk_os_dependent
