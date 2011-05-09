(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
s2exp_alpha (s2v, s2v_new, s2e) = s2e

(* ****** ****** *)

implement
s2explst_alpha
  (s2v, s2v_new, s2es) = let
  var !p_clo = @lam
    (pf: !unit_v | s2e: s2exp): s2exp => s2exp_alpha (s2v, s2v_new, s2e)
  // end of [var]
  prval pfu = unit_v ()
  val s2es = list_map_clo (pfu | s2es, !p_clo)
  prval unit_v () = pfu
in
  l2l (s2es)
end // end of [s2explst_alpha]

(* ****** ****** *)

(* end of [pats_staexp2_util1.dats] *)
