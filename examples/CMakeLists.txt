# Free Software Foundation, Inc.
#
# This file is part of the gtk-fortran gtk+ Fortran Interface library.
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Under Section 7 of GPL version 3, you are granted additional
# permissions described in the GCC Runtime Library Exception, version
# 3.1, as published by the Free Software Foundation.
#
# You should have received a copy of the GNU General Public License along with
# this program; see the files COPYING3 and COPYING.RUNTIME respectively.
# If not, see <http://www.gnu.org/licenses/>.
#
# Contributed by Kyle Horne: 05.11.2011
# Tests redesigned, James Tappin 05/17/2011
# Last modifications: Jens Hunger: 03/06/2013

# CMAKE build file for GtkFortran

# Choose the static or shared version of the library here.
set(LIBRARY_TARGET_TO_USE "gtk-fortran_static")

include_directories("/usr/include")
include_directories("/usr/local/include")
# Need to reference the directory for the modules of the 
# gtk-fortran library.
include_directories($<TARGET_PROPERTY:${LIBRARY_TARGET_TO_USE},Fortran_MODULE_DIRECTORY>)
include_directories(${GTK_INCLUDES})

if (NOT NO_BUILD_EXAMPLES) 
  add_executable(bazaar "bazaar.f90")
  target_link_libraries(bazaar ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  # Isolate .mod files specific to this example in their own directory.  This 
  # avoids issues with clashing module names between the examples.  This 
  # pattern is used for all the examples.
  set_target_properties(bazaar PROPERTIES Fortran_MODULE_DIRECTORY bazaar.moddir)
  # Add the directory for .mod files set immediately above to the module 
  # search path.
  target_include_directories(bazaar BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:Fortran_MODULE_DIRECTORY>)
  add_test(bazaar ./bazaar)

  add_executable(cairo-tests "cairo-tests.f90")
  target_link_libraries(cairo-tests ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(cairo-tests PROPERTIES Fortran_MODULE_DIRECTORY cairo-tests.moddir)
  target_include_directories(cairo-tests BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:Fortran_MODULE_DIRECTORY>)
  add_test(cairo-tests ./cairo-tests)

  add_executable(cairo-basics "cairo-basics.f90")
  target_link_libraries(cairo-basics ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(cairo-basics PROPERTIES Fortran_MODULE_DIRECTORY cairo-basics.moddir)
  target_include_directories(cairo-basics BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:Fortran_MODULE_DIRECTORY>)
  add_test(cairo-basics ./cairo-basics)

  add_executable(cairo-basics-click "cairo-basics-click.f90")
  target_link_libraries(cairo-basics-click ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(cairo-basics-click PROPERTIES Fortran_MODULE_DIRECTORY cairo-basics-click.moddir)
  target_include_directories(cairo-basics-click BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:Fortran_MODULE_DIRECTORY>)
  add_test(cairo-basics ./cairo-basics-click)

  add_executable(gtkhello2 "gtkhello2.f90")
  target_link_libraries(gtkhello2 ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(gtkhello2 PROPERTIES Fortran_MODULE_DIRECTORY gtkhello2)
  target_include_directories(gtkhello2 BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(gtkhello2 ./gtkhello2)

  if (UNIX)
    add_custom_command(
      OUTPUT gtkbuilder.glade
      COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.glade ${CMAKE_CURRENT_BINARY_DIR}/gtkbuilder.glade
      DEPENDS  ${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.glade
      )
  endif()
  if (CMAKE_HOST_WIN32)
    add_custom_command(
      OUTPUT gtkbuilder.glade
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.glade ${CMAKE_CURRENT_BINARY_DIR}/gtkbuilder.glade
      DEPENDS  ${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.glade
      )
  endif()

  add_custom_target(glade ALL DEPENDS "gtkbuilder.glade")

  add_executable(gtkbuilder "gtkbuilder.f90")
  target_link_libraries(gtkbuilder ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(gtkbuilder PROPERTIES Fortran_MODULE_DIRECTORY gtkbuilder)
  target_include_directories(gtkbuilder BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  # This test is excluded because the directories don't match up.
  #add_test(gtkbuilder gtkbuilder)

  add_executable(gtkbuilder2 "gtkbuilder2.f90" "gtkbuilder.glade")
  target_link_libraries(gtkbuilder2 ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(gtkbuilder2 PROPERTIES Fortran_MODULE_DIRECTORY gtkbuilder2)
  target_include_directories(gtkbuilder2 BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  # This test is excluded because the directories don't match up.
  # add_test(gtkbuilder2 gtkbuilder2)

  add_executable(hl_assistant "hl_assistant.f90")
  target_link_libraries(hl_assistant ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_assistant PROPERTIES Fortran_MODULE_DIRECTORY hl_assistant)
  target_include_directories(hl_assistant BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_assistant ./hl_assistant)

  add_executable(hl_choosers "hl_choosers.f90")
  target_link_libraries(hl_choosers ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_choosers PROPERTIES Fortran_MODULE_DIRECTORY hl_choosers)
  target_include_directories(hl_choosers BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_choosers ./hl_choosers)

  add_executable(hl_combo "hl_combo.f90")
  target_link_libraries(hl_combo ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_combo PROPERTIES Fortran_MODULE_DIRECTORY hl_combo)
  target_include_directories(hl_combo BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_combo ./hl_combo)

  add_executable(hl_containers "hl_containers.f90")
  target_link_libraries(hl_containers ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_containers PROPERTIES Fortran_MODULE_DIRECTORY hl_containers)
  target_include_directories(hl_containers BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_containers ./hl_containers)

  add_executable(hl_dialog "hl_dialog.f90")
  target_link_libraries(hl_dialog ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_dialog PROPERTIES Fortran_MODULE_DIRECTORY hl_dialog)
  target_include_directories(hl_dialog BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_dialog ./hl_dialog)

  add_executable(hl_list1 "hl_list1.f90")
  target_link_libraries(hl_list1 ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_list1 PROPERTIES Fortran_MODULE_DIRECTORY hl_list1)
  target_include_directories(hl_list1 BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_list1 ./hl_list1)

  add_executable(hl_list_n "hl_list_n.f90")
  target_link_libraries(hl_list_n ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_list_n PROPERTIES Fortran_MODULE_DIRECTORY hl_list_n)
  target_include_directories(hl_list_n BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_list_n ./hl_list_n)

  add_executable(hl_list_renderers "hl_list_renderers.f90")
  target_link_libraries(hl_list_renderers ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_list_renderers PROPERTIES Fortran_MODULE_DIRECTORY hl_list_renderers)
  target_include_directories(hl_list_renderers BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_list_renderers ./hl_list_renderers)

  add_executable(hl_menu "hl_menu.f90")
  target_link_libraries(hl_menu ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_menu PROPERTIES Fortran_MODULE_DIRECTORY hl_menu)
  target_include_directories(hl_menu BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_menu ./hl_menu)

  add_executable(hl_pbar "hl_pbar.f90")
  target_link_libraries(hl_pbar ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_pbar PROPERTIES Fortran_MODULE_DIRECTORY hl_pbar)
  target_include_directories(hl_pbar BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_pbar ./hl_pbar)

  add_executable(hl_pbar_p "hl_pbar_p.f90")
  target_link_libraries(hl_pbar_p ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_pbar_p PROPERTIES Fortran_MODULE_DIRECTORY hl_pbar_p)
  target_include_directories(hl_pbar_p BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_pbar_p ./hl_pbar_p)

  add_executable(hl_radio "hl_radio.f90")
  target_link_libraries(hl_radio ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_radio PROPERTIES Fortran_MODULE_DIRECTORY hl_radio)
  target_include_directories(hl_radio BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_radio ./hl_radio)

  add_executable(hl_sliders "hl_sliders.f90")
  target_link_libraries(hl_sliders ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_sliders PROPERTIES Fortran_MODULE_DIRECTORY hl_sliders)
  target_include_directories(hl_sliders BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_sliders ./hl_sliders)

  add_executable(hl_sliders2 "hl_sliders2.f90")
  target_link_libraries(hl_sliders2 ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_sliders2 PROPERTIES Fortran_MODULE_DIRECTORY hl_sliders2)
  target_include_directories(hl_sliders2 BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_sliders2 ./hl_sliders2)

  add_executable(hl_textview "hl_textview.f90")
  target_link_libraries(hl_textview ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_textview PROPERTIES Fortran_MODULE_DIRECTORY hl_textview)
  target_include_directories(hl_textview BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_textview ./hl_textview)

  add_executable(hl_tree "hl_tree.f90")
  target_link_libraries(hl_tree ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_tree PROPERTIES Fortran_MODULE_DIRECTORY hl_tree)
  target_include_directories(hl_tree BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_tree ./hl_tree)

  add_executable(hl_cairo1 "hl_cairo1.f90")
  target_link_libraries(hl_cairo1 ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_cairo1 PROPERTIES Fortran_MODULE_DIRECTORY hl_cairo1)
  target_include_directories(hl_cairo1 BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_cairo1 ./hl_cairo1)

  add_executable(hl_cairo_clock "hl_cairo_clock.f90")
  target_link_libraries(hl_cairo_clock ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_cairo_clock PROPERTIES Fortran_MODULE_DIRECTORY hl_cairo_clock)
  target_include_directories(hl_cairo_clock BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_cairo_clock ./hl_cairo_clock)

  add_executable(hl_cairo_viewer "hl_cairo_viewer.f90")
  target_link_libraries(hl_cairo_viewer ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_cairo_viewer PROPERTIES Fortran_MODULE_DIRECTORY hl_cairo_viewer)
  target_include_directories(hl_cairo_viewer BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_cairo_viewer ./hl_cairo_viewer)

  add_executable(hl_infobar "hl_infobar.f90")
  target_link_libraries(hl_infobar ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(hl_infobar PROPERTIES Fortran_MODULE_DIRECTORY hl_infobar)
  target_include_directories(hl_infobar BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(hl_infobar ./hl_infobar)

  add_executable(julia_pixbuf "julia_pixbuf.f90")
  target_link_libraries(julia_pixbuf ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(julia_pixbuf PROPERTIES Fortran_MODULE_DIRECTORY julia_pixbuf)
  target_include_directories(julia_pixbuf BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(julia_pixbuf ./julia_pixbuf)

  add_executable(list_demo "list_demo.f90")
  target_link_libraries(list_demo ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(list_demo PROPERTIES Fortran_MODULE_DIRECTORY list_demo)
  target_include_directories(list_demo BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(list_demo ./list_demo)

  add_executable(mandelbrot_pixbuf "mandelbrot_pixbuf.f90")
  target_link_libraries(mandelbrot_pixbuf ${LIBRARY_TARGET_TO_USE}
    ${GTK_LIBRARIES})
  set_target_properties(mandelbrot_pixbuf PROPERTIES Fortran_MODULE_DIRECTORY mandelbrot_pixbuf)
  target_include_directories(mandelbrot_pixbuf BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(mandelbrot_pixbuf ./mandelbrot_pixbuf)

  add_executable(mandelbrot_pixbuf_zoom "mandelbrot_pixbuf_zoom.f90")
  target_link_libraries(mandelbrot_pixbuf_zoom ${LIBRARY_TARGET_TO_USE}
    ${GTK_LIBRARIES})
  set_target_properties(mandelbrot_pixbuf_zoom PROPERTIES Fortran_MODULE_DIRECTORY mandelbrot_pixbuf_zoom)
  target_include_directories(mandelbrot_pixbuf_zoom BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(mandelbrot_pixbuf_zoom ./mandelbrot_pixbuf_zoom)

  add_executable(menu "menu.f90")
  target_link_libraries(menu ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(menu PROPERTIES Fortran_MODULE_DIRECTORY menu)
  target_include_directories(menu BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(menu ./menu)

  add_executable(notebooks "notebooks.f90")
  target_link_libraries(notebooks ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(notebooks PROPERTIES Fortran_MODULE_DIRECTORY notebooks)
  target_include_directories(notebooks BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(notebooks ./notebooks)

  add_executable(gio_demo "gio_demo.f90")
  target_link_libraries(gio_demo ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(gio_demo PROPERTIES Fortran_MODULE_DIRECTORY gio_demo)
  target_include_directories(gio_demo BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(gio_demo ./gio_demo)

  add_executable(tests "tests.f90")
  target_link_libraries(tests ${LIBRARY_TARGET_TO_USE} ${GTK_LIBRARIES})
  set_target_properties(tests PROPERTIES Fortran_MODULE_DIRECTORY tests)
  target_include_directories(tests BEFORE PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/$<TARGET_PROPERTY:NAME>)
  add_test(tests ./tests)
endif(NOT NO_BUILD_EXAMPLES)

# If the INSTALL_EXAMPLES variable is set, then copy the examples
# to ${CMAKE_INSTALL_DATAROOTDIR/gtk-fortran/examples<gtkversion>
# useful (e.g.) for building binary packages.
if (INSTALL_EXAMPLES)
  install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/bazaar.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/cairo-tests.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/cairo-basics.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/cairo-basics-click.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/gtkhello2.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder2.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/gtkbuilder.glade"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_assistant.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_choosers.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_combo.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_containers.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_dialog.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_list1.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_list_n.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_list_renderers.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_menu.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_pbar.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_pbar_p.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_radio.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_sliders.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_sliders2.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_textview.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_tree.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_cairo1.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_cairo_clock.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/hl_infobar.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/julia_pixbuf.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/list_demo.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/mandelbrot_pixbuf.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/mandelbrot_pixbuf_zoom.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/menu.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/notebooks.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/gio_demo.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/tests.f90"
    "${CMAKE_CURRENT_SOURCE_DIR}/README"
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/gtk-fortran/examples3)
endif(INSTALL_EXAMPLES)
