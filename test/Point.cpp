#include "Point.h"
#include <iostream>
using namespace std;

int Point::count = 0; //静态数据成员定义和初始化，使用类名限定。

Point::Point(const Point &p) : x(p.x), y(p.y) //复制构造函数
{
    count++;
}

void Point::showCount()
{ // 输出静态数据成员
    cout << " Object count: " << count << endl;
}