# learn.tikz.md

`TikZ-Feynman` provides a new way to draw Feynman diagrams in LATEX that does not rely on external programs and uses a clear extensible syntax.
If you use `TikZ-Feynman` in an academic setting, please cite:
`J. Ellis, ‘TikZ-Feynman: Feynmandiagrams with TikZ’, (2016), arXiv: 1601.05437 [hep-ph]`

## Tutorial --教程

### Loading the Package --载入包

After installing the package, the TikZ-Feynman package can be loaded with `\usepackage{tikz-feynman}` in the preamble.
It is recommend that you also specify the **version of TikZ-Feynman** to use with the optional package argument compat :
`\usepackage[compat=1.1.0]{tikz-feynman}`.
This ensures that any new versions of TikZ-Feynman do not produce any undesirable changes without warning.

### A First Diagram --第一个图

Feynman diagrams can be declared with the `\feynmandiagram` command.
It is analogous to the `\tikz` command from `TikZ` and requires a final semi-colon( `;` ) to finish the environment. For example, a simple s -channel diagram is:

```tikz
\feynmandiagram [horizontal=a to b] {
i1 -- [fermion] a -- [fermion] i2,
a -- [photon] b,
f1 -- [fermion] b -- [fermion] f2,
};
```

Let’s go through this example line by line:

+ Line 1 : `\feynmandiagram` introduces the Feynman diagram and allows for optiona larguments to be given in the brackets `[<options>]`. In this instance, `horizontal=a to b` orients the algorithm outputs such that the line through vertices `a` and `b` is horizontal.
+ Line 2 : The left fermion line is drawn by declaring three vertices ( `i1`, `a` and `i2` ) and connecting them with `edges`(边；边缘；边线；边沿) `--`. Just like the `\feynmandiagram` command above,each edge also take optional arguments specified in brackets `[<options>]`. In this instance, we want these edges to have arrows to indicate that they are fermion lines, so we add the fermion style to them.
As you will see later on, optional arguments can also be given to the vertices in exactly the same way.
+ Line 3 This edge connects vertices `a` and `b` with an edge styled as a photon. Since there is already a vertex labelled `a`, the algorithm will connect it to a new vertex labeled `b` .
+ Line 4 This line is analogous to line `2` and introduces two new vertices, `f1` and `f2`. It re-uses the previously labelled `b` vertex.
+ Line 5 Finish the declaration of the Feynman diagram. The final semi-colon (`;`) is important.

The name given to eac`<vertex>`n the graph does not matter.
So in this example, `i1`, `i2` denote the initial particles;
`f1`, `f2` denotes the final particles;
and `a`, `b` are the end points of the propagator.
The only importantaspectis that what we called `a` in `line 2` is also `a` in `line 3` so that the underlying algorithm treats them as the same vertex.
The order in which vertices are declared does not matter as the default algorithm re-arranges everything. For example,one might prefer to draw the fermion lines all at once, as with the following example (note also that the way we named vertices is completely different):

```tikz
\feynmandiagram [horizontal=f2 to f3] {
f1 -- [fermion] f2 -- [fermion] f3 -- [fermion] f4,
f2 -- [photon] p1,
f3 -- [photon] p2,
};
```

As a final remark,the calculation of where vertices should be placed is usually done through an algorithm written in Lua. As a result, LuaTEX is required in order to make use of these algorithms. If LuaTEX is not used, TikZ-Feynman will default to a more rudimentary algorithm and will warn the user instead.

### Adding Styles --添加样式

So far, the examples have only used the photon and fermion styles.
The TikZ-Feynman package comes with quite a few extra styles for edges and vertices which are all documented over in section 3.
As an example, it is possible to add momentum arrows with `momentum=<text>`, and in the case of end vertices, the particle can be labelled with `particle=<text>`. As an example, we take the generic s-channel diagram from section 2.2 and make it a $e^+~e^−~\to~\mu^+ ~\mu^−$ diagram.

```tikz
\feynmandiagram [horizontal=a to b] {
i1 [particle=\(e^{-}\)] -- [fermion] a -- [fermion] i2 [particle=\(e^{+}\)],
a -- [photon, edge label=\(\gamma\), momentum'=\(k\)] b,
f1 [particle=\(\mu^{+}\)] -- [fermion] b -- [fermion] f2 [particle=\(\mu^{-}\)],
};
```

In addition to the style keys documented below, style keys from TikZ can be used as well:

```tikz
\feynmandiagram [horizontal=a to b] {
i1 [particle=\(e^{-}\)] -- [fermion, very thick] a -- [fermion, opacity=0.2] i2 [particle=\(e^{+}\)],
a -- [red, photon, edge label=\(\gamma\), momentum'={[arrow style=red]\(k\)}] b,
f1 [particle=\(\mu^{+}\)] -- [fermion, opacity=0.2] b -- [fermion, very thick] f2 [particle=\(\mu^{-}\)],
};
```

For a list of all the various styles that TikZ provides, have a look at the TikZ manual; it is extremely thorough and provides many usage examples.
TikZ-Feynman also supports combining styles together which can be useful in certain new models such as super-symmetry:

