(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: July, 2013 *)

(* ****** ****** *)

(*
datatype commerr =
  | CEdats of ()
  | CEiats of ()
  | CEfilats of ()
// end of [commerr]
*)

(* ****** ****** *)

datatype commarg =
  | CAvats of () // -vats: version inquiry
  | CAccats of () // -ccats: compilation only
  | CAtcats of () // -tcats: typechecking only
  | CAdats of (int(*knd*), stropt) // knd=0/1:-DATS/-DDATS
  | CAiats of (int(*knd*), stropt) // knd=0/1:-IATS/-IIATS
  | CAfilats of (int(*knd*), stropt) // knd=0/1:-fsats/-fdats
  | CAgitem of string // generic item passed to ccomp
// end of [commarg]

typedef commarglst = List0 (commarg)
vtypedef commarglst_vt = List0_vt (commarg)

(* ****** ****** *)

fun fprint_commarg
  (out: FILEref, ca: commarg): void
fun fprint_commarglst
  (out: FILEref, cas: commarglst): void
overload fprint with fprint_commarglst of 10

(* ****** ****** *)

fun{} atsopt_get (): string
fun{} atsccomp_get (): string

(* ****** ****** *)
//
// HX: flag=0/1:static/dynamic
//
fun atscc_outname (flag: int, path: string): string
//
(* ****** ****** *)

fun fprint_atsoptline
(
  out: FILEref, cas: commarglst, ca0: commarg
) : void // end of [fprint_atsoptline]

fun fprint_atsoptline_all (FILEref, commarglst): void

fun fprint_atsccompline (out: FILEref, cas: commarglst): void

(* ****** ****** *)

fun atsoptline_make
  (out: FILEref, cas: commarglst, ca0: commarg): stringlst_vt
// end of [atsoptline_make]

(* ****** ****** *)

fun atsccproc{n:int}
  (argc: int n, argv: !argv(n)): commarglst
// end of [atsccproc]

(* ****** ****** *)

(* end of [atscc.sats] *)