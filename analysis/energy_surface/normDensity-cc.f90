program normDensity

  implicit none

  integer   :: i, nLines
  character :: rubbish
  real      :: xPos, width, porewidth, deltaBin

  real(8),dimension(3) :: lBox

  real(8),dimension(:), pointer :: x1, nPart1 !, rho
  
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
  allocate( nPart1(nLines) )

  deltaBin = lBox(1)/nLines

  ! reading profiles

  open(unit=400,file='profile0.dat',status='old',action='read')
  read(unit=400,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=400,fmt=*) x1(i), nPart1(i), rubbish

  end do

  close(unit=400)


  open(unit=500,file='density0.dat',status='unknown',action='write')
  write(unit=500,fmt="('#   x-distance',10x,'rho1',10x,'rho2',11x,'rho',9x,'width')")

  do i=1, nLines
    if(abs(x1(i)) > xPos) then
      width = lBox(3)
    else
      width = porewidth
    end if

    write(unit=500,fmt="(5(2x,f12.6))") x1(i),&
                                        nPart1(i)/deltaBin/lBox(2)/width, width
  end do
 
  close(unit=500)

  ! reading profiles

  open(unit=600,file='profile1.dat',status='old',action='read')
  read(unit=600,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=600,fmt=*) x1(i), nPart1(i), rubbish

  end do

  close(unit=600)


  open(unit=700,file='density1.dat',status='unknown',action='write')
  write(unit=700,fmt="('#   x-distance',10x,'rho1',10x,'rho2',11x,'rho',9x,'width')")

  do i=1, nLines
    if(abs(x1(i)) > xPos) then
      width = lBox(3)
    else
      width = porewidth
    end if

    write(unit=700,fmt="(5(2x,f12.6))") x1(i),&
                                        nPart1(i)/deltaBin/lBox(2)/width, width
  end do
 
  close(unit=700)

  ! reading profiles

  open(unit=800,file='profile2.dat',status='old',action='read')
  read(unit=800,fmt=*) ! Don't read first line

  do i=1, nLines

    read(unit=800,fmt=*) x1(i), nPart1(i), rubbish

  end do

  close(unit=800)


  open(unit=900,file='density2.dat',status='unknown',action='write')
  write(unit=900,fmt="('#   x-distance',10x,'rho1',10x,'rho2',11x,'rho',9x,'width')")

  do i=1, nLines
    if(abs(x1(i)) > xPos) then
      width = lBox(3)
    else
      width = porewidth
    end if

    write(unit=900,fmt="(5(2x,f12.6))") x1(i),&
                                        nPart1(i)/deltaBin/lBox(2)/width, width
  end do

  close(unit=900)
 
end program normDensity
