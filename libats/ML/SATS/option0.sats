(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/SATS/ML_basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

castfn
option0_of_option {a:t@ype} (xs: Option a):<> option0 (a)
castfn
option0_of_option_vt {a:t@ype} (xs: Option_vt a):<> option0 (a)
castfn
option_of_option0 {a:t@ype} (xs: option0 a):<> Option (a)

(* ****** ****** *)

fun{
a:t0p
} option0_some (x: a):<> option0 (a)
fun{}
option0_none {a:t0p} ((*void*)):<> option0 (a)

(* ****** ****** *)

fun{}
option0_is_some {a:t0p} (x: option0 a):<> bool
fun{}
option0_is_none {a:t0p} (x: option0 a):<> bool

(* ****** ****** *)

fun{a:t0p}
option0_unsome_exn (opt: option0 (a)):<!exn> a

(* ****** ****** *)

(* end of [option0.sats] *)