!        generated by tapenade     (inria, tropics team)
!  tapenade 3.10 (r5363) -  9 sep 2014 09:53
!
!  differentiation of prodkatolaunder in forward (tangent) mode (with options i4 dr8 r8):
!   variations   of useful results: *scratch
!   with respect to varying inputs: timeref *w *vol *si *sj *sk
!   plus diff mem management of: w:in scratch:in vol:in si:in sj:in
!                sk:in
!
!      ******************************************************************
!      *                                                                *
!      * file:          prodkatolaunder.f90                             *
!      * author:        georgi kalitzin, edwin van der weide            *
!      * starting date: 08-01-2003                                      *
!      * last modified: 06-12-2005                                      *
!      *                                                                *
!      ******************************************************************
!
subroutine prodkatolaunder_d()
!
!      ******************************************************************
!      *                                                                *
!      * prodkatolaunder computes the turbulent production term using   *
!      * the kato-launder formulation.                                  *
!      *                                                                *
!      ******************************************************************
!
  use blockpointers
  use flowvarrefstate
  use section
  use turbmod
  implicit none
!
!      local variables.
!
  integer(kind=inttype) :: i, j, k
  real(kind=realtype) :: uux, uuy, uuz, vvx, vvy, vvz, wwx, wwy, wwz
  real(kind=realtype) :: uuxd, uuyd, uuzd, vvxd, vvyd, vvzd, wwxd, wwyd&
& , wwzd
  real(kind=realtype) :: qxx, qyy, qzz, qxy, qxz, qyz, sijsij
  real(kind=realtype) :: qxxd, qyyd, qzzd, qxyd, qxzd, qyzd, sijsijd
  real(kind=realtype) :: oxy, oxz, oyz, oijoij
  real(kind=realtype) :: oxyd, oxzd, oyzd, oijoijd
  real(kind=realtype) :: fact, omegax, omegay, omegaz
  real(kind=realtype) :: factd, omegaxd, omegayd, omegazd
  intrinsic sqrt
  real(kind=realtype) :: arg1
  real(kind=realtype) :: arg1d
  real(kind=realtype) :: result1
  real(kind=realtype) :: result1d
!
!      ******************************************************************
!      *                                                                *
!      * begin execution                                                *
!      *                                                                *
!      ******************************************************************
!
! determine the non-dimensional wheel speed of this block.
! the vorticity term, which appears in kato-launder is of course
! not frame invariant. to approximate frame invariance the wheel
! speed should be substracted from oxy, oxz and oyz, which results
! in the vorticity in the rotating frame. however some people
! claim that the absolute vorticity should be used to obtain the
! best results. in that omega should be set to zero.
  omegaxd = sections(sectionid)%rotrate(1)*timerefd
  omegax = timeref*sections(sectionid)%rotrate(1)
  omegayd = sections(sectionid)%rotrate(2)*timerefd
  omegay = timeref*sections(sectionid)%rotrate(2)
  omegazd = sections(sectionid)%rotrate(3)*timerefd
  omegaz = timeref*sections(sectionid)%rotrate(3)
  scratchd = 0.0_8
! loop over the cell centers of the given block. it may be more
! efficient to loop over the faces and to scatter the gradient,
! but in that case the gradients for u, v and w must be stored.
! in the current approach no extra memory is needed.
  do k=2,kl
    do j=2,jl
      do i=2,il
! compute the gradient of u in the cell center. use is made
! of the fact that the surrounding normals sum up to zero,
! such that the cell i,j,k does not give a contribution.
! the gradient is scaled by a factor 2*vol.
        uuxd = wd(i+1, j, k, ivx)*si(i, j, k, 1) + w(i+1, j, k, ivx)*sid&
&         (i, j, k, 1) - wd(i-1, j, k, ivx)*si(i-1, j, k, 1) - w(i-1, j&
&         , k, ivx)*sid(i-1, j, k, 1) + wd(i, j+1, k, ivx)*sj(i, j, k, 1&
&         ) + w(i, j+1, k, ivx)*sjd(i, j, k, 1) - wd(i, j-1, k, ivx)*sj(&
&         i, j-1, k, 1) - w(i, j-1, k, ivx)*sjd(i, j-1, k, 1) + wd(i, j&
&         , k+1, ivx)*sk(i, j, k, 1) + w(i, j, k+1, ivx)*skd(i, j, k, 1)&
&         - wd(i, j, k-1, ivx)*sk(i, j, k-1, 1) - w(i, j, k-1, ivx)*skd(&
&         i, j, k-1, 1)
        uux = w(i+1, j, k, ivx)*si(i, j, k, 1) - w(i-1, j, k, ivx)*si(i-&
&         1, j, k, 1) + w(i, j+1, k, ivx)*sj(i, j, k, 1) - w(i, j-1, k, &
&         ivx)*sj(i, j-1, k, 1) + w(i, j, k+1, ivx)*sk(i, j, k, 1) - w(i&
&         , j, k-1, ivx)*sk(i, j, k-1, 1)
        uuyd = wd(i+1, j, k, ivx)*si(i, j, k, 2) + w(i+1, j, k, ivx)*sid&
