program mk2d_esurf

  use random
  implicit none

  integer, save :: seed = 2669124
  integer   :: i, j, f, nPart, nWall, bin1, bin2, potential
  character :: rubbish
  character(len=3) :: vdwType

  real      :: time
  real      :: rr, rr3, rr6, rc, LJcutoff, WCAcutoff
  real      :: uPot, eps

  integer, dimension(2) :: binResolution
  real(8), dimension(2) :: deltaBin
  real(8), dimension(3) :: lBox, lPore, rNew, rij
  real(8), dimension(:,:), allocatable :: rWall
  real(8), dimension(:,:), allocatable :: uSurf, nSurf

!  real(8),dimension(:), pointer :: x1, nPart1 !, rho
  
  ! resolution
  binResolution(1) = 40 
  binResolution(2) = 80

  ! input required information

  ! read number of particles
  open(unit=100,file='field.inp',status='old',action='read')
  read(unit=100, fmt=*) rubbish
  read(unit=100, fmt=*) rubbish
  read(unit=100, fmt=*) nPart, rubbish
  do i=1,5
    read(unit=100, fmt=*) rubbish
  end do
  read(unit=100, fmt=*) nWall, rubbish
  do i=1,6
    read(unit=100, fmt=*) rubbish
  end do
  ! read potential  
  read(unit=100, fmt=*) vdwType, vdwType, vdwType, eps, rubbish, rc
  close(unit=100)


  ! read number of data lines in file
  open(unit=200,file='control.inp',status='old',action='read')
  do i=1,14
    read(unit=200, fmt=*) rubbish
  end do
  read(unit=200, fmt=*) rubbish, lPore
  close(unit=200)
  ! add 1.5 sigma to lPore(3) to scan entire pore energy
  lPore(3) = lPore(3) + 1.0d0


  allocate( rWall(3, nWall) )
  !  read dimensions of the simulation box x,y,z and rWall
  open(unit=300,file='config.inp',status='old',action='read')
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) lBox
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) rubbish
  do i=1,(nPart+nWall)
    read(unit=300, fmt=*) rubbish
  end do
  read(unit=300, fmt=*) rubbish
  do i=1,nWall
    read(unit=300, fmt=*) rWall(:,i)
  end do
  close(unit=300)

  
  deltaBin(1) = 2.0d0*lPore(1)/binResolution(1) 
  deltaBin(2) = lPore(3)/binResolution(2)

  allocate( uSurf(binResolution(1), binResolution(2)) )
  allocate( nSurf(binResolution(1), binResolution(2)) )

  uSurf=0.0d0
  nSurf=0.0d0

  LJcutoff  = (1/rc)**12 - (1/rc)**6
  WCAcutoff = -0.25d0
  if (vdwType == 'wca') then
    potential = 1
  elseif (vdwType == 'lj ') then
    potential = 2
  end if

  select case (potential)

  case(1) ! WCA
   rc = 2**(1/6)
   do i=1,100000
    uPot=0.0d0
          rNew(1) = (ran(seed)-0.5d0)*lPore(1)*2.0d0
          rNew(2) = (ran(seed)-0.5d0)*lPore(2)
          rNew(3) = (ran(seed)-0.5d0)*lPore(3)
      do j=1,nWall
        rij(:) = rWall(:,j) - rNew(:)
        rij(:) = rij(:) - lBox(:)*nint(rij(:)/lBox(:))
        rr = dot_product( rij, rij )
        rr3 = rr*rr*rr
        rr6 = rr3*rr3
        if (rr < rc*rc) then
          uPot = uPot + 4*eps*( (1/rr6 - 1/rr3) - WCAcutoff )
        end if
      end do
      bin1 = int( (rNew(1) + lPore(1)) / deltaBin(1) ) + 1
      bin2 = int( (rNew(3) + lPore(3)*0.5) / deltaBin(2) ) + 1
      uSurf(bin1, bin2) = uSurf(bin1, bin2) + uPot
      nSurf(bin1, bin2) = nSurf(bin1, bin2) + 1
    end do

  case(2) ! LJ

    do i=1,100000
    uPot=0.0d0
          rNew(1) = (ran(seed)-0.5d0)*lPore(1)*2.0d0
          rNew(2) = (ran(seed)-0.5d0)*lPore(2)
          rNew(3) = (ran(seed)-0.5d0)*lPore(3)
      do j=1,nWall
        rij(:) = rWall(:,j) - rNew(:)
        rij(:) = rij(:) - lBox(:)*nint(rij(:)/lBox(:))
        rr = dot_product( rij, rij )
        rr3 = rr*rr*rr
        rr6 = rr3*rr3
        if (rr < rc*rc) then
          uPot = uPot + 4*eps*( (1/rr6 - 1/rr3) - LJcutoff )
        end if 
      end do
      bin1 = int( (rNew(1) + lPore(1)) / deltaBin(1) ) + 1
      bin2 = int( (rNew(3) + lPore(3)*0.5) / deltaBin(2) ) + 1
      uSurf(bin1, bin2) = uSurf(bin1, bin2) + uPot
      nSurf(bin1, bin2) = nSurf(bin1, bin2) + 1
    end do

  end select

  do i=1, binResolution(1)
    do j=1, binResolution(2)
      write(*,*) i, j, nSurf(i,j)
    end do
      write(*,*) " "
      write(*,*) " "
  end do



  open(unit=800,file='2Desurf.dat',status='unknown',action='write')
  write(unit=800,fmt="('#   x-coordinate',10x,'   z-coordinate',10x,'potential energy')")

  do i=1, binResolution(1)
    do j=1, binResolution(2) 
      write(unit=800,fmt="(3(2x,f15.7))") deltaBin(1)*(2*i-1)/2-lPore(1), deltaBin(2)*(2*j-1)/2-0.5d0*lPore(3), &
                                         uSurf(i,j)/nSurf(i,j)
    end do
      write(unit=800,fmt="(' ')")
      write(unit=800,fmt="(' ')")
  end do
  close(unit=800)

  do i=2, binResolution(1)
    uSurf(1,:) = uSurf(1,:) + uSurf(i,:) 
    nSurf(1,:) = nSurf(1,:) + nSurf(i,:)
  end do

  open(unit=900,file='wall_pot.dat',status='unknown',action='write')
  write(unit=900,fmt="('#   z-coordinate',10x,'potential energy')")

  do i=1, binResolution(2)
      write(unit=900,fmt="(2(2x,f15.7))") deltaBin(2)*(2*i-1)/2-0.5d0*lPore(3), uSurf(1,i)/nSurf(1,i)
  end do
 close(unit=900)

  deallocate(rWall)
  deallocate(uSurf)
  deallocate(nSurf)

  ! Request total cpu_time
  call cpu_time(time)
  print *, 'CPU time (min)', time/60.00
end program mk2d_esurf
