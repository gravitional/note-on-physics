program test
    implicit none
    x = x + 1
    z = x * y
        print *, 'debug statement 1 value of x,y,z ', x,y,z
    do ii =1,10
    z = x * ii
    if (ii == 5) then
        print *, 'debug do loop value of z when ii = 5 ',z
    end if
    end do
    if (z>2000) then
        print *, 'debug statement – z>2000 value of z ',z
        stop
    end if
    end program test