&         (i, j, k, 2) - wd(i-1, j, k, ivx)*si(i-1, j, k, 2) - w(i-1, j&
&         , k, ivx)*sid(i-1, j, k, 2) + wd(i, j+1, k, ivx)*sj(i, j, k, 2&
&         ) + w(i, j+1, k, ivx)*sjd(i, j, k, 2) - wd(i, j-1, k, ivx)*sj(&
&         i, j-1, k, 2) - w(i, j-1, k, ivx)*sjd(i, j-1, k, 2) + wd(i, j&
&         , k+1, ivx)*sk(i, j, k, 2) + w(i, j, k+1, ivx)*skd(i, j, k, 2)&
&         - wd(i, j, k-1, ivx)*sk(i, j, k-1, 2) - w(i, j, k-1, ivx)*skd(&
&         i, j, k-1, 2)
        uuy = w(i+1, j, k, ivx)*si(i, j, k, 2) - w(i-1, j, k, ivx)*si(i-&
&         1, j, k, 2) + w(i, j+1, k, ivx)*sj(i, j, k, 2) - w(i, j-1, k, &
&         ivx)*sj(i, j-1, k, 2) + w(i, j, k+1, ivx)*sk(i, j, k, 2) - w(i&
&         , j, k-1, ivx)*sk(i, j, k-1, 2)
        uuzd = wd(i+1, j, k, ivx)*si(i, j, k, 3) + w(i+1, j, k, ivx)*sid&
&         (i, j, k, 3) - wd(i-1, j, k, ivx)*si(i-1, j, k, 3) - w(i-1, j&
&         , k, ivx)*sid(i-1, j, k, 3) + wd(i, j+1, k, ivx)*sj(i, j, k, 3&
&         ) + w(i, j+1, k, ivx)*sjd(i, j, k, 3) - wd(i, j-1, k, ivx)*sj(&
&         i, j-1, k, 3) - w(i, j-1, k, ivx)*sjd(i, j-1, k, 3) + wd(i, j&
&         , k+1, ivx)*sk(i, j, k, 3) + w(i, j, k+1, ivx)*skd(i, j, k, 3)&
&         - wd(i, j, k-1, ivx)*sk(i, j, k-1, 3) - w(i, j, k-1, ivx)*skd(&
&         i, j, k-1, 3)
        uuz = w(i+1, j, k, ivx)*si(i, j, k, 3) - w(i-1, j, k, ivx)*si(i-&
&         1, j, k, 3) + w(i, j+1, k, ivx)*sj(i, j, k, 3) - w(i, j-1, k, &
&         ivx)*sj(i, j-1, k, 3) + w(i, j, k+1, ivx)*sk(i, j, k, 3) - w(i&
&         , j, k-1, ivx)*sk(i, j, k-1, 3)
! idem for the gradient of v.
        vvxd = wd(i+1, j, k, ivy)*si(i, j, k, 1) + w(i+1, j, k, ivy)*sid&
&         (i, j, k, 1) - wd(i-1, j, k, ivy)*si(i-1, j, k, 1) - w(i-1, j&
&         , k, ivy)*sid(i-1, j, k, 1) + wd(i, j+1, k, ivy)*sj(i, j, k, 1&
&         ) + w(i, j+1, k, ivy)*sjd(i, j, k, 1) - wd(i, j-1, k, ivy)*sj(&
&         i, j-1, k, 1) - w(i, j-1, k, ivy)*sjd(i, j-1, k, 1) + wd(i, j&
&         , k+1, ivy)*sk(i, j, k, 1) + w(i, j, k+1, ivy)*skd(i, j, k, 1)&
&         - wd(i, j, k-1, ivy)*sk(i, j, k-1, 1) - w(i, j, k-1, ivy)*skd(&
&         i, j, k-1, 1)
        vvx = w(i+1, j, k, ivy)*si(i, j, k, 1) - w(i-1, j, k, ivy)*si(i-&
&         1, j, k, 1) + w(i, j+1, k, ivy)*sj(i, j, k, 1) - w(i, j-1, k, &
&         ivy)*sj(i, j-1, k, 1) + w(i, j, k+1, ivy)*sk(i, j, k, 1) - w(i&
&         , j, k-1, ivy)*sk(i, j, k-1, 1)
        vvyd = wd(i+1, j, k, ivy)*si(i, j, k, 2) + w(i+1, j, k, ivy)*sid&
