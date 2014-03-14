(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

staload "./the_timer.dats"

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)

extern
fun{}
on_start_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
} on_start_clicked (widget, event, _) = the_timer_start ()

(* ****** ****** *)

extern
fun{}
on_finish_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
} on_finish_clicked (widget, event, _) = the_timer_finish ()

(* ****** ****** *)

extern
fun{}
on_pause_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
} on_pause_clicked (widget, event, _) = the_timer_pause ()

(* ****** ****** *)

extern
fun{}
on_resume_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
} on_resume_clicked (widget, event, _) = the_timer_resume ()

(* ****** ****** *)

extern
fun{}
on_reset_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
}on_reset_clicked (widget, event, _) = the_timer_reset ()

(* ****** ****** *)

extern
fun{}
on_quit_clicked
(
  widget: !GtkWidget1, event: &GdkEvent, _: gpointer
) : void
implement{
} on_quit_clicked (widget, event, _) = gtk_main_quit ((*void*))

(* ****** ****** *)

extern
fun{}
ControlPanel_make (): gobjref1(GtkBox)

(* ****** ****** *)

implement{
} ControlPanel_make
(
  // argumentless
) = let
//
val vbox0 =
gtk_box_new
(
  GTK_ORIENTATION_VERTICAL(*orient*), (gint)10(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (vbox0) > 0)
//
val hbox1 = 
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL(*orient*), (gint)0(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (hbox1) > 0)
val () =
gtk_box_pack_start
(
  vbox0, hbox1, GTRUE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val () = g_object_unref (hbox1)
//
val button_start =
gtk_button_new_with_label ((gstring)"Start")
val () = assertloc (ptrcast (button_start) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_start, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_start, (gsignal)"clicked", G_CALLBACK(on_start_clicked), (gpointer)NULL
)
val () = g_object_unref (button_start)
//
val button_finish =
gtk_button_new_with_label ((gstring)"Finish")
val () = assertloc (ptrcast (button_finish) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_finish, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_finish, (gsignal)"clicked", G_CALLBACK(on_finish_clicked), (gpointer)NULL
)
val () = g_object_unref (button_finish)
//
val button_pause =
gtk_button_new_with_label ((gstring)"Pause")
val () = assertloc (ptrcast (button_pause) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_pause, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_pause, (gsignal)"clicked", G_CALLBACK(on_pause_clicked), (gpointer)NULL
)
val () = g_object_unref (button_pause)
//
val button_resume =
gtk_button_new_with_label ((gstring)"Resume")
val () = assertloc (ptrcast (button_resume) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_resume, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_resume, (gsignal)"clicked", G_CALLBACK(on_resume_clicked), (gpointer)NULL
)
val () = g_object_unref (button_resume)
//
val button_reset =
gtk_button_new_with_label ((gstring)"Reset")
val () = assertloc (ptrcast (button_reset) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_reset, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_reset, (gsignal)"clicked", G_CALLBACK(on_reset_clicked), (gpointer)NULL
)
val () = g_object_unref (button_reset)
//
val button_quit =
gtk_button_new_with_mnemonic ((gstring)"_Quit")
val () = assertloc (ptrcast (button_quit) > 0)
val () =
gtk_box_pack_start
(
  vbox0, button_quit, GFALSE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val _sid = g_signal_connect
(
  button_quit, (gsignal)"clicked", G_CALLBACK(on_quit_clicked), (gpointer)NULL
)
val () = g_object_unref (button_quit)
//
val hbox2 = 
gtk_box_new
(
  GTK_ORIENTATION_HORIZONTAL(*orient*), (gint)0(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (hbox2) > 0)
val () =
gtk_box_pack_start
(
  vbox0, hbox2, GTRUE(*expand*), GFALSE(*fill*), (guint)2
) (* end of [val] *)
val () = g_object_unref (hbox2)
//
in
  vbox0
end // end of [ControlPanel_make]

(* ****** ****** *)

(* end of [ControlPanel.dats] *)
