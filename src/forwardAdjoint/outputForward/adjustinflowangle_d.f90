   !        Generated by TAPENADE     (INRIA, Tropics team)
   !  Tapenade 3.10 (r5363) -  9 Sep 2014 09:53
   !
   !  Differentiation of adjustinflowangle in forward (tangent) mode (with options i4 dr8 r8):
   !   variations   of useful results: veldirfreestream dragdirection
   !                liftdirection
   !   with respect to varying inputs: alpha beta
   !
   !      ******************************************************************
   !      *                                                                *
   !      * File:          adjustInflowAngle.f90                           *
   !      * Author:        C.A.(Sandy) Mader                               *
   !      * Starting date: 07-13-2011                                      *
   !      * Last modified: 07-13-2011                                      *
   !      *                                                                *
   !      ******************************************************************
   !
   SUBROUTINE ADJUSTINFLOWANGLE_D(alpha, alphad, beta, betad, liftindex)
   USE CONSTANTS
   USE INPUTPHYSICS
   IMPLICIT NONE
   !Subroutine Vars
   REAL(kind=realtype), INTENT(IN) :: alpha, beta
   REAL(kind=realtype), INTENT(IN) :: alphad, betad
   INTEGER(kind=inttype), INTENT(IN) :: liftindex
   !Local Vars
   REAL(kind=realtype), DIMENSION(3) :: refdirection
   ! Velocity direction given by the rotation of a unit vector
   ! initially aligned along the positive x-direction (1,0,0)
   ! 1) rotate alpha radians cw about y or z-axis
   ! 2) rotate beta radians ccw about z or y-axis
   refdirection(:) = zero
   refdirection(1) = one
   CALL GETDIRVECTOR_D(refdirection, alpha, alphad, beta, betad, &
   &               veldirfreestream, veldirfreestreamd, liftindex)
   ! Drag direction given by the rotation of a unit vector
   ! initially aligned along the positive x-direction (1,0,0)
   ! 1) rotate alpha radians cw about y or z-axis
   ! 2) rotate beta radians ccw about z or y-axis
   refdirection(:) = zero
   refdirection(1) = one
   CALL GETDIRVECTOR_D(refdirection, alpha, alphad, beta, betad, &
   &               dragdirection, dragdirectiond, liftindex)
   ! Lift direction given by the rotation of a unit vector
   ! initially aligned along the positive z-direction (0,0,1)
   ! 1) rotate alpha radians cw about y or z-axis
   ! 2) rotate beta radians ccw about z or y-axis
   refdirection(:) = zero
   refdirection(liftindex) = one
   CALL GETDIRVECTOR_D(refdirection, alpha, alphad, beta, betad, &
   &               liftdirection, liftdirectiond, liftindex)
   END SUBROUTINE ADJUSTINFLOWANGLE_D
