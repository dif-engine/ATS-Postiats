#
# A simple Makefile for testing libfloats/blas
#

######

PATSCC=patscc
ATSCCOMP='gcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -DATS_MEMALLOC_LIBC'

######

test_gemm: test_gemm.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS ${PATSHOME}/contrib -o $@ $<
cleanall:: ; $(RMF) test_gemm

test_LAg: test_LAg.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS ${PATSHOME}/contrib -o $@ $<
cleanall:: ; $(RMF) test_LAg

test_LUPdec: test_LUPdec.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS ${PATSHOME}/contrib -o $@ $<
cleanall:: ; $(RMF) test_LUPdec

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######