program readProfile

  implicit none

  integer   :: i, nLines
  character :: rubbish
  real      :: xPos, width, porewidth, deltaBin

  real(8),dimension(3) :: lBox

  real(8),dimension(:), pointer :: x1, x2, nPart1, nPart2 !, rho
  
  ! input required information

  ! read number of data lines in file
  open(unit=200,file='control.inp',status='old',action='read')
  do i=1,13
    read(unit=200, fmt=*) rubbish
  end do
  read(unit=200, fmt=*) rubbish, nLines, rubbish
  close(unit=200)
  
  !  read dimensions of the simulation box x,y,z
  open(unit=300,file='config.inp',status='old',action='read')
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) lBox
  close(unit=300)

  print *, 'porewidth   |  x-positions of pore i.e. porelength/2:'
  read *, porewidth, xPos

  allocate( x1(nLines) )
  allocate( x2(nLines) )
  allocate( nPart1(nLines) )
  allocate( nPart2(nLines) )

  deltaBin = lBox(1)/nLines

  ! reading profiles

  open(unit=500,file='profile1.dat',status='old',action='read')
  read(unit=500,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=500,fmt=*) x1(i), nPart1(i), rubbish

  end do

  close(unit=500)

  open(unit=600,file='profile2.dat',status='old',action='read')
 
  read(unit=600,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=600,fmt=*) x2(i), nPart2(i), rubbish

  end do

  close(unit=600)

  open(unit=200,file='modProfile.dat',status='unknown',action='write')
  write(unit=200,fmt="('#   x-distance',10x,'rho1',10x,'rho2',11x,'rho',9x,'width')")

  do i=1, nLines
    if(abs(x1(i)) > xPos) then
      width = lBox(3)
    else
      width = porewidth
    end if

    write(unit=200,fmt="(5(2x,f12.6))") x1(i),&
                                        nPart1(i)/deltaBin/lBox(2)/width,& 
                                        nPart2(i)/deltaBin/lBox(2)/width,&
                                        (nPart1(i)+nPart2(i))/deltaBin/lBox(2)/width,&
                                        width
  end do
  
end program readProfile
