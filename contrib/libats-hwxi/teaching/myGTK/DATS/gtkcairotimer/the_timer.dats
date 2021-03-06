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
#define ATS_PACKNAME
"ATSCNTRB.libats-hwxi.teaching.gtkcairotimer_the_timer"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload TIMER = "./timer.dats"

(* ****** ****** *)
//
extern
fun the_timer_start (): void
extern
fun the_timer_finish (): void
extern
fun the_timer_pause (): void
extern
fun the_timer_resume (): void
extern
fun the_timer_reset (): void
//
extern
fun the_timer_get_ntick (): double // obtaining the number of ticks
//
extern
fun the_timer_is_started (): bool
extern
fun the_timer_is_running (): bool
//
(* ****** ****** *)

local

val t0 = $TIMER.timer_new ()

in (* in-of-local *)

implement
the_timer_start
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_start (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_start] *)

implement
the_timer_finish
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_finish (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_finish] *)

implement
the_timer_pause
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_pause (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_pause] *)

implement
the_timer_resume
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_resume (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_resume] *)

implement
the_timer_reset
  ((*void*)) =
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ((*void*)) = $TIMER.timer_reset (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

(* ****** ****** *)

implement
the_timer_get_ntick
  ((*void*)) = ntick where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ntick = $TIMER.timer_get_ntick (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_reset] *)

(* ****** ****** *)

implement
the_timer_is_started
  ((*void*)) = ans where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ans = $TIMER.timer_is_started (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_is_started] *)

implement
the_timer_is_running
  ((*void*)) = ans where
{
  val (
    fpf | t0
  ) = decode ($vcopyenv_vt(t0))
  val ans = $TIMER.timer_is_running (t0)
  prval ((*void*)) = fpf (t0)
} (* end of [the_timer_is_running] *)

end // end of [local]

(* ****** ****** *)

(* end of [the_timer.dats] *)
