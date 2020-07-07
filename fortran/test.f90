program test
    implicit none
    integer :: i,j
    
    outter: DO i=1,3
        inner: do j=1,3
            write (*,"('(',i5,',',i2')')") i,j
        END DO inner
    END DO outter

    stop
    end program test