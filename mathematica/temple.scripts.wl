(* ::Package:: *)

(* ::Title:: *)
(*e.Numeric.series-full.rencon3.strange.wl*)


(* ::Chapter:: *)
(*initial 1*)


Once[
git`remote`name="octet.formfactor";
(*\:7ed9\:51fa\:8fdc\:7a0bgit\:4ed3\:5e93\:7684\:540d\:5b57*)
If[
(* if $ScriptCommandLine==={}, the environment is frontend*)
SameQ[$ScriptCommandLine,{}],
(*if execute in the frontend mode, refresh the title name*)
CompoundExpression[
(*\:6587\:4ef6\:7edd\:5bf9\:8def\:5f84*)
filename=NotebookFileName[],
(*\:5355\:5143\:5bf9\:8c61,\:7b2c\:4e00\:4e2a\:5355\:5143*)
cell`title=(Cells[][[1]]),
(*\:5237\:65b0\:7b2c\:4e00\:4e2a\:5355\:5143\:7684\:540d\:5b57*)
NotebookWrite[cell`title,Cell[FileNameSplit[filename][[-1]],"Title"]],
(*if execute in commandline mode, print a ready message*)
git`local`name=FileNameJoin[Append[TakeWhile[FileNameSplit[NotebookDirectory[]],
UnsameQ[#1,git`remote`name]&],git`remote`name]]
(*add the base git local dir*)
],
CompoundExpression[
Print["Ready to execute this script"]
]
]
]


(* ::Text:: *)
(*********************************** notebook \:5907\:5fd8\:5f55*)


(* ::Text:: *)
(*series full calc scripts*)


(* ::Chapter:: *)
(*initial parameters*)


(* ::Text:: *)
(*++++++++++++++++++++++++++++++++++++++++++++*)


(* ::Text:: *)
(*\:6a21\:62df\:547d\:4ee4\:884c\:8f93\:5165,\:8c03\:8bd5\:4f7f\:7528*)


(* ::Text:: *)
(*parameter`marker, "Bars","Fences","Points", "Ellipses","Bands"*)


input`simulation={"C:\\octet.formfactor\\Numeric.series-o1.rencon3\\
f.figure.series-full.rencon3.strange.baryons-all.band.wl",
"full",0.90,1.50,1,"Bands",0.1};


(* ::Text:: *)
(*++++++++++++++++++++++++++++++++++++++++*)


(* ::Text:: *)
(*\:5f15\:5165\:547d\:4ee4\:884c\:53c2\:6570, 1 \:7528\:4f5c\:5b9e\:9645\:811a\:672c\:8fd0\:884c, 2\:7528\:4f5c\:8c03\:8bd5*)


If[
SameQ[$ScriptCommandLine,{}],
(*if execute in the frontend mode, refresh the title name*)
input`cml=input`simulation,
(*if execute in commandline mode, use $ScriptCommandLine as parameters*)
input`cml=$ScriptCommandLine
];


(* ::Text:: *)
(*+++++++++++++++++++++++++++++++++*)


Print["----------------------------","\n","the parameter order, lambda, ci is","\n","----------------------------"];


{
file`name,
parameter`order,
parameter`lambda0,
parameter`ci,
curve`opacity,
parameter`marker,
mark`opacity
}={
input`cml[[1]],input`cml[[2]],
ToExpression[input`cml[[3]]],
ToExpression[input`cml[[4]]],
ToExpression[input`cml[[5]]],
ToString[input`cml[[6]]],
ToExpression[input`cml[[7]]]
}


Print["----------------------------"];


git`root`dir=StringCases[ExpandFileName[file`name],StartOfString~~((WordCharacter|":"|"\\")..)~~"octet.formfactor"][[1]]


parameter`order`string=ToString[parameter`order]
parameter`lambda0`string=ToString[NumberForm[parameter`lambda0,{3,2}]]
parameter`ci`string=ToString[NumberForm[parameter`ci,{3,2}]]


(* ::Chapter:: *)
(*import data*)


dir`data=FileNameJoin[{git`root`dir,"/experiment/"}]


Module[{tename1,tename2},

file`list=FileNames[StartOfString~~__~~".m",dir`data]


];
(*++++++++++++++++++++display+++++++++++++++++++++*)
Print["----------------------------","\n",".m files list","\n","----------------------------"];
StringRiffle[file`list]


(data`raw=Map[Get,file`list,{-1}]);


data`raw//Dimensions


(* ::DisplayFormula:: *)
(*data`raw,{1,4},{gegm,conf,io,trlp}*)


(* ::Chapter:: *)
(*table*)


(*++++++++++++++++++++display+++++++++++++++++++++*)
Print["----------------------------","\n","calculated renormalization constants","\n","----------------------------"];
StringRiffle[rencon]


(* ::Chapter:: *)
(*storage*)


Print["----------------------------","\n","output directory","\n","----------------------------"];


output`dir=FileNameJoin[{git`root`dir,"/expression-mfiles/"}]


Print["----------------------------","\n","output file name","\n","----------------------------"];


output`name`list={
(*++++++++++++++++*)
FileNameJoin[{output`dir,
"fig.calc.baryons.ge.tot."<>
"L-"<>parameter`lambda0`string<>
".ci-"<>parameter`ci`string<>
".m"
}],
FileNameJoin[{output`dir,
"fig.calc.baryons.gm.tot."<>
"L-"<>parameter`lambda0`string<>
".ci-"<>parameter`ci`string<>
".m"
}]
(*++++++++++++++++*)
}


output`file`list={
(*+++++++++++++++++++++*)
fig`calc`baryons`ge`total,
fig`calc`baryons`gm`total
(*+++++++++++++++++++++*)
};


(* ::Text:: *)
(*********************************************************************************)


Print["----------------------------","\n","output status","\n","----------------------------"];


Table[
Export[output`name`list[[i]],output`file`list[[i]]]
,{i,1,Length[output`file`list],1}]
