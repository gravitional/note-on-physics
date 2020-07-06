program ex0918
  implicit none
  integer :: at = 1, b = 2, c = 3
  namelist /na/ at,b,c
  write(*,nml=na)
  stop
end program