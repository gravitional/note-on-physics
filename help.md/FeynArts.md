# FeynArts

`Vertex[adj][n]`: 具有邻接关系`adj`,counter-term 阶为`0`的顶点, 编号为`n`.
`Vertex[adj, cto][n]`:具有邻接关系`adj`,counter-term 阶为`cto`的顶点, 编号为`n`

`Propagator[t][from, to]`:传播子类型为`t`，从`from`到`to`
`Propagator[t][from, to, field]`: 传播子类型为`t`，从`from`到`to`，传播的场为`field`

传播子的可能类型：

`Incoming, Outgoing`: 入射或出射的外部传播子
`External`: 外线传播子，无特定方向
`Internal`:内线传播子，但不是圈图的一部分
`Loop[n]`: 圈`n`上的内线传播子

`Loop [n]`中的`n`不是实际的圈图编号（通常不能明确确定），而是圈图中单粒子不可约圈图块的编号。
单粒子不可约图即构成圈图的粗粒单元。

然后传播子构成`topologies`，

`Topology[p1 , p2 , ...]`: 代表传播子为`pi`的 topology.
`Topology[s][...]`: 组合因子，也就是对称系数为`1/s`.

`TopologyList[t1 , t2 , ...]` : topologies `ti` 组成的列表.
`TopologyList[info][...]`: 带有额外信息`info`的列表.

计算拓扑使用的是递归算法，可以指定从某一级拓扑开始，例如两圈的初始拓扑定义为:

```mathematica
StartTop[2, 0] = TopologyList[
    define[Theta] = Topology[12][
        Propagator[Loop[1]][Vertex[3][-2], Vertex[3][-1]],
        Propagator[Loop[1]][Vertex[3][-2], Vertex[3][-1]],
        Propagator[Loop[1]][Vertex[3][-2], Vertex[3][-1]] ],
    define[Eight] = Topology[8][
        Propagator[Loop[1]][Vertex[4][1], Vertex[4][1]],
        Propagator[Loop[1]][Vertex[4][1], Vertex[4][1]] ],
    define[Bicycle] = Topology[8][
        Propagator[Internal][Vertex[3][-2], Vertex[3][-1]],
        Propagator[Loop[1]][Vertex[3][-2], Vertex[3][-2]],
        Propagator[Loop[2]][Vertex[3][-1], Vertex[3][-1]] ]
]
```

## 实例化拓扑中的场

`FeynArts`的场分成一定层次, 越深层越具体:

+ `Generic`,
+ `Classes`,
+ `Particles`
