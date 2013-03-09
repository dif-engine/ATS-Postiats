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
(* Start time: March, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "libats/SATS/sllist.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

stadef mytkind = $extkind"atslib_sllist"

(* ****** ****** *)

typedef g2node0 (a:vt0p) = gnode0 (mytkind, a)
typedef g2node1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)
//
extern
fun{a:vt0p}
g2node_make_elt (x: a):<!wrt> g2node1 (a)
//
extern
fun{a:t0p} // [a] is nonlinear
g2node_free (nx: g2node1 (INV(a))):<!wrt> void
extern
fun{a:vt0p}
g2node_free_elt
  (nx: g2node1 (INV(a)), res: &(a?) >> a):<!wrt> void
//
extern
fun{a:vt0p}
g2node_getfree_elt (nx: g2node1 (INV(a))):<!wrt> (a)
//
(* ****** ****** *)
//
extern
castfn
sllist_encode
  : {a:vt0p}{n:int} (g2node0 (INV(a))) -<> sllist (a, n)
extern
castfn
sllist_decode
  : {a:vt0p}{n:int} (sllist (INV(a), n)) -<> g2node0 (a)
//
extern
castfn
sllist1_encode
  : {a:vt0p}{n:int | n > 0} (g2node1 (INV(a))) -<> sllist (a, n)
extern
castfn
sllist1_decode
  : {a:vt0p}{n:int | n > 0} (sllist (INV(a), n)) -<> g2node1 (a)
//
(* ****** ****** *)

implement{}
sllist_nil () = sllist_encode (gnode_null ())

implement{a}
sllist_sing (x) = sllist_cons<a> (x, sllist_nil ())

(* ****** ****** *)

implement{a}
sllist_cons
  (x, xs) = let
  val nx0 = g2node_make_elt<a> (x)
  val () = gnode_set_prev_null (nx0)
  val nxs = sllist_decode (xs)
  val () = gnode_link10 (nx0, nxs)
in
  sllist_encode (nx0)
end // end of [sllist_cons]

implement{a}
sllist_uncons
  (xs) = let
  val nxs = sllist1_decode (xs)
  val nxs2 = gnode_get_next (nxs)
  val () = gnode0_set_prev_null (nxs2)
  val () = xs := sllist_encode (nxs2)
in
  g2node_getfree_elt (nxs)
end // end of [sllist_uncons]

(* ****** ****** *)

implement{a}
sllist_make_list (xs) = let
//
fun loop (
  nx0: g2node1 (a), xs: List (a)
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx1 =
      g2node_make_elt<a> (x)
    // end of [val]
    val () = gnode_link11 (nx0, nx1)
  in
    loop (nx1, xs)
  end // end of [loop]
| list_nil () => let
    val () = gnode_set_next_null (nx0)
  in
    // nothing
  end // end of [list_nil]
//
end // end of [loop]
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx0 = g2node_make_elt<a> (x)
    val () = $effmask_all (loop (nx0, xs))
  in
    sllist_encode (nx0)
  end // end of [list_cons]
| list_nil () => sllist_nil ()
//
end // end of [sllist_make_list]

(* ****** ****** *)

implement{}
sllist_is_nil
  {a}{n} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(n==0)}(gnodelst_is_nil (nxs))
end // end of [sllist_is_nil]

implement{}
sllist_is_cons
  {a}{n} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(n > 0)}(gnodelst_is_cons (nxs))
end // end of [sllist_is_cons]

(* ****** ****** *)

