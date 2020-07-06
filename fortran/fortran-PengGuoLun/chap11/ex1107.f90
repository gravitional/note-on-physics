module time_util
  implicit none
  type :: MyTime
    integer :: hour,minute
  end type MyTime
  interface operator(.Plus.) ! ��type(time)���ͱ����ܹ����
    module procedure add
  end interface

contains
  function add( a, b )
    implicit none
    type(MyTime), intent(in) :: a,b
    type(MyTime) :: add
    integer :: minutes,carry
    minutes=a%minute+b%minute
    carry=minutes/60
    add%minute=mod(minutes,60)   ! ȡ����
    add%hour=a%hour+b%hour+carry 
    return
  end function add

  subroutine output(t)
    type(MyTime), intent(in) :: t
	write(*,"(I2,':',I2.2)") t%hour, t%minute
	return
  end subroutine

end module

program ex1107
  use time_util
  implicit none
  type(MyTime) :: a,b,c
  
  a=MyTime(1,45)
  b=MyTime(2,18)
  c=a.plus.MyTime(2,18) ! ʵ�ʻ���ú���add
  call output(c)

  stop
end program
