program normProfile

  implicit none

  integer   :: i, nLines
  character :: rubbish
  real      :: deltaBin

  real(8),dimension(3) :: lBox, lPore

  real(8),dimension(:), pointer :: x1, nPart1 !, rho
  
  ! input required information

  ! read number of data lines in file
  open(unit=200,file='control.inp',status='old',action='read')
  do i=1,13
    read(unit=200, fmt=*) rubbish
  end do
  read(unit=200, fmt=*) rubbish, nLines, rubbish
  read(unit=200, fmt=*) rubbish, lPore, rubbish
  close(unit=200)

  !  read dimensions of the simulation box x,y,z
  open(unit=300,file='config.inp',status='old',action='read')
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) lBox
  close(unit=300)

!  print *, 'Input required: porewidth'
!  read *, porewidth

  allocate( x1(nLines) )
  allocate( nPart1(nLines) )

  deltaBin = lBox(3)/nLines

  ! reading profiles

  open(unit=500,file='profile0.dat',status='old',action='read')
  read(unit=500,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=500,fmt=*) x1(i), nPart1(i), rubbish

  end do

  close(unit=500)


  open(unit=200,file='norm_profile0.dat',status='unknown',action='write')
  write(unit=200,fmt="('#   x-distance',8x,'rho(x)')")

  do i=1, nLines
!      width = lPore(3)
    write(unit=200,fmt="(2(2x,f12.6))") x1(i), nPart1(i)/deltaBin/lBox(2)/lPore(1)

  end do
  
end program normProfile