implement{a}
sllist_getref_elt (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in gnode_getref_elt (nxs)
  // end of [val]
end // end of [sllist_getref_elt]

implement{a}
sllist_getref_next (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in gnode_getref_next (nxs)
  // end of [val]  
end // end of [sllist_getref_next]

(* ****** ****** *)

implement{a}
sllist_get_elt
  (xs) = let
  val p_elt =
    sllist_getref_elt (xs) in $UN.ptr_get<a> (p_elt)
  // end of [val]
end // end of [sllist_get_elt]

implement{a}
sllist_set_elt
  (xs, x0) = let
  val p_elt = 
    sllist_getref_elt (xs) in $UN.ptr_set<a> (p_elt, x0)
  // end of [val]
end // end of [sllist_set_elt]

(* ****** ****** *)

(*
fun{a:vt0p}
sllist_length
  {n:int} (xs: !sllist (INV(a), n)):<> int (n)
*)
implement{a}
sllist_length
  {n} (xs) = let
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  $UN.cast{int(n)}(gnodelst_length (nxs))
end // end of [sllist_length]

(* ****** ****** *)
(*
fun{a:vt0p}
sllist_append
  {n1,n2:int} (
  xs1: sllist (INV(a), n1), xs2: sllist (a, n2)
) :<!wrt> sllist (a, n1+n2) // end of [sllist_append]
*)
implement{a}
sllist_append
  {n1,n2} (xs1, xs2) = let
//
prval () = lemma_sllist_param (xs1)
prval () = lemma_sllist_param (xs2)
//
val iscons1 = sllist_is_cons (xs1)
//
in
//
if iscons1 then let
  val iscons2 = sllist_is_cons (xs2)
in
  if iscons2 then let
    val nxs1 = sllist1_decode (xs1)
    val nxs2 = sllist_decode (xs2)
    val nxs1_end = gnodelst_next_all (nxs1)
    val () = gnode_link10 (nxs1_end, nxs2)
  in
    sllist_encode (nxs1)
  end else let
    prval () = sllist_free_nil (xs2)
  in
    xs1
  end // end of [if]
end else let
  prval () = sllist_free_nil (xs1)
in
  xs2
end // end of [if]
//
end // end of [sllist_append]

(* ****** ****** *)

implement{a}
sllist_reverse (xs) = let
//
fun loop (
  nxs: g2node0 (a), res: g2node1 (a)
) : g2node1 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () = gnode_link11 (nx0, res)
in
  loop (nxs, nx0)
end else res // end of [if]
//
end // end of [loop]
//
val iscons = sllist_is_cons (xs)
//
in
//
if iscons then let
  val nxs = sllist1_decode (xs)
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val nxp = gnode_get_prev (nx0)
  val () = gnode_set_next_null (nx0)
  val res = $effmask_all (loop (nxs, nx0))
  val () = gnode_link01 (nxp, res)
in
  sllist_encode (res)
end else (xs) // end of [if]
//
end // end of [sllist_reverse]

(* ****** ****** *)

implement{a}
sllist_free (xs) = let
//
fun loop (
  nxs: g2node0 (a)
) : void = let
//
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
  val nxs2 = gnode_get_next (nxs)
  val () = g2node_free (nxs)
in
  loop (nxs2)
end else () // end of [if]
//
end // end of [loop]
//
val nxs = sllist_decode (xs)
//
in
  $effmask_all (loop (nxs))
end // end of [sllist_free]

(* ****** ****** *)

(*
fun{
a:vt0p}{env:vt0p
} sllist_foreach_env
  (xs: !Sllist (INV(a)), env: &env >> _): void
*)
implement
{a}{env}
sllist_foreach_env
  (xs, env) = let
//
fun loop (
  nxs: g2node0 (a), env: &env
) : void = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nxs)
  val p_elt = gnode_getref_elt (nx0)
  prval (pf, fpf) = $UN.ptr_vtake {a} (p_elt)
  val test = sllist_foreach$cont (!p_elt, env)
in
  if test then let
    val () = sllist_foreach$fwork (!p_elt, env)
    prval () = fpf (pf)
  in
    loop (nxs, env)
  end else let
    prval () = fpf (pf)
  in
    // nothing
  end // end of [if]
end else () // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  loop (nxs, env)
end // end of [sllist_foreach_env]

(* ****** ****** *)

implement{}
fprint_sllist$sep
  (out) = fprint_string (out, "->")
implement{a}
fprint_sllist (out, xs) = let
//
fun loop (
  out: FILEref, nxs: g2node0 (a), i: int
) : void = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () =
    if i > 0 then fprint_sllist$sep (out)
  // end of [val]
  val p_elt = gnode_getref_elt (nx0)
  prval (pf, fpf) = $UN.ptr_vtake {a} (p_elt)
  val () = fprint_ref (out, !p_elt)
  prval () = fpf (pf)
in
  loop (out, nxs, i+1)
end // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  loop (out, nxs, 0)
end // end of [fprint_sllist]

(* ****** ****** *)

datavtype
slnode_vtype
  (a:vt@ype+) = SLNODE of (a, ptr(*next*))
// end of [slnode_vtype]

vtypedef slnode (a:vt0p) = slnode_vtype (a)

(* ****** ****** *)

extern
praxi slnode_vfree {a:vt0p} (nx: slnode (a)): void
extern
castfn
g2node_decode {a:vt0p} (nx: g2node1 (INV(a))):<> slnode (a)
extern
castfn
g2node_encode {a:vt0p} (nx: slnode (INV(a))):<> g2node1 (a)

(* ****** ****** *)

implement{a}
g2node_make_elt
  (x) = let
in
  $UN.castvwtp0{g2node1(a)}(SLNODE{a}(x, _))
end // end of [g2node_make_elt]

(* ****** ****** *)

implement{a}
g2node_free (nx) = let
  val nx = g2node_decode (nx)
  val~SLNODE (_, _) = (nx) in (*nothing*)
end // end of [g2node_free]

implement{a}
g2node_free_elt
  (nx, res) = let
  val nx = g2node_decode (nx)
  val~SLNODE (x, _) = (nx); val () = res := x in (*nothing*)
end // end of [g2node_free_elt]

implement{a}
g2node_getfree_elt
  (nx) = let
  val nx = g2node_decode (nx)
  val~SLNODE (x, _) = (nx) in x
end // end of [g2node_getfree_elt]

(* ****** ****** *)

implement(a)
gnode_getref_elt<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@SLNODE (elt, _) = nx
val p_elt = addr@ (elt)
prval () = fold@ (nx)
prval () = slnode_vfree (nx)
//
in
  p_elt
end // end of [gnode_getref_elt]

(* ****** ****** *)

implement(a)
gnode_getref_next<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@SLNODE (_, next) = nx
val p_next = addr@ (next)
prval () = fold@ (nx)
prval () = slnode_vfree (nx)
//
in
  p_next
end // end of [gnode_getref_next]

(* ****** ****** *)

(* end of [sllist.dats] *)