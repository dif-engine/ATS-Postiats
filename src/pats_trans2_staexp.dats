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

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
overload = with $SYM.eq_symbol_symbol

staload SYN = "pats_syntax.sats"
typedef s0taq = $SYN.s0taq

(* ****** ****** *)

(*
** HX: static special identifier
*)
datatype staspecid = SPSIDarrow | SPSIDnone

fn staspecid_of_qid
  (q: s0taq, id: symbol): staspecid = begin
  case+ q.s0taq_node of
  | $SYN.S0TAQnone () => begin
      if id = $SYM.symbol_MINUSGT then SPSIDarrow () else SPSIDnone ()
    end // end of [S0TAQnone]
  | _ => SPSIDnone ()
end // end of [staspecid_of_qid]

(* ****** ****** *)

(* end of [pats_trans2_staexp.dats] *)
