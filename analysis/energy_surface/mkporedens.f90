program mkporedens

  ! creates a rho(z) plot from the traj file, i.e. the pore density distribution.

  implicit none

  integer   :: i, j, f, nPart, nWall, nFrames, bin1, bin2
  integer   :: nrBins, startBin
  character :: rubbish

  real      :: time
  real      :: totalStep, initialStep, intervStep, optionStep
  real      :: startPore

  integer,dimension(2) :: binResolution 
  real(8),dimension(2) :: deltaBin
  real(8),dimension(3) :: lBox
  real(8),dimension(3) :: rPart
  real(8), dimension(:,:), allocatable :: rhoProfile
  real(8), dimension(:), allocatable :: rhoPore

!  real(8),dimension(:), pointer :: x1, nPart1 !, rho
  
  ! resolution
  binResolution(1) = 10 !0
  binResolution(2) = 400!0

  ! input required information

  print *, 'Where does the pore start (x coord)?'
  read *, startPore

  ! read number of particles
  open(unit=100,file='field.inp',status='old',action='read')
  read(unit=100, fmt=*) rubbish
  read(unit=100, fmt=*) rubbish
  read(unit=100, fmt=*) nPart, rubbish
  do i=1,5
    read(unit=100, fmt=*) rubbish
  end do
  read(unit=100, fmt=*) nWall, rubbish
  close(unit=100)

  ! read number of data lines in file
  open(unit=200,file='control.inp',status='old',action='read')
  read(unit=200, fmt=*) rubbish
  read(unit=200, fmt=*) rubbish
  read(unit=200, fmt=*) rubbish, totalStep
  do i=1,6
    read(unit=200, fmt=*) rubbish
  end do
  read(unit=200, fmt=*) rubbish, initialStep, intervStep, optionStep
  close(unit=200)
  
  !  read dimensions of the simulation box x,y,z
  open(unit=300,file='config.inp',status='old',action='read')
  read(unit=300, fmt=*) rubbish
  read(unit=300, fmt=*) lBox
  close(unit=300)

  print *, 'Is everything correct?'
  print *, 'lBox ', lBox
  print *, 'nPart', nPart,' nWall ', nWall
!  print *, initialStep, intervStep, optionStep, totalStep

  nFrames = (totalStep - initialStep) / intervStep 
  
  deltaBin(1) = lBox(1)/binResolution(1) 
  deltaBin(2) = lBox(3)/binResolution(2)

  print *, 'nFrames ', nFrames
  print *, 'binRes ', binResolution
  print *, 'deltaBin ', deltaBin

  allocate( rhoProfile(binResolution(1),binResolution(2)) )
  allocate( rhoPore(binResolution(2)) )
  rhoProfile(:,:) = 0
  rhoPore(:) = 0
  open(unit=400,file='traj.xyz',status='old',action='read')

  do f=1,nFrames
    read(unit=400, fmt=*) rubbish
    read(unit=400, fmt=*) rubbish
    do i=1,nPart
      read(unit=400, fmt=*) rubbish, rPart
      bin1 = int( (rPart(1) + lBox(1)*0.5) / deltaBin(1) ) + 1
      bin2 = int( (rPart(3) + lBox(3)*0.5) / deltaBin(2) ) + 1
      rhoProfile(bin1,bin2) = rhoProfile(bin1,bin2) + 1
    end do
    do i=1,nWall  
      read(unit=400, fmt=*) rubbish
    end do
  end do
  close(unit=400)
  rhoProfile(:,:) = rhoProfile(:,:) / nFrames
  
  ! average along the pore
  startBin = (lBox(1)*0.5 - startPore) / deltaBin(1)
  nrBins = 2*startPore / deltaBin(1)
  do i=1,nrBins
    do j=1,binResolution(2)
      rhoPore(j) = rhoPore(j) + rhoProfile(startBin+i,j)
    end do
  end do

  open(unit=800,file='2Dprofile.dat',status='unknown',action='write')
  write(unit=800,fmt="('#   x-coordinate',10x,'   z-coordinate',10x,'rho',11x,'rho',9x,'width')")

  do i=1, binResolution(1)
    do j=1, binResolution(2) 
      write(unit=800,fmt="(3(2x,f12.7))") deltaBin(1)*(2*i-1)/2-0.5d0*lBox(1), deltaBin(2)*(2*j-1)/2-0.5d0*lBox(3), &
                                         rhoProfile(i,j)/deltaBin(1)/deltaBin(2)/lBox(2)
!     print *, deltaBin(1)*(2*i-1)/2, deltaBin(2)*(2*j-1)/2, rhoProfile(i,j)
    end do
      write(unit=800,fmt="(' ')")
!      write(unit=800,fmt="(' ')")
  end do
  close(unit=800)
  
  open(unit=900,file='PoreProfile.dat',status='unknown',action='write')
  write(unit=900,fmt="('#   z-coordinate',10x,'rho',11x,'rho')")

    do j=1, binResolution(2) 
      write(unit=900,fmt="(3(2x,f12.7))") deltaBin(2)*(2*j-1)/2-0.5d0*lBox(3), &
                                         rhoPore(j)/2/startPore/startPore/deltaBin(2)/lBox(2)
!     print *, deltaBin(1)*(2*i-1)/2, deltaBin(2)*(2*j-1)/2, rhoProfile(i,j)
    end do
  close(unit=900)

  ! Request total cpu_time
  call cpu_time(time)
  print *, 'CPU time (min)', time/60.00
end program mkporedens
