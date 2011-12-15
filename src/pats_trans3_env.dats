(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: October, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

implement
c3str_prop
  (loc, s2e) = '{
  c3str_loc= loc
, c3str_kind= C3STRKINDmain
, c3str_node= C3STRprop (s2e)
} // end of [c3str_prop]

implement
c3str_itmlst
  (loc, knd, s3is) = '{
  c3str_loc= loc
, c3str_kind= knd
, c3str_node= C3STRitmlst (s3is)
} // end of [c3str_itmlst]

(* ****** ****** *)

implement
h3ypo_prop
  (loc, s2p) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOprop (s2p)
} // end of [h3ypo_prop]

implement
h3ypo_bind
  (loc, s2v1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPObind (s2v1, s2e2)
} // end of [h3ypo_bind]

implement
h3ypo_eqeq
  (loc, s2e1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOeqeq (s2e1, s2e2)
} // end of [h3ypo_eqeq]

(* ****** ****** *)

implement
s2exp_Var_make_srt
  (loc, s2t) = let
  val s2V = s2Var_make_srt (loc, s2t)
  val () = trans3_env_add_sVar (s2V)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_srt]

implement
s2exp_Var_make_var (loc, s2v) = let
(*
  val () = begin
    print "s2exp_Var_make_var: s2v = "; print_s2var s2v; print_newline ()
  end // end of [val]
*)
  val s2V = s2Var_make_var (loc, s2v)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
(*
  val () = begin
    print "s2exp_Var_make_var: s2V = "; print s2V; print_newline ()
  end // end of [val]
*)
  val () = trans3_env_add_sVar (s2V)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_var]


(* ****** ****** *)

local

in // in of [local]

implement
trans3_env_add_sVar
  (s2V) = () where {
(*
  val s3i = S3ITEMsVar (s2V)
  val () = let
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
  in
    !p := list_vt_cons (s3i, !p)
  end // end of [val]
  val () = the_s2Varset_env_add (s2V)
*)
} // end of [trans3_env_add_sVar]

end // end of [local]

(* ****** ****** *)

implement
s2hnf_uni_instantiate_all
  (loc0, s2f, err) = let // HX: [err] is not used
  fun loop (
    sub: &stasub, s2f: s2hnf
  ) :<cloref1> s2exp = let
    val s2e = (unhnf)s2f
  in
    case+ s2e.s2exp_node of
    | S2Euni (s2vs, s2ps, s2e1) => let
        val s2es = list_map_cloptr<s2var><s2hnf>
          (s2vs, lam (s2v) =<1> s2exp_Var_make_var (loc0, s2v))
        val err = stasub_addlst (sub, s2vs, $UN.castvwtp1 {s2hnflst} (s2es))
        val () = list_vt_free (s2es)
(*
        val s2ps = s2explst_subst (sub, s2ps)
*)
      in
        loop (sub, (hnf)s2e1)
      end
    | _ => s2exp_subst (sub, s2e)
  end // end of [loop]
  var sub: stasub = stasub_make_nil ()
  val s2e_res = loop (sub, s2f)
  val () = stasub_free (sub)
in
  (hnf)s2e_res
end // end of [s2hnf_uni_instantiate_all]

(* ****** ****** *)

local

assume trans3_env_push_v = unit_v

in // in of [local]

implement
trans3_env_pop_and_add_main
  (pf | (*none*)) = let
  prval () = unit_v_elim (pf)
in
  // nothing
end // end of [trans3_env_pop_and_add_main]

implement
trans3_env_push () = let
(*
  val () = the_s3itmlst_env_push ()
  val () = the_s2varbindmap_push ()
  val () = the_s2Varset_env_push ()
*)
in
  (unit_v () | ())
end // end of [trans3_env_push]

end // end of [local]

(* ****** ****** *)

implement
trans3_env_initialize () = {
} // end of [trans3_env_initialize]

(* ****** ****** *)

(* end of [pats_trans3_env.dats] *)
