   !        Generated by TAPENADE     (INRIA, Tropics team)
   !  Tapenade 3.6 (r4159) - 21 Sep 2011 10:11
   !
   !  Differentiation of applyallbc_block in reverse (adjoint) mode:
   !   gradient     of useful results: *rev *p *gamma *w *rlv *si
   !                *sj *sk *(*bcdata.norm)
   !   with respect to varying inputs: *rev *p *s *w *rlv *si *sj
   !                *sk *(*bcdata.norm) *(*bcdata.rface)
   !   Plus diff mem management of: rev:in bvtj1:in bvtj2:in p:in
   !                s:in gamma:in bmtk1:in w:in bmtk2:in rlv:in bvtk1:in
   !                bvtk2:in d2wall:in bmti1:in bmti2:in si:in sj:in
   !                sk:in bvti1:in bvti2:in bmtj1:in bmtj2:in bcdata:in
   !                *bcdata.norm:in *bcdata.rface:in *bcdata.uslip:in
   !                *bcdata.tns_wall:in (global)cphint:in-out
   SUBROUTINE APPLYALLBC_BLOCK_B(secondhalo)
   USE BLOCKPOINTERS_B
   USE INPUTTIMESPECTRAL
   USE INPUTDISCRETIZATION
   USE ITERATION
   USE FLOWVARREFSTATE
   USE DIFFSIZES
   !  Hint: ISIZE3OFDrfrlv should be the size of dimension 3 of array *rlv
   !  Hint: ISIZE2OFDrfrlv should be the size of dimension 2 of array *rlv
   !  Hint: ISIZE1OFDrfrlv should be the size of dimension 1 of array *rlv
   !  Hint: ISIZE4OFDrfw should be the size of dimension 4 of array *w
   !  Hint: ISIZE3OFDrfw should be the size of dimension 3 of array *w
   !  Hint: ISIZE2OFDrfw should be the size of dimension 2 of array *w
   !  Hint: ISIZE1OFDrfw should be the size of dimension 1 of array *w
   !  Hint: ISIZE3OFDrfgamma should be the size of dimension 3 of array *gamma
   !  Hint: ISIZE2OFDrfgamma should be the size of dimension 2 of array *gamma
   !  Hint: ISIZE1OFDrfgamma should be the size of dimension 1 of array *gamma
   !  Hint: ISIZE3OFDrfp should be the size of dimension 3 of array *p
   !  Hint: ISIZE2OFDrfp should be the size of dimension 2 of array *p
   !  Hint: ISIZE1OFDrfp should be the size of dimension 1 of array *p
   !  Hint: ISIZE3OFDrfrev should be the size of dimension 3 of array *rev
   !  Hint: ISIZE2OFDrfrev should be the size of dimension 2 of array *rev
   !  Hint: ISIZE1OFDrfrev should be the size of dimension 1 of array *rev
   !  Hint: ISIZE4OFDrfbmtj2 should be the size of dimension 4 of array *bmtj2
   !  Hint: ISIZE3OFDrfbmtj2 should be the size of dimension 3 of array *bmtj2
   !  Hint: ISIZE2OFDrfbmtj2 should be the size of dimension 2 of array *bmtj2
   !  Hint: ISIZE1OFDrfbmtj2 should be the size of dimension 1 of array *bmtj2
   !  Hint: ISIZE4OFDrfbmtj1 should be the size of dimension 4 of array *bmtj1
   !  Hint: ISIZE3OFDrfbmtj1 should be the size of dimension 3 of array *bmtj1
   !  Hint: ISIZE2OFDrfbmtj1 should be the size of dimension 2 of array *bmtj1
   !  Hint: ISIZE1OFDrfbmtj1 should be the size of dimension 1 of array *bmtj1
   !  Hint: ISIZE3OFDrfbvti2 should be the size of dimension 3 of array *bvti2
   !  Hint: ISIZE2OFDrfbvti2 should be the size of dimension 2 of array *bvti2
   !  Hint: ISIZE1OFDrfbvti2 should be the size of dimension 1 of array *bvti2
   !  Hint: ISIZE3OFDrfbvti1 should be the size of dimension 3 of array *bvti1
   !  Hint: ISIZE2OFDrfbvti1 should be the size of dimension 2 of array *bvti1
   !  Hint: ISIZE1OFDrfbvti1 should be the size of dimension 1 of array *bvti1
   !  Hint: ISIZE4OFDrfbmti2 should be the size of dimension 4 of array *bmti2
   !  Hint: ISIZE3OFDrfbmti2 should be the size of dimension 3 of array *bmti2
   !  Hint: ISIZE2OFDrfbmti2 should be the size of dimension 2 of array *bmti2
   !  Hint: ISIZE1OFDrfbmti2 should be the size of dimension 1 of array *bmti2
   !  Hint: ISIZE4OFDrfbmti1 should be the size of dimension 4 of array *bmti1
   !  Hint: ISIZE3OFDrfbmti1 should be the size of dimension 3 of array *bmti1
   !  Hint: ISIZE2OFDrfbmti1 should be the size of dimension 2 of array *bmti1
   !  Hint: ISIZE1OFDrfbmti1 should be the size of dimension 1 of array *bmti1
   !  Hint: ISIZE3OFDrfbvtk2 should be the size of dimension 3 of array *bvtk2
   !  Hint: ISIZE2OFDrfbvtk2 should be the size of dimension 2 of array *bvtk2
   !  Hint: ISIZE1OFDrfbvtk2 should be the size of dimension 1 of array *bvtk2
   !  Hint: ISIZE3OFDrfbvtk1 should be the size of dimension 3 of array *bvtk1
   !  Hint: ISIZE2OFDrfbvtk1 should be the size of dimension 2 of array *bvtk1
   !  Hint: ISIZE1OFDrfbvtk1 should be the size of dimension 1 of array *bvtk1
   !  Hint: ISIZE4OFDrfbmtk2 should be the size of dimension 4 of array *bmtk2
   !  Hint: ISIZE3OFDrfbmtk2 should be the size of dimension 3 of array *bmtk2
   !  Hint: ISIZE2OFDrfbmtk2 should be the size of dimension 2 of array *bmtk2
   !  Hint: ISIZE1OFDrfbmtk2 should be the size of dimension 1 of array *bmtk2
   !  Hint: ISIZE4OFDrfbmtk1 should be the size of dimension 4 of array *bmtk1
   !  Hint: ISIZE3OFDrfbmtk1 should be the size of dimension 3 of array *bmtk1
   !  Hint: ISIZE2OFDrfbmtk1 should be the size of dimension 2 of array *bmtk1
   !  Hint: ISIZE1OFDrfbmtk1 should be the size of dimension 1 of array *bmtk1
   !  Hint: ISIZE3OFDrfbvtj2 should be the size of dimension 3 of array *bvtj2
   !  Hint: ISIZE2OFDrfbvtj2 should be the size of dimension 2 of array *bvtj2
   !  Hint: ISIZE1OFDrfbvtj2 should be the size of dimension 1 of array *bvtj2
   !  Hint: ISIZE3OFDrfbvtj1 should be the size of dimension 3 of array *bvtj1
   !  Hint: ISIZE2OFDrfbvtj1 should be the size of dimension 2 of array *bvtj1
   !  Hint: ISIZE1OFDrfbvtj1 should be the size of dimension 1 of array *bvtj1
   IMPLICIT NONE
   ! Domain-interface boundary conditions,
   ! when coupled with other solvers.
   ! Apply BC's for a single block
   !
   !      Subroutine arguments.
   !
   LOGICAL, INTENT(IN) :: secondhalo
   !
   !      Local variables.
   !
   INTEGER(kind=inttype) :: nn, sps
   LOGICAL :: correctfork
   INTEGER :: branch
   !
   ! Determine whether or not the total energy must be corrected
   ! for the presence of the turbulent kinetic energy.
   IF (kpresent) THEN
   IF (currentlevel .LE. groundlevel .OR. turbcoupled) THEN
   correctfork = .true.
   ELSE
   correctfork = .false.
   END IF
   ELSE
   correctfork = .false.
   END IF
   CALL PUSHREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL PUSHREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &                ISIZE4OFDrfw)
   CALL PUSHREAL8ARRAY(gamma, ISIZE1OFDrfgamma*ISIZE2OFDrfgamma*&
   &                ISIZE3OFDrfgamma)
   CALL PUSHREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL PUSHREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   ! Apply all the boundary conditions. The order is important.
   ! The symmetry boundary conditions.
   CALL BCSYMM(secondhalo)
   CALL PUSHREAL8ARRAY(bmtj2, ISIZE1OFDrfbmtj2*ISIZE2OFDrfbmtj2*&
   &                ISIZE3OFDrfbmtj2*ISIZE4OFDrfbmtj2)
   CALL PUSHREAL8ARRAY(bmtj1, ISIZE1OFDrfbmtj1*ISIZE2OFDrfbmtj1*&
   &                ISIZE3OFDrfbmtj1*ISIZE4OFDrfbmtj1)
   CALL PUSHREAL8ARRAY(bvti2, ISIZE1OFDrfbvti2*ISIZE2OFDrfbvti2*&
   &                ISIZE3OFDrfbvti2)
   CALL PUSHREAL8ARRAY(bvti1, ISIZE1OFDrfbvti1*ISIZE2OFDrfbvti1*&
   &                ISIZE3OFDrfbvti1)
   CALL PUSHREAL8ARRAY(bmti2, ISIZE1OFDrfbmti2*ISIZE2OFDrfbmti2*&
   &                ISIZE3OFDrfbmti2*ISIZE4OFDrfbmti2)
   CALL PUSHREAL8ARRAY(bmti1, ISIZE1OFDrfbmti1*ISIZE2OFDrfbmti1*&
   &                ISIZE3OFDrfbmti1*ISIZE4OFDrfbmti1)
   CALL PUSHREAL8ARRAY(bvtk2, ISIZE1OFDrfbvtk2*ISIZE2OFDrfbvtk2*&
   &                ISIZE3OFDrfbvtk2)
   CALL PUSHREAL8ARRAY(bvtk1, ISIZE1OFDrfbvtk1*ISIZE2OFDrfbvtk1*&
   &                ISIZE3OFDrfbvtk1)
   CALL PUSHREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL PUSHREAL8ARRAY(bmtk2, ISIZE1OFDrfbmtk2*ISIZE2OFDrfbmtk2*&
   &                ISIZE3OFDrfbmtk2*ISIZE4OFDrfbmtk2)
   CALL PUSHREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &                ISIZE4OFDrfw)
   CALL PUSHREAL8ARRAY(bmtk1, ISIZE1OFDrfbmtk1*ISIZE2OFDrfbmtk1*&
   &                ISIZE3OFDrfbmtk1*ISIZE4OFDrfbmtk1)
   CALL PUSHREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL PUSHREAL8ARRAY(bvtj2, ISIZE1OFDrfbvtj2*ISIZE2OFDrfbvtj2*&
   &                ISIZE3OFDrfbvtj2)
   CALL PUSHREAL8ARRAY(bvtj1, ISIZE1OFDrfbvtj1*ISIZE2OFDrfbvtj1*&
   &                ISIZE3OFDrfbvtj1)
   CALL PUSHREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   CALL BCNSWALLADIABATIC(secondhalo, correctfork)
   !call bcEulerWall(secondHalo, correctForK)
   ! The viscous wall boundary conditions.
   CALL PUSHREAL8ARRAY(bmtj2, ISIZE1OFDrfbmtj2*ISIZE2OFDrfbmtj2*&
   &                ISIZE3OFDrfbmtj2*ISIZE4OFDrfbmtj2)
   CALL PUSHREAL8ARRAY(bmtj1, ISIZE1OFDrfbmtj1*ISIZE2OFDrfbmtj1*&
   &                ISIZE3OFDrfbmtj1*ISIZE4OFDrfbmtj1)
   CALL PUSHREAL8ARRAY(bvti2, ISIZE1OFDrfbvti2*ISIZE2OFDrfbvti2*&
   &                ISIZE3OFDrfbvti2)
   CALL PUSHREAL8ARRAY(bvti1, ISIZE1OFDrfbvti1*ISIZE2OFDrfbvti1*&
   &                ISIZE3OFDrfbvti1)
   CALL PUSHREAL8ARRAY(bmti2, ISIZE1OFDrfbmti2*ISIZE2OFDrfbmti2*&
   &                ISIZE3OFDrfbmti2*ISIZE4OFDrfbmti2)
   CALL PUSHREAL8ARRAY(bmti1, ISIZE1OFDrfbmti1*ISIZE2OFDrfbmti1*&
   &                ISIZE3OFDrfbmti1*ISIZE4OFDrfbmti1)
   CALL PUSHREAL8ARRAY(bvtk2, ISIZE1OFDrfbvtk2*ISIZE2OFDrfbvtk2*&
   &                ISIZE3OFDrfbvtk2)
   CALL PUSHREAL8ARRAY(bvtk1, ISIZE1OFDrfbvtk1*ISIZE2OFDrfbvtk1*&
   &                ISIZE3OFDrfbvtk1)
   CALL PUSHREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL PUSHREAL8ARRAY(bmtk2, ISIZE1OFDrfbmtk2*ISIZE2OFDrfbmtk2*&
   &                ISIZE3OFDrfbmtk2*ISIZE4OFDrfbmtk2)
   CALL PUSHREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &                ISIZE4OFDrfw)
   CALL PUSHREAL8ARRAY(bmtk1, ISIZE1OFDrfbmtk1*ISIZE2OFDrfbmtk1*&
   &                ISIZE3OFDrfbmtk1*ISIZE4OFDrfbmtk1)
   CALL PUSHREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL PUSHREAL8ARRAY(bvtj2, ISIZE1OFDrfbvtj2*ISIZE2OFDrfbvtj2*&
   &                ISIZE3OFDrfbvtj2)
   CALL PUSHREAL8ARRAY(bvtj1, ISIZE1OFDrfbvtj1*ISIZE2OFDrfbvtj1*&
   &                ISIZE3OFDrfbvtj1)
   CALL PUSHREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   CALL BCNSWALLISOTHERMAL(secondhalo, correctfork)
   ! The farfield is a special case, because the treatment
   ! differs when preconditioning is used. Make that distinction
   ! and call the appropriate routine.
   SELECT CASE  (precond) 
   CASE (noprecond) 
   CALL PUSHREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*&
   &                  ISIZE3OFDrfrlv)
   CALL PUSHREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &                  ISIZE4OFDrfw)
   CALL PUSHREAL8ARRAY(gamma, ISIZE1OFDrfgamma*ISIZE2OFDrfgamma*&
   &                  ISIZE3OFDrfgamma)
   CALL PUSHREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL PUSHREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*&
   &                  ISIZE3OFDrfrev)
   CALL BCFARFIELD(secondhalo, correctfork)
   CALL PUSHCONTROL1B(0)
   CASE (turkel) 
   CALL PUSHCONTROL1B(1)
   CASE (choimerkle) 
   CALL PUSHCONTROL1B(1)
   CASE DEFAULT
   CALL PUSHCONTROL1B(1)
   END SELECT
   CALL BCEULERWALL_B(secondhalo, correctfork)
   CALL POPCONTROL1B(branch)
   IF (branch .EQ. 0) THEN
   CALL POPREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev&
   &                )
   CALL POPREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL POPREAL8ARRAY(gamma, ISIZE1OFDrfgamma*ISIZE2OFDrfgamma*&
   &                 ISIZE3OFDrfgamma)
   CALL POPREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &                 ISIZE4OFDrfw)
   CALL POPREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv&
   &                )
   CALL BCFARFIELD_B(secondhalo, correctfork)
   END IF
   CALL POPREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   CALL POPREAL8ARRAY(bvtj1, ISIZE1OFDrfbvtj1*ISIZE2OFDrfbvtj1*&
   &               ISIZE3OFDrfbvtj1)
   CALL POPREAL8ARRAY(bvtj2, ISIZE1OFDrfbvtj2*ISIZE2OFDrfbvtj2*&
   &               ISIZE3OFDrfbvtj2)
   CALL POPREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL POPREAL8ARRAY(bmtk1, ISIZE1OFDrfbmtk1*ISIZE2OFDrfbmtk1*&
   &               ISIZE3OFDrfbmtk1*ISIZE4OFDrfbmtk1)
   CALL POPREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &               ISIZE4OFDrfw)
   CALL POPREAL8ARRAY(bmtk2, ISIZE1OFDrfbmtk2*ISIZE2OFDrfbmtk2*&
   &               ISIZE3OFDrfbmtk2*ISIZE4OFDrfbmtk2)
   CALL POPREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL POPREAL8ARRAY(bvtk1, ISIZE1OFDrfbvtk1*ISIZE2OFDrfbvtk1*&
   &               ISIZE3OFDrfbvtk1)
   CALL POPREAL8ARRAY(bvtk2, ISIZE1OFDrfbvtk2*ISIZE2OFDrfbvtk2*&
   &               ISIZE3OFDrfbvtk2)
   CALL POPREAL8ARRAY(bmti1, ISIZE1OFDrfbmti1*ISIZE2OFDrfbmti1*&
   &               ISIZE3OFDrfbmti1*ISIZE4OFDrfbmti1)
   CALL POPREAL8ARRAY(bmti2, ISIZE1OFDrfbmti2*ISIZE2OFDrfbmti2*&
   &               ISIZE3OFDrfbmti2*ISIZE4OFDrfbmti2)
   CALL POPREAL8ARRAY(bvti1, ISIZE1OFDrfbvti1*ISIZE2OFDrfbvti1*&
   &               ISIZE3OFDrfbvti1)
   CALL POPREAL8ARRAY(bvti2, ISIZE1OFDrfbvti2*ISIZE2OFDrfbvti2*&
   &               ISIZE3OFDrfbvti2)
   CALL POPREAL8ARRAY(bmtj1, ISIZE1OFDrfbmtj1*ISIZE2OFDrfbmtj1*&
   &               ISIZE3OFDrfbmtj1*ISIZE4OFDrfbmtj1)
   CALL POPREAL8ARRAY(bmtj2, ISIZE1OFDrfbmtj2*ISIZE2OFDrfbmtj2*&
   &               ISIZE3OFDrfbmtj2*ISIZE4OFDrfbmtj2)
   CALL BCNSWALLISOTHERMAL_B(secondhalo, correctfork)
   CALL POPREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   CALL POPREAL8ARRAY(bvtj1, ISIZE1OFDrfbvtj1*ISIZE2OFDrfbvtj1*&
   &               ISIZE3OFDrfbvtj1)
   CALL POPREAL8ARRAY(bvtj2, ISIZE1OFDrfbvtj2*ISIZE2OFDrfbvtj2*&
   &               ISIZE3OFDrfbvtj2)
   CALL POPREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL POPREAL8ARRAY(bmtk1, ISIZE1OFDrfbmtk1*ISIZE2OFDrfbmtk1*&
   &               ISIZE3OFDrfbmtk1*ISIZE4OFDrfbmtk1)
   CALL POPREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &               ISIZE4OFDrfw)
   CALL POPREAL8ARRAY(bmtk2, ISIZE1OFDrfbmtk2*ISIZE2OFDrfbmtk2*&
   &               ISIZE3OFDrfbmtk2*ISIZE4OFDrfbmtk2)
   CALL POPREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL POPREAL8ARRAY(bvtk1, ISIZE1OFDrfbvtk1*ISIZE2OFDrfbvtk1*&
   &               ISIZE3OFDrfbvtk1)
   CALL POPREAL8ARRAY(bvtk2, ISIZE1OFDrfbvtk2*ISIZE2OFDrfbvtk2*&
   &               ISIZE3OFDrfbvtk2)
   CALL POPREAL8ARRAY(bmti1, ISIZE1OFDrfbmti1*ISIZE2OFDrfbmti1*&
   &               ISIZE3OFDrfbmti1*ISIZE4OFDrfbmti1)
   CALL POPREAL8ARRAY(bmti2, ISIZE1OFDrfbmti2*ISIZE2OFDrfbmti2*&
   &               ISIZE3OFDrfbmti2*ISIZE4OFDrfbmti2)
   CALL POPREAL8ARRAY(bvti1, ISIZE1OFDrfbvti1*ISIZE2OFDrfbvti1*&
   &               ISIZE3OFDrfbvti1)
   CALL POPREAL8ARRAY(bvti2, ISIZE1OFDrfbvti2*ISIZE2OFDrfbvti2*&
   &               ISIZE3OFDrfbvti2)
   CALL POPREAL8ARRAY(bmtj1, ISIZE1OFDrfbmtj1*ISIZE2OFDrfbmtj1*&
   &               ISIZE3OFDrfbmtj1*ISIZE4OFDrfbmtj1)
   CALL POPREAL8ARRAY(bmtj2, ISIZE1OFDrfbmtj2*ISIZE2OFDrfbmtj2*&
   &               ISIZE3OFDrfbmtj2*ISIZE4OFDrfbmtj2)
   CALL BCNSWALLADIABATIC_B(secondhalo, correctfork)
   CALL POPREAL8ARRAY(rev, ISIZE1OFDrfrev*ISIZE2OFDrfrev*ISIZE3OFDrfrev)
   CALL POPREAL8ARRAY(p, ISIZE1OFDrfp*ISIZE2OFDrfp*ISIZE3OFDrfp)
   CALL POPREAL8ARRAY(gamma, ISIZE1OFDrfgamma*ISIZE2OFDrfgamma*&
   &               ISIZE3OFDrfgamma)
   CALL POPREAL8ARRAY(w, ISIZE1OFDrfw*ISIZE2OFDrfw*ISIZE3OFDrfw*&
   &               ISIZE4OFDrfw)
   CALL POPREAL8ARRAY(rlv, ISIZE1OFDrfrlv*ISIZE2OFDrfrlv*ISIZE3OFDrfrlv)
   CALL BCSYMM_B(secondhalo)
   END SUBROUTINE APPLYALLBC_BLOCK_B
