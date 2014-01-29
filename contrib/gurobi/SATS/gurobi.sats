(* ****** ****** *)
//
// API in ATS for GUROBI
//
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi (gmhwxiDOTgmailDOTcom)
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.gurobi" // package name
#define ATS_EXTERN_PREFIX "atscntrb_gurobi_" // prefix for external names"

(* ****** ****** *)

typedef interr(i:int) = int(i)

(* ****** ****** *)
//
absvtype
GRBenvptr (l:addr) = ptr (l)
//
vtypedef GRBenvptr0 = [l:addr] GRBenvptr(l)
vtypedef GRBenvptr1 = [l:addr | l > null] GRBenvptr(l)
//
(* ****** ****** *)

fun GRBloadenv
(
  envP: &ptr? >> opt(GRBenvptr1, i==0), logfilename: stropt
) : #[i:nat] interr (i) = "mac#%"

(* ****** ****** *)

fun GRBloadclientenv
(
  envP: &ptr? >> opt(GRBenvptr1, i==0), logfilename: stropt
, server: stropt, port: int, passwd: stropt, priority: int, timeout: double
) : #[i:nat] interr (i) = "mac#%"

(* ****** ****** *)

fun GRBfreeenv (env: GRBenvptr0): void = "mac#%"

(* ****** ****** *)

(* end of [gurobi.sats] *)