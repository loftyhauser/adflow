   !        Generated by TAPENADE     (INRIA, Tropics team)
   !  Tapenade 3.10 (r5363) -  9 Sep 2014 09:53
   !
   !  Differentiation of computeeddyviscosity in reverse (adjoint) mode (with options i4 dr8 r8 noISIZE):
   !   gradient     of useful results: *rev *w *rlv
   !   with respect to varying inputs: *w *rlv
   !   Plus diff mem management of: rev:in w:in rlv:in
   !
   !      ******************************************************************
   !      *                                                                *
   !      * File:          computeEddyViscosity.f90                        *
   !      * Author:        Georgi Kalitzin, Edwin van der Weide            *
   !      * Starting date: 03-10-2003                                      *
   !      * Last modified: 06-12-2005                                      *
   !      *                                                                *
   !      ******************************************************************
   !
   SUBROUTINE COMPUTEEDDYVISCOSITY_B()
   !
   !      ******************************************************************
   !      *                                                                *
   !      * computeEddyViscosity computes the eddy viscosity in the        *
   !      * owned cell centers of the given block. It is assumed that the  *
   !      * pointes already point to the correct block before entering     *
   !      * this subroutine.                                               *
   !      *                                                                *
   !      ******************************************************************
   !
   USE FLOWVARREFSTATE
   USE INPUTPHYSICS
   USE ITERATION
   USE BLOCKPOINTERS_B
   IMPLICIT NONE
   !
   !      Local variables.
   !
   LOGICAL :: returnimmediately
   !
   !      ******************************************************************
   !      *                                                                *
   !      * Begin execution                                                *
   !      *                                                                *
   !      ******************************************************************
   !
   ! Check if an immediate return can be made.
   IF (eddymodel) THEN
   IF (currentlevel .LE. groundlevel .OR. turbcoupled) THEN
   returnimmediately = .false.
   ELSE
   returnimmediately = .true.
   END IF
   ELSE
   returnimmediately = .true.
   END IF
   IF (.NOT.returnimmediately) THEN
   ! Determine the turbulence model and call the appropriate
   ! routine to compute the eddy viscosity.
   SELECT CASE  (turbmodel) 
   CASE (spalartallmaras, spalartallmarasedwards) 
   CALL SAEDDYVISCOSITY_B()
   END SELECT
   END IF
   END SUBROUTINE COMPUTEEDDYVISCOSITY_B
