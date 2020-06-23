# collier

COLLIER is a fortran 单圈--标量和张量的数值积分程序库。
这些积分出现在微扰的相对论性量子场论中。
它具有以下features：

+ 多粒子复杂度 scalar and tensor integrals
+ ultraviolet divergences 的维数正规化
+ soft infrared divergences 的维数正规化（对于非阿贝尔场，也支持 mass regularization）
+ 对于共线质量奇点的维数正规化或者质量正规化
+ 对于不稳定粒子，complex 内线质量完全支持（外动量和virtualities认作是实数）
+ 数值危险区域（小 Gram 或者其他运动学行列式），使用专用的展开处理。
+ 所有基本模块都有两种平行的实现方式，可以用作内部交叉检验
+ 缓存系统--用来加速计算