&         (i, j, k, 2) - wd(i-1, j, k, ivy)*si(i-1, j, k, 2) - w(i-1, j&
&         , k, ivy)*sid(i-1, j, k, 2) + wd(i, j+1, k, ivy)*sj(i, j, k, 2&
&         ) + w(i, j+1, k, ivy)*sjd(i, j, k, 2) - wd(i, j-1, k, ivy)*sj(&
&         i, j-1, k, 2) - w(i, j-1, k, ivy)*sjd(i, j-1, k, 2) + wd(i, j&
&         , k+1, ivy)*sk(i, j, k, 2) + w(i, j, k+1, ivy)*skd(i, j, k, 2)&
&         - wd(i, j, k-1, ivy)*sk(i, j, k-1, 2) - w(i, j, k-1, ivy)*skd(&
&         i, j, k-1, 2)
        vvy = w(i+1, j, k, ivy)*si(i, j, k, 2) - w(i-1, j, k, ivy)*si(i-&
&         1, j, k, 2) + w(i, j+1, k, ivy)*sj(i, j, k, 2) - w(i, j-1, k, &
&         ivy)*sj(i, j-1, k, 2) + w(i, j, k+1, ivy)*sk(i, j, k, 2) - w(i&
&         , j, k-1, ivy)*sk(i, j, k-1, 2)
        vvzd = wd(i+1, j, k, ivy)*si(i, j, k, 3) + w(i+1, j, k, ivy)*sid&
&         (i, j, k, 3) - wd(i-1, j, k, ivy)*si(i-1, j, k, 3) - w(i-1, j&
&         , k, ivy)*sid(i-1, j, k, 3) + wd(i, j+1, k, ivy)*sj(i, j, k, 3&
&         ) + w(i, j+1, k, ivy)*sjd(i, j, k, 3) - wd(i, j-1, k, ivy)*sj(&
&         i, j-1, k, 3) - w(i, j-1, k, ivy)*sjd(i, j-1, k, 3) + wd(i, j&
&         , k+1, ivy)*sk(i, j, k, 3) + w(i, j, k+1, ivy)*skd(i, j, k, 3)&
&         - wd(i, j, k-1, ivy)*sk(i, j, k-1, 3) - w(i, j, k-1, ivy)*skd(&
&         i, j, k-1, 3)
        vvz = w(i+1, j, k, ivy)*si(i, j, k, 3) - w(i-1, j, k, ivy)*si(i-&
&         1, j, k, 3) + w(i, j+1, k, ivy)*sj(i, j, k, 3) - w(i, j-1, k, &
&         ivy)*sj(i, j-1, k, 3) + w(i, j, k+1, ivy)*sk(i, j, k, 3) - w(i&
&         , j, k-1, ivy)*sk(i, j, k-1, 3)
! and for the gradient of w.
        wwxd = wd(i+1, j, k, ivz)*si(i, j, k, 1) + w(i+1, j, k, ivz)*sid&
&         (i, j, k, 1) - wd(i-1, j, k, ivz)*si(i-1, j, k, 1) - w(i-1, j&
&         , k, ivz)*sid(i-1, j, k, 1) + wd(i, j+1, k, ivz)*sj(i, j, k, 1&
&         ) + w(i, j+1, k, ivz)*sjd(i, j, k, 1) - wd(i, j-1, k, ivz)*sj(&
&         i, j-1, k, 1) - w(i, j-1, k, ivz)*sjd(i, j-1, k, 1) + wd(i, j&
&         , k+1, ivz)*sk(i, j, k, 1) + w(i, j, k+1, ivz)*skd(i, j, k, 1)&
&         - wd(i, j, k-1, ivz)*sk(i, j, k-1, 1) - w(i, j, k-1, ivz)*skd(&
&         i, j, k-1, 1)
        wwx = w(i+1, j, k, ivz)*si(i, j, k, 1) - w(i-1, j, k, ivz)*si(i-&
&         1, j, k, 1) + w(i, j+1, k, ivz)*sj(i, j, k, 1) - w(i, j-1, k, &
&         ivz)*sj(i, j-1, k, 1) + w(i, j, k+1, ivz)*sk(i, j, k, 1) - w(i&
&         , j, k-1, ivz)*sk(i, j, k-1, 1)
        wwyd = wd(i+1, j, k, ivz)*si(i, j, k, 2) + w(i+1, j, k, ivz)*sid&
&         (i, j, k, 2) - wd(i-1, j, k, ivz)*si(i-1, j, k, 2) - w(i-1, j&
&         , k, ivz)*sid(i-1, j, k, 2) + wd(i, j+1, k, ivz)*sj(i, j, k, 2&
&         ) + w(i, j+1, k, ivz)*sjd(i, j, k, 2) - wd(i, j-1, k, ivz)*sj(&
&         i, j-1, k, 2) - w(i, j-1, k, ivz)*sjd(i, j-1, k, 2) + wd(i, j&
&         , k+1, ivz)*sk(i, j, k, 2) + w(i, j, k+1, ivz)*skd(i, j, k, 2)&
&         - wd(i, j, k-1, ivz)*sk(i, j, k-1, 2) - w(i, j, k-1, ivz)*skd(&
&         i, j, k-1, 2)
        wwy = w(i+1, j, k, ivz)*si(i, j, k, 2) - w(i-1, j, k, ivz)*si(i-&
&         1, j, k, 2) + w(i, j+1, k, ivz)*sj(i, j, k, 2) - w(i, j-1, k, &
&         ivz)*sj(i, j-1, k, 2) + w(i, j, k+1, ivz)*sk(i, j, k, 2) - w(i&
&         , j, k-1, ivz)*sk(i, j, k-1, 2)
        wwzd = wd(i+1, j, k, ivz)*si(i, j, k, 3) + w(i+1, j, k, ivz)*sid&
&         (i, j, k, 3) - wd(i-1, j, k, ivz)*si(i-1, j, k, 3) - w(i-1, j&
&         , k, ivz)*sid(i-1, j, k, 3) + wd(i, j+1, k, ivz)*sj(i, j, k, 3&
&         ) + w(i, j+1, k, ivz)*sjd(i, j, k, 3) - wd(i, j-1, k, ivz)*sj(&
&         i, j-1, k, 3) - w(i, j-1, k, ivz)*sjd(i, j-1, k, 3) + wd(i, j&
&         , k+1, ivz)*sk(i, j, k, 3) + w(i, j, k+1, ivz)*skd(i, j, k, 3)&
&         - wd(i, j, k-1, ivz)*sk(i, j, k-1, 3) - w(i, j, k-1, ivz)*skd(&
&         i, j, k-1, 3)
        wwz = w(i+1, j, k, ivz)*si(i, j, k, 3) - w(i-1, j, k, ivz)*si(i-&
&         1, j, k, 3) + w(i, j+1, k, ivz)*sj(i, j, k, 3) - w(i, j-1, k, &
&         ivz)*sj(i, j-1, k, 3) + w(i, j, k+1, ivz)*sk(i, j, k, 3) - w(i&
&         , j, k-1, ivz)*sk(i, j, k-1, 3)
! compute the strain and vorticity terms. the multiplication
! is present to obtain the correct gradients. note that
! the wheel speed is substracted from the vorticity terms.
        factd = -(half*vold(i, j, k)/vol(i, j, k)**2)
        fact = half/vol(i, j, k)
        qxxd = factd*uux + fact*uuxd
        qxx = fact*uux
        qyyd = factd*vvy + fact*vvyd
        qyy = fact*vvy
        qzzd = factd*wwz + fact*wwzd
        qzz = fact*wwz
        qxyd = half*(factd*(uuy+vvx)+fact*(uuyd+vvxd))
        qxy = fact*half*(uuy+vvx)
        qxzd = half*(factd*(uuz+wwx)+fact*(uuzd+wwxd))
        qxz = fact*half*(uuz+wwx)
        qyzd = half*(factd*(vvz+wwy)+fact*(vvzd+wwyd))
        qyz = fact*half*(vvz+wwy)
        oxyd = half*(factd*(vvx-uuy)+fact*(vvxd-uuyd)) - omegazd
        oxy = fact*half*(vvx-uuy) - omegaz
        oxzd = half*(factd*(uuz-wwx)+fact*(uuzd-wwxd)) - omegayd
        oxz = fact*half*(uuz-wwx) - omegay
        oyzd = half*(factd*(wwy-vvz)+fact*(wwyd-vvzd)) - omegaxd
        oyz = fact*half*(wwy-vvz) - omegax
! compute the summation of the strain and vorticity tensors.
        sijsijd = two*(2*qxy*qxyd+2*qxz*qxzd+2*qyz*qyzd) + 2*qxx*qxxd + &
&         2*qyy*qyyd + 2*qzz*qzzd
        sijsij = two*(qxy**2+qxz**2+qyz**2) + qxx**2 + qyy**2 + qzz**2
        oijoijd = two*(2*oxy*oxyd+2*oxz*oxzd+2*oyz*oyzd)
        oijoij = two*(oxy**2+oxz**2+oyz**2)
! compute the production term.
        arg1d = sijsijd*oijoij + sijsij*oijoijd
        arg1 = sijsij*oijoij
        if (arg1 .eq. 0.0_8) then
          result1d = 0.0_8
        else
          result1d = arg1d/(2.0*sqrt(arg1))
        end if
        result1 = sqrt(arg1)
        scratchd(i, j, k, iprod) = two*result1d
        scratch(i, j, k, iprod) = two*result1
      end do
    end do
  end do
end subroutine prodkatolaunder_d