```tikz
\feynmandiagram [horizontal=a to b] {
i1 [particle=\(\tilde W\)] -- [plain, boson] a -- [anti fermion] i2 [particle=\(q\)],
a -- [charged scalar, edge label=\(\tilde q\)] b,
f1 [particle=\(\tilde g\)] -- [plain, gluon] b -- [fermion] [particle=\(q\)],
};
```

### When the Algorithm Isn’t Enough --若算法不豫

By default, the `\feynmandiagram` and `\diagram` commands use the `spring layout algorithm` to place all the
edges.
The `spring layout algorithm` attempts to ‘spread out’ the diagram as much as possible which—for most simpler diagrams—give sasatisfactory result;
however in some cases,this does not produce the best diagram and this section will look at alternatives.

There are three main alternatives:

+ Add invisible edges : While still using the default algorithm, it is possible to force certain vertices to bo closer together by adding extra edges and making them invisible through `draw=none` . The algorithm will treat these extra edges in the same way, but they are simply not drawn at the end;
+ Use a different algorithm In some circumstances, other algorithms may be better suited. Some of the other graph layout algorithms are listed in section 3.2.2 and an exhaustivel is t ofall algorithms and their parameters is given in the TikZ manual;
Manual placement As a last resort very complicated or unusual diagrams will require each vertex to be manually placed.

#### Invisible Edges --隐形连线

The underlying algorithm treats all edges in exactly the same way when calculating where to place all the vertices, and the actual drawing of the diagram (after the placements have been calculated) is done separately.
Consequently, it is possible to add edges to the algorithm, but prevent them from being drawn byadding `draw=none` to the edgestyle.

This is particularly useful if you want to ensure that the initial or final states remain closer together than they would have otherwise as illustrated in the following example (note that `opacity=0.2` is used instead of `draw=none` to illustrate where exactly the edge is located).

```tikz
% No invisible edge to keep the two photons together
\feynmandiagram [small, horizontal=a to t1] {
a [particle=\(\pi^{0}\)] -- [scalar] t1 -- t2 -- t3 -- t1,
t2 -- [photon] p1 [particle=\(\gamma\)],
t3 -- [photon] p2 [particle=\(\gamma\)],
};
```

```tikz
% Invisible edge ensures photons are parallel
\feynmandiagram [small, horizontal=a to t1] {
a [particle=\(\pi^{0}\)] -- [scalar] t1 -- t2 -- t3 -- t1,
t2 -- [photon] p1 [particle=\(\gamma\)],
t3 -- [photon] p2 [particle=\(\gamma\)],
p1 -- [opacity=0.2] p2,
};
```

#### Alternative Algorithms --其他的算法

Thegraph drawing library from TikZ has several different algorithms to position the vertices. By default, `\diagram` and `\feynmandiagram` use the `spring layout` algorithm to place the vertices.
The `spring layout` attempts to spread everything out as much as possible which,in most cases, gives a nice diagram; however,there are certain cases where this does not work.
A good example where the spring layout doesn’t work are decays where we have the decaying particle on the left and all the daughter particles on the right.

```tikz
% Using the default spring layout
\feynmandiagram [horizontal=a to b] {
a [particle=\(\mu^{-}\)] -- [fermion] b -- [fermion] f1 [particle=\(\nu_{\mu}\)],
b -- [boson, edge label=\(W^{-}\)] c,
f2 [particle=\(\overline \nu_{e}\)] -- [fermion] c -- [fermion] f3 [particle=\(e^{-}\)],
};
```

```tikz
% Using the layered layout
\feynmandiagram [layered layout, horizontal=a to b] {
a [particle=\(\mu^{-}\)] -- [fermion] b -- [fermion] f1 [particle=\(\nu_{\mu}\)],
b -- [boson, edge label'=\(W^{-}\)] c,
c -- [anti fermion] f2 [particle=\(\overline \nu_{e}\)],
c -- [fermion] f3 [particle=\(e^{-}\)],
};
```

You may notice that in addition to adding the `layered layout` style to `\feynmandiagram`, we also changed the order in which we specify the vertices.
This is because the `layered layout` algorithm does pay attention to the order in which vertices are declared(unlike the default spring layout ); as a result, `c--f2`, `c--f3` has a different meaning to `f2--c--f3` .
In the former case, `f2` and `f3` are both on the layer below `c` as desired; whilst the latter case places `f2` on the layer above `c` (that, the same layer as where the $W^−$ originates).

**note:** 层状的；分层的

```tikz
% Using the layered layout f2--c--f3
\feynmandiagram [layered layout, horizontal=a to b] {
a [particle=\(\mu^{-}\)] -- [fermion] b -- [fermion] f1 [particle=\(\nu_{\mu}\)],
b -- [boson, edge label'=\(W^{-}\)] c,
f2 -- [anti fermion] c [particle=\(\overline \nu_{e}\)]--
[fermion] f3 [particle=\(e^{-}\)],
};
```

**note:** error with this

## Documentation

### Commands & Environments

`\tikzfeynmanset{ <options> }`

This command will process `<options>` using `\pgfkeys` with the default path set to `/tikzfeynman`.
Typically, `<options>` will be a comma-separated list of the form `<key>` = `<value>`,though the full power of the mechanism behind `\pgfkeys` can be used (see the TikZ manual for a complete description).
Typically, this is used in the preamble of the document to add or change certain keys for the whole document.

