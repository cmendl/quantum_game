(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.1' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[     57252,       1725]
NotebookOptionsPosition[     50902,       1556]
NotebookOutlinePosition[     51248,       1571]
CellTagsIndexPosition[     51205,       1568]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["General definitions and utility functions", "Subsection",ExpressionUUID->"73ede29f-843e-4acd-bd9d-ffae4f8f049b"],

Cell[BoxData[
 RowBox[{
  RowBox[{"BlochDensity", "[", "r_", "]"}], ":=", 
  RowBox[{
   FractionBox["1", "2"], 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"IdentityMatrix", "[", "2", "]"}], "+", 
     RowBox[{"Sum", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"r", "\[LeftDoubleBracket]", "i", "\[RightDoubleBracket]"}], 
        RowBox[{"PauliMatrix", "[", "i", "]"}]}], ",", 
       RowBox[{"{", 
        RowBox[{"i", ",", "3"}], "}"}]}], "]"}]}], ")"}]}]}]], "Input",Express\
ionUUID->"9dbdb527-c714-48a0-837e-314e997c2921"],

Cell[BoxData[
 RowBox[{
  RowBox[{"BlochVector", "[", "\[Rho]_", "]"}], ":=", 
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{"Tr", "[", 
     RowBox[{"\[Rho]", ".", 
      RowBox[{"PauliMatrix", "[", "i", "]"}]}], "]"}], ",", 
    RowBox[{"{", 
     RowBox[{"i", ",", "3"}], "}"}]}], "]"}]}]], "Input",ExpressionUUID->\
"b0b2bea4-7990-4091-8e18-42468e379de6"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", "check", " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{"BlochVector", "[", 
    RowBox[{"BlochDensity", "[", 
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["r", "1"], ",", 
       SubscriptBox["r", "2"], ",", 
       SubscriptBox["r", "3"]}], "}"}], "]"}], "]"}], "]"}]}]], "Input",Expres\
sionUUID->"6644fb38-924f-4732-946f-609bd81a68e6"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   SubscriptBox["r", "1"], ",", 
   SubscriptBox["r", "2"], ",", 
   SubscriptBox["r", "3"]}], "}"}]], "Output",ExpressionUUID->"c1b55a07-5955-\
45de-b8bd-4b15a8a3b1af"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"PartialTrace", "[", 
   RowBox[{"\[Rho]_", ",", 
    RowBox[{"{", 
     RowBox[{"dimA_", ",", "dimB_"}], "}"}]}], "]"}], ":=", 
  RowBox[{"Map", "[", 
   RowBox[{"Tr", ",", 
    RowBox[{"Transpose", "[", 
     RowBox[{
      RowBox[{"ArrayReshape", "[", 
       RowBox[{"\[Rho]", ",", 
        RowBox[{"{", 
         RowBox[{"dimA", ",", "dimB", ",", "dimA", ",", "dimB"}], "}"}]}], 
       "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"1", ",", "3", ",", "2", ",", "4"}], "}"}]}], "]"}], ",", 
    RowBox[{"{", "2", "}"}]}], "]"}]}]], "Input",ExpressionUUID->"e315840c-\
0329-414d-a179-1f2543b71a7f"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", "example", " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"PartialTrace", "[", 
    RowBox[{
     RowBox[{"KroneckerProduct", "[", 
      RowBox[{
       RowBox[{"PauliMatrix", "[", "2", "]"}], ",", 
       RowBox[{
        FractionBox["1", "3"], 
        RowBox[{"IdentityMatrix", "[", "3", "]"}]}]}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"2", ",", "3"}], "}"}]}], "]"}], "//", 
   "MatrixForm"}]}]], "Input",ExpressionUUID->"773cd45c-9b05-404a-bcdd-\
fa05cd98fda8"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0", 
      RowBox[{"-", "\[ImaginaryI]"}]},
     {"\[ImaginaryI]", "0"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"4799e96f-d495-4759-\
816c-6ac16ba85869"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", "example", " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"PartialTrace", "[", 
    RowBox[{
     RowBox[{"KroneckerProduct", "[", 
      RowBox[{
       RowBox[{
        FractionBox["1", "3"], 
        RowBox[{"IdentityMatrix", "[", "3", "]"}]}], ",", 
       RowBox[{"PauliMatrix", "[", "2", "]"}]}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"3", ",", "2"}], "}"}]}], "]"}], "//", 
   "MatrixForm"}]}]], "Input",ExpressionUUID->"2cca2817-2532-4a66-8090-\
d26d2b67590d"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0", "0", "0"},
     {"0", "0", "0"},
     {"0", "0", "0"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"6bf955f2-bed1-4492-\
a735-84d3736c80e4"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"ReorderQubitOperator", "[", 
   RowBox[{"A_", ",", "perm_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"n", "=", 
      RowBox[{"Length", "[", "perm", "]"}]}], "}"}], ",", 
    RowBox[{"ArrayReshape", "[", 
     RowBox[{
      RowBox[{"Transpose", "[", 
       RowBox[{
        RowBox[{"ArrayReshape", "[", 
         RowBox[{"A", ",", 
          RowBox[{"ConstantArray", "[", 
           RowBox[{"2", ",", 
            RowBox[{"2", "n"}]}], "]"}]}], "]"}], ",", 
        RowBox[{"Join", "[", 
         RowBox[{"perm", ",", 
          RowBox[{"n", "+", "perm"}]}], "]"}]}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{
        SuperscriptBox["2", "n"], ",", 
        SuperscriptBox["2", "n"]}], "}"}]}], "]"}]}], "]"}]}]], "Input",Expres\
sionUUID->"7191dd54-1146-4815-8afc-8664ad22fb35"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", "example", " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"SeedRandom", "[", "34", "]"}], "\[IndentingNewLine]", 
   RowBox[{"With", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"A", "=", 
        RowBox[{"RandomComplex", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{
             RowBox[{"-", "1"}], "-", "\[ImaginaryI]"}], ",", 
            RowBox[{"1", "+", "\[ImaginaryI]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"2", ",", "2"}], "}"}]}], "]"}]}], ",", 
       RowBox[{"B", "=", 
        RowBox[{"RandomComplex", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{
             RowBox[{"-", "1"}], "-", "\[ImaginaryI]"}], ",", 
            RowBox[{"1", "+", "\[ImaginaryI]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"2", ",", "2"}], "}"}]}], "]"}]}], ",", 
       RowBox[{"C", "=", 
        RowBox[{"RandomComplex", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{
             RowBox[{"-", "1"}], "-", "\[ImaginaryI]"}], ",", 
            RowBox[{"1", "+", "\[ImaginaryI]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"2", ",", "2"}], "}"}]}], "]"}]}]}], "}"}], ",", 
     RowBox[{"Norm", "[", 
      RowBox[{
       RowBox[{"ReorderQubitOperator", "[", 
        RowBox[{
         RowBox[{"KroneckerProduct", "[", 
          RowBox[{"A", ",", "B", ",", "C"}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"2", ",", "3", ",", "1"}], "}"}]}], "]"}], "-", 
       RowBox[{"KroneckerProduct", "[", 
        RowBox[{"C", ",", "A", ",", "B"}], "]"}]}], "]"}]}], 
    "]"}]}]}]], "Input",ExpressionUUID->"8a282d98-ca49-4311-b689-\
fbdd1fc49677"],

Cell[BoxData["2.6398462848284127`*^-16"], "Output",ExpressionUUID->"9958caac-86d6-43bc-9f60-9a0fc00056b2"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"\[Psi]", "[", 
   RowBox[{"\[Theta]_", ",", "\[Phi]_"}], "]"}], ":=", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"Cos", "[", 
     FractionBox["\[Theta]", "2"], "]"}], ",", 
    RowBox[{
     SuperscriptBox["\[ExponentialE]", 
      RowBox[{"\[ImaginaryI]", " ", "\[Phi]"}]], 
     RowBox[{"Sin", "[", 
      FractionBox["\[Theta]", "2"], "]"}]}]}], "}"}]}]], "Input",ExpressionUUI\
D->"60c6bf91-246f-4419-a6fb-efd6919c5902"],

Cell[BoxData[
 RowBox[{
  RowBox[{"\[Rho]", "[", 
   RowBox[{"\[Theta]_", ",", "\[Phi]_"}], "]"}], ":=", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      SuperscriptBox[
       RowBox[{"Cos", "[", 
        FractionBox["\[Theta]", "2"], "]"}], "2"], ",", 
      RowBox[{
       FractionBox["1", "2"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "\[Phi]"}]], " ", 
       RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       FractionBox["1", "2"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "\[Phi]"}]], " ", 
       RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
      SuperscriptBox[
       RowBox[{"Sin", "[", 
        FractionBox["\[Theta]", "2"], "]"}], "2"]}], "}"}]}], 
   "}"}]}]], "Input",ExpressionUUID->"275c6b5b-8a69-4e66-b437-cade9693580e"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Norm", "[", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"\[Rho]", "[", 
      RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}], "-", 
     RowBox[{"KroneckerProduct", "[", 
      RowBox[{
       RowBox[{"\[Psi]", "[", 
        RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}], ",", 
       RowBox[{"Conjugate", "[", 
        RowBox[{"\[Psi]", "[", 
         RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}], "]"}]}], "]"}]}], ",", 
    RowBox[{"Assumptions", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"\[Theta]", "\[Element]", "Reals"}], ",", 
       RowBox[{"\[Phi]", "\[Element]", "Reals"}]}], "}"}]}]}], "]"}], 
  "]"}]], "Input",ExpressionUUID->"eaa00a33-57cd-4287-87b3-22574755a4da"],

Cell[BoxData["0"], "Output",ExpressionUUID->"c3ac69c1-d575-43af-baa4-6d16215c48f3"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"ProjectDensityMatrix", "[", 
   RowBox[{"\[Rho]_", ",", "P_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"dimA", "=", 
       RowBox[{
        RowBox[{"Length", "[", "\[Rho]", "]"}], "/", 
        RowBox[{"Length", "[", "P", "]"}]}]}], ",", "\[Rho]P"}], "}"}], ",", 
    RowBox[{
     RowBox[{"\[Rho]P", "=", 
      RowBox[{"\[Rho]", ".", 
       RowBox[{"KroneckerProduct", "[", 
        RowBox[{
         RowBox[{"IdentityMatrix", "[", "dimA", "]"}], ",", "P"}], "]"}]}]}], 
     ";", 
     RowBox[{
      RowBox[{"PartialTrace", "[", 
       RowBox[{"\[Rho]P", ",", 
        RowBox[{"{", 
         RowBox[{"dimA", ",", 
          RowBox[{"Length", "[", "P", "]"}]}], "}"}]}], "]"}], "/", 
      RowBox[{"Tr", "[", "\[Rho]P", "]"}]}]}]}], "]"}]}]], "Input",ExpressionU\
UID->"5777eaef-33a8-4d02-80b5-c07118b613bc"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Quantum teleportation", "Subsection",ExpressionUUID->"b1f13f03-f80c-408f-a49d-e60ffd32d0af"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   SubscriptBox["\[Zeta]", "0"], "=", 
   RowBox[{
    FractionBox["1", 
     SqrtBox["2"]], 
    RowBox[{"{", 
     RowBox[{"1", ",", "0", ",", "0", ",", "1"}], "}"}]}]}], ";"}]], "Input",E\
xpressionUUID->"d5466d61-3cc6-40a8-b3b3-94cbdae804e7"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"corresponding", " ", "density", " ", "matrix"}], " ", "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{
     SubscriptBox["\[Zeta]d", "0"], "=", 
     RowBox[{"FullSimplify", "[", 
      RowBox[{"KroneckerProduct", "[", 
       RowBox[{
        SubscriptBox["\[Zeta]", "0"], ",", 
        RowBox[{"Conjugate", "[", 
         SubscriptBox["\[Zeta]", "0"], "]"}]}], "]"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"%", "//", "MatrixForm"}]}]}]], "Input",ExpressionUUID->"fddcf98c-\
e9eb-4cfa-a6a9-02744137ce2f"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {
      FractionBox["1", "2"], "0", "0", 
      FractionBox["1", "2"]},
     {"0", "0", "0", "0"},
     {"0", "0", "0", "0"},
     {
      FractionBox["1", "2"], "0", "0", 
      FractionBox["1", "2"]}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"ea07cc50-f31c-4da0-\
a828-eb4a25b12187"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  SubscriptBox["\[Zeta]dp", "0"], "=", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{"ProjectDensityMatrix", "[", 
    RowBox[{
     SubscriptBox["\[Zeta]d", "0"], ",", 
     RowBox[{"\[Rho]", "[", 
      RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}]}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"FullSimplify", "[", 
  RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}], "Input",ExpressionUUID->\
"bf580769-445d-49a7-879c-32bcfd744540"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     SuperscriptBox[
      RowBox[{"Cos", "[", 
       FractionBox["\[Theta]", "2"], "]"}], "2"], ",", 
     RowBox[{
      FractionBox["1", "2"], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{"\[ImaginaryI]", " ", "\[Phi]"}]], " ", 
      RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      FractionBox["1", "2"], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "\[ImaginaryI]"}], " ", "\[Phi]"}]], " ", 
      RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
     SuperscriptBox[
      RowBox[{"Sin", "[", 
       FractionBox["\[Theta]", "2"], "]"}], "2"]}], "}"}]}], "}"}]], "Output",\
ExpressionUUID->"6333d296-5163-4cc8-9a00-f2acf42f7672"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
    RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
   RowBox[{
    RowBox[{"-", 
     RowBox[{"Sin", "[", "\[Theta]", "]"}]}], " ", 
    RowBox[{"Sin", "[", "\[Phi]", "]"}]}], ",", 
   RowBox[{"Cos", "[", "\[Theta]", "]"}]}], "}"}]], "Output",ExpressionUUID->\
"c32402a2-27aa-4f63-a5d7-9917ebb1186c"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Norm", "[", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{
    SubscriptBox["\[Zeta]dp", "0"], "-", 
    RowBox[{"\[Rho]", "[", 
     RowBox[{"\[Theta]", ",", 
      RowBox[{"-", "\[Phi]"}]}], "]"}]}], "]"}], "]"}]], "Input",ExpressionUUI\
D->"afdcfe56-2f3d-4d3f-8469-596a8f01bbe6"],

Cell[BoxData["0"], "Output",ExpressionUUID->"c5766bda-e4ba-47f8-bbbc-4b455c306cf7"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{
   SubscriptBox["\[Zeta]", "1"], "=", 
   RowBox[{
    FractionBox["1", 
     SqrtBox["2"]], 
    RowBox[{"{", 
     RowBox[{"0", ",", "1", ",", 
      RowBox[{"-", "1"}], ",", "0"}], "}"}]}]}], ";"}]], "Input",ExpressionUUI\
D->"2098e22c-6a17-4f55-8df4-2890c5a2bf8c"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"corresponding", " ", "density", " ", "matrix"}], " ", "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{
     SubscriptBox["\[Zeta]d", "1"], "=", 
     RowBox[{"FullSimplify", "[", 
      RowBox[{"KroneckerProduct", "[", 
       RowBox[{
        SubscriptBox["\[Zeta]", "1"], ",", 
        RowBox[{"Conjugate", "[", 
         SubscriptBox["\[Zeta]", "1"], "]"}]}], "]"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"%", "//", "MatrixForm"}]}]}]], "Input",ExpressionUUID->"79e3a7ec-\
4a5b-4f74-a66c-dee7855d1aa8"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"0", "0", "0", "0"},
     {"0", 
      FractionBox["1", "2"], 
      RowBox[{"-", 
       FractionBox["1", "2"]}], "0"},
     {"0", 
      RowBox[{"-", 
       FractionBox["1", "2"]}], 
      FractionBox["1", "2"], "0"},
     {"0", "0", "0", "0"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"1749df7b-9737-4376-\
8ed2-99d6ca3a9dc8"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   SubscriptBox["\[Zeta]dp", "1"], "=", 
   RowBox[{"FullSimplify", "[", 
    RowBox[{"ProjectDensityMatrix", "[", 
     RowBox[{
      SubscriptBox["\[Zeta]d", "1"], ",", 
      RowBox[{"\[Rho]", "[", 
       RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}]}], "]"}], "]"}]}], 
  "\[IndentingNewLine]", 
  RowBox[{"(*", " ", 
   RowBox[{
   "negated", " ", "Bloch", " ", "vector", " ", "of", " ", "second", " ", 
    "qubit"}], " ", "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{"FullSimplify", "[", 
  RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}], "Input",ExpressionUUID->\
"e2187186-a7c2-4d39-b79d-1b6f2f637d82"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     SuperscriptBox[
      RowBox[{"Sin", "[", 
       FractionBox["\[Theta]", "2"], "]"}], "2"], ",", 
     RowBox[{
      RowBox[{"-", 
       FractionBox["1", "2"]}], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "\[ImaginaryI]"}], " ", "\[Phi]"}]], " ", 
      RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{"-", 
       FractionBox["1", "2"]}], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{"\[ImaginaryI]", " ", "\[Phi]"}]], " ", 
      RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
     SuperscriptBox[
      RowBox[{"Cos", "[", 
       FractionBox["\[Theta]", "2"], "]"}], "2"]}], "}"}]}], "}"}]], "Output",\
ExpressionUUID->"f3065922-3358-439f-8e62-d4ff6b2518aa"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    RowBox[{"-", 
     RowBox[{"Cos", "[", "\[Phi]", "]"}]}], " ", 
    RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
   RowBox[{
    RowBox[{"-", 
     RowBox[{"Sin", "[", "\[Theta]", "]"}]}], " ", 
    RowBox[{"Sin", "[", "\[Phi]", "]"}]}], ",", 
   RowBox[{"-", 
    RowBox[{"Cos", "[", "\[Theta]", "]"}]}]}], "}"}]], "Output",ExpressionUUID\
->"d8f8823e-f228-4453-80c1-057a777c043f"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   SubscriptBox["U", "CNOT"], "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"1", ",", "0", ",", "0", ",", "0"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", "1", ",", "0", ",", "0"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "0", ",", "1"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "1", ",", "0"}], "}"}]}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"%", "//", "MatrixForm"}]}], "Input",ExpressionUUID->"0476d26d-4d51-\
472b-9e9f-90c27d75216f"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"1", "0", "0", "0"},
     {"0", "1", "0", "0"},
     {"0", "0", "0", "1"},
     {"0", "0", "1", "0"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"a9a05a22-b9ce-4826-\
a5ed-3c2bea165df8"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  SubscriptBox["\[Chi]", "1"], "=", 
  RowBox[{
   RowBox[{"KroneckerProduct", "[", 
    RowBox[{
     RowBox[{"HadamardMatrix", "[", "2", "]"}], ",", 
     RowBox[{"IdentityMatrix", "[", "4", "]"}]}], "]"}], ".", 
   RowBox[{"KroneckerProduct", "[", 
    RowBox[{
     SubscriptBox["U", "CNOT"], ",", 
     RowBox[{"IdentityMatrix", "[", "2", "]"}]}], "]"}], ".", 
   RowBox[{"Flatten", "[", 
    RowBox[{"KroneckerProduct", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\[Alpha]", ",", "\[Beta]"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{
        FractionBox["1", 
         SqrtBox["2"]], ",", "0", ",", "0", ",", 
        FractionBox["1", 
         SqrtBox["2"]]}], "}"}]}], "]"}], "]"}]}]}]], "Input",ExpressionUUID->\
"5fc0cba9-d2f0-4f9f-8673-cd89f3281c45"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   FractionBox["\[Alpha]", "2"], ",", 
   FractionBox["\[Beta]", "2"], ",", 
   FractionBox["\[Beta]", "2"], ",", 
   FractionBox["\[Alpha]", "2"], ",", 
   FractionBox["\[Alpha]", "2"], ",", 
   RowBox[{"-", 
    FractionBox["\[Beta]", "2"]}], ",", 
   RowBox[{"-", 
    FractionBox["\[Beta]", "2"]}], ",", 
   FractionBox["\[Alpha]", "2"]}], "}"}]], "Output",ExpressionUUID->"fcb68ef3-\
c5f9-4fba-8951-f4b1f696b131"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{"corresponding", " ", "density", " ", "matrix"}], " ", "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{
     SubscriptBox["\[Chi]d", "1"], "=", 
     RowBox[{"FullSimplify", "[", 
      RowBox[{"KroneckerProduct", "[", 
       RowBox[{
        SubscriptBox["\[Chi]", "1"], ",", 
        RowBox[{"Conjugate", "[", 
         SubscriptBox["\[Chi]", "1"], "]"}]}], "]"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"%", "//", "MatrixForm"}]}]}]], "Input",ExpressionUUID->"006d9005-\
2c5a-4b00-815d-dd620ad32e70"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]},
     {
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], 
      RowBox[{
       FractionBox["1", "4"], " ", "\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}]}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"7d7e8b18-e38c-4fe5-\
966f-e18be1750246"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{
   "trace", " ", "out", " ", "second", " ", "and", " ", "third", " ", 
    "qubit"}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"FullSimplify", "[", 
    RowBox[{
     RowBox[{"PartialTrace", "[", 
      RowBox[{
       SubscriptBox["\[Chi]d", "1"], ",", 
       RowBox[{"{", 
        RowBox[{"2", ",", "4"}], "}"}]}], "]"}], ",", 
     RowBox[{"Assumptions", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "+", 
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Beta]", "]"}], "2"]}], "\[Equal]", "1"}], 
       "}"}]}]}], "]"}], "\[IndentingNewLine]", 
   RowBox[{"FullSimplify", "[", 
    RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}]}]], "Input",ExpressionUUID\
->"eecae128-4c7e-4b5b-acca-0f5ea437d138"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     FractionBox["1", "2"], ",", 
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{
        SuperscriptBox[
         RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "-", 
        RowBox[{"\[Beta]", " ", 
         RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}]}]}], "}"}], 
   ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{
        SuperscriptBox[
         RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "-", 
        RowBox[{"\[Beta]", " ", 
         RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}]}], ",", 
     FractionBox["1", "2"]}], "}"}]}], "}"}]], "Output",ExpressionUUID->\
"8651c27b-1086-487d-80c6-9ff104fb252f"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    SuperscriptBox[
     RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "-", 
    RowBox[{"\[Beta]", " ", 
     RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ",", "0", ",", "0"}], 
  "}"}]], "Output",ExpressionUUID->"25f39ef8-71fd-48f6-92c2-372a9aeda851"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{
   "trace", " ", "out", " ", "first", " ", "and", " ", "third", " ", 
    "qubit"}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"FullSimplify", "[", 
    RowBox[{
     RowBox[{"PartialTrace", "[", 
      RowBox[{
       RowBox[{"ReorderQubitOperator", "[", 
        RowBox[{
         SubscriptBox["\[Chi]d", "1"], ",", 
         RowBox[{"{", 
          RowBox[{"2", ",", "1", ",", "3"}], "}"}]}], "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"2", ",", "4"}], "}"}]}], "]"}], ",", 
     RowBox[{"Assumptions", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "+", 
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Beta]", "]"}], "2"]}], "\[Equal]", "1"}], 
       "}"}]}]}], "]"}], "\[IndentingNewLine]", 
   RowBox[{"FullSimplify", "[", 
    RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}]}]], "Input",ExpressionUUID\
->"4579ad0a-2678-47db-b31b-e0fdfaa11e87"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     FractionBox["1", "2"], ",", "0"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0", ",", 
     FractionBox["1", "2"]}], "}"}]}], "}"}]], "Output",ExpressionUUID->\
"f69fa4ed-76fa-43c6-b2b7-d4670d9ce3e5"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0", ",", "0", ",", "0"}], "}"}]], "Output",ExpressionUUID->\
"7012b169-94f3-4ffc-8770-3b9a3a21442f"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{
   "trace", " ", "out", " ", "first", " ", "and", " ", "second", " ", 
    "qubit"}], " ", "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"FullSimplify", "[", 
    RowBox[{
     RowBox[{"PartialTrace", "[", 
      RowBox[{
       RowBox[{"ReorderQubitOperator", "[", 
        RowBox[{
         SubscriptBox["\[Chi]d", "1"], ",", 
         RowBox[{"{", 
          RowBox[{"2", ",", "3", ",", "1"}], "}"}]}], "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"2", ",", "4"}], "}"}]}], "]"}], ",", 
     RowBox[{"Assumptions", "\[Rule]", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "+", 
         SuperscriptBox[
          RowBox[{"Abs", "[", "\[Beta]", "]"}], "2"]}], "\[Equal]", "1"}], 
       "}"}]}]}], "]"}], "\[IndentingNewLine]", 
   RowBox[{"FullSimplify", "[", 
    RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}]}]], "Input",ExpressionUUID\
->"9a8a6aa0-516f-4cd2-8a08-fead647002d6"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     FractionBox["1", "2"], ",", "0"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0", ",", 
     FractionBox["1", "2"]}], "}"}]}], "}"}]], "Output",ExpressionUUID->\
"0d10be6b-36fe-44a0-a19a-2207513a4b3c"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0", ",", "0", ",", "0"}], "}"}]], "Output",ExpressionUUID->\
"769a8123-4233-4891-8e4c-35e706e5ca0a"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  SubscriptBox["\[Chi]dp", "1"], "=", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{
    RowBox[{"ProjectDensityMatrix", "[", 
     RowBox[{
      SubscriptBox["\[Chi]d", "1"], ",", 
      RowBox[{"KroneckerProduct", "[", 
       RowBox[{
        RowBox[{"\[Rho]", "[", 
         RowBox[{"\[Theta]", ",", "\[Phi]"}], "]"}], ",", 
        RowBox[{"IdentityMatrix", "[", "2", "]"}]}], "]"}]}], "]"}], ",", 
    RowBox[{"Assumptions", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        SuperscriptBox[
         RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "+", 
        SuperscriptBox[
         RowBox[{"Abs", "[", "\[Beta]", "]"}], "2"]}], "\[Equal]", "1"}], 
      "}"}]}]}], "]"}]}], "\[IndentingNewLine]", 
 RowBox[{
  SubscriptBox["b", "1"], "=", 
  RowBox[{"FullSimplify", "[", 
   RowBox[{"BlochVector", "[", "%", "]"}], "]"}]}]}], "Input",ExpressionUUID->\
"3d42fe82-ee8a-4a37-8c76-f58adad81369"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"Conjugate", "[", "\[Beta]", "]"}], " ", 
         RowBox[{"(", 
          RowBox[{"\[Beta]", "+", 
           RowBox[{"\[Alpha]", " ", 
            RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
            RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}], "+", 
        RowBox[{
         RowBox[{"Conjugate", "[", "\[Alpha]", "]"}], " ", 
         RowBox[{"(", 
          RowBox[{"\[Alpha]", "+", 
           RowBox[{"\[Beta]", " ", 
            RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
            RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}]}], ")"}]}], 
     ",", 
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"-", 
          RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], " ", 
         RowBox[{"(", 
          RowBox[{"\[Beta]", "+", 
           RowBox[{"\[Alpha]", " ", 
            RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
            RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}], "+", 
        RowBox[{
         RowBox[{"Conjugate", "[", "\[Alpha]", "]"}], " ", 
         RowBox[{"(", 
          RowBox[{"\[Alpha]", "+", 
           RowBox[{"\[Beta]", " ", 
            RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
            RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}]}], ")"}]}]}], 
    "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{
        SuperscriptBox[
         RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "-", 
        RowBox[{"\[Beta]", " ", 
         RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}], "+", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "\[Beta]"}], " ", 
            RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], "+", 
           RowBox[{"\[Alpha]", " ", 
            RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}], " ", 
         RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
         RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}], ",", 
     RowBox[{
      FractionBox["1", "2"], " ", 
      RowBox[{"(", 
       RowBox[{"1", "-", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{
           RowBox[{"\[Beta]", " ", 
            RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], "+", 
           RowBox[{"\[Alpha]", " ", 
            RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}], " ", 
         RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
         RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}]}], "}"}]}], 
  "}"}]], "Output",ExpressionUUID->"19d26e4f-111e-41d9-9f37-41ceab9565b4"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{
    SuperscriptBox[
     RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "-", 
    RowBox[{"\[Beta]", " ", 
     RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ",", 
   RowBox[{"\[ImaginaryI]", " ", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"\[Beta]", " ", 
       RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], "-", 
      RowBox[{"\[Alpha]", " ", 
       RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}], " ", 
    RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
    RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", 
   RowBox[{
    FractionBox["1", "2"], " ", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"-", "1"}], "+", 
      SuperscriptBox[
       RowBox[{"Abs", "[", "\[Alpha]", "]"}], "2"], "+", 
      SuperscriptBox[
       RowBox[{"Abs", "[", "\[Beta]", "]"}], "2"], "+", 
      RowBox[{"2", " ", 
       RowBox[{"(", 
        RowBox[{
         RowBox[{"\[Beta]", " ", 
          RowBox[{"Conjugate", "[", "\[Alpha]", "]"}]}], "+", 
         RowBox[{"\[Alpha]", " ", 
          RowBox[{"Conjugate", "[", "\[Beta]", "]"}]}]}], ")"}], " ", 
       RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
       RowBox[{"Sin", "[", "\[Theta]", "]"}]}]}], ")"}]}]}], "}"}]], "Output",\
ExpressionUUID->"22439383-3dc3-407a-925c-d3fd84dea4d8"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  SubscriptBox["b", "1"], "/.", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"\[Alpha]", "\[Rule]", 
     FractionBox["1", "2"]}], ",", 
    RowBox[{"\[Beta]", "\[Rule]", 
     RowBox[{"\[ImaginaryI]", " ", 
      FractionBox[
       SqrtBox["3"], "2"]}]}]}], "}"}]}]], "Input",ExpressionUUID->"3756924d-\
fbda-47f4-a6c9-5abdbafbc7f7"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", 
    FractionBox["1", "2"]}], ",", 
   RowBox[{
    RowBox[{"-", 
     FractionBox["1", "2"]}], " ", 
    SqrtBox["3"], " ", 
    RowBox[{"Cos", "[", "\[Phi]", "]"}], " ", 
    RowBox[{"Sin", "[", "\[Theta]", "]"}]}], ",", "0"}], "}"}]], "Output",Expr\
essionUUID->"550f8535-2cf2-4472-b8db-fc3503f76542"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Block", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"\[Alpha]", "=", 
      FractionBox["1", "2"]}], ",", 
     RowBox[{"\[Beta]", "=", 
      RowBox[{"\[ImaginaryI]", " ", 
       FractionBox[
        SqrtBox["3"], "2"]}]}]}], "}"}], ",", 
   RowBox[{"Show", "[", 
    RowBox[{
     RowBox[{"Graphics3D", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"Orange", ",", 
         RowBox[{"Specularity", "[", 
          RowBox[{"White", ",", "5"}], "]"}], ",", 
         RowBox[{"Opacity", "[", "0.25", "]"}], ",", 
         RowBox[{"Sphere", "[", "]"}]}], "}"}], ",", 
       RowBox[{"Axes", "\[Rule]", "True"}], ",", 
       RowBox[{"AxesLabel", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{"x", ",", "y", ",", "z"}], "}"}]}]}], "]"}], ",", 
     RowBox[{"ListPointPlot3D", "[", 
      RowBox[{"Flatten", "[", 
       RowBox[{
        RowBox[{"Table", "[", 
         RowBox[{
          SubscriptBox["b", "1"], ",", 
          RowBox[{"{", 
           RowBox[{"\[Theta]", ",", "0", ",", "\[Pi]", ",", 
            FractionBox["\[Pi]", "10"]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"\[Phi]", ",", "0", ",", 
            RowBox[{"2", "\[Pi]"}], ",", 
            FractionBox[
             RowBox[{"2", "\[Pi]"}], "50"]}], "}"}]}], "]"}], ",", "1"}], 
       "]"}], "]"}]}], "]"}]}], "]"}]], "Input",ExpressionUUID->"afb0c591-\
7d60-4544-881d-c49da08f3145"],

Cell[BoxData[
 Graphics3DBox[{
   {RGBColor[1, 0.5, 0], Opacity[0.25], Specularity[
     GrayLevel[1], 5], SphereBox[{0, 0, 0}]}, 
   {RGBColor[0.3315753, 0.4561011, 0.6388182], Point3DBox[CompressedData["
1:eJztmm1olWUYx4/L1ofZySTThh904tS2RBsnzNzSiiU2EAZlL058mTAnMcYs
YdFqajNNpzu9GRg6tlK3UDNslnPHl7OQmlObcxaudpqlpcHJ9w+RBfcViH9/
cD46uM+H8+HHzf1c9//6X9e5zvM8I+aV5C9ICgQCE/77uiPw/6cnErjlx3PP
Pfe87/DlY0Zm1w4/FrmZH3m358ngP0eFr9h1+s+eD5SfzxwYLvvhiPCddb3h
tf3bhTfkPX+2/MvvhG9cUtO77Noh4e1Xd6xq7mwVHv1q2JnDLx4QPjdnyLGV
GXuF500rfu6LjF3C78yvHXros63Cp17vak8K1RB/HPYRbtcVbnEKt3MJNx2E
m27CTWfhlhfhlkfhlnfh5hPh5quE19P+FA/FT+clfUhP0p/yRfklP5B/yG/k
T/Iz+Z/qheqL6pHql+qd+gP1E+o/1K+mvpUVu2v6zX2uJxKZ9UZq+ljlm1Mq
ginVPwt/uXJEfeH0n4QnV7dtLFt9Snhm8rbCKS/9qOufXd9QH+kS/nfS9gOj
o8eFx75tHHx8sZ5r4dLtwbtbVOfOfpeTS9OiwotrH514/6LdwoMlocHFBZuI
iw9tH+F2XeEWp3A7l3DTQbjpJtx01vUuL8Itj8It78LNJ1qPzlcJr6f9KR6K
H88L+pCepD/li/JLfiD/kN/In+Rn8j/VC9UX1SPWL9Q79QfqJ9R/qF99+PXe
QdWLfhPevG7N9WdylF+oS6uY3PSr8JL3sjvfPHla+KbUtikbPukV/mp88cEF
I38RHm+eveHSTI1z3ucPzrnnfdWn8OKWtUeTTwofv6RuUs2QjoR/R+KZ4/r9
dXif8G+uNl9+rOpT4uJD2yfhOcHiFG7nEm466HWdbsJNZ+GWF+GWR+GWd+Hm
E+Hmq4TX0/4UD8VP5yV9SE/Sn/JF+SU/kH/Ib+RP8jP5n+qF6ovqkeqX6p36
A/UT6j/Ur1xf/UN4VenDowakKw89UZSVu+J34U+duy9cUnlW+AvZGbO3Dj0j
vKk1nlafr/GfX1cVe/sR1SE6KzzmVJvq+U5H+dymHNW/cVTLvdtKT0A/13m1
fnRl7uT9B4V373ug6OPyBuLiQ9sH5hP932RxCrdzCTcdhJtuwk1n4ZYX4ZZH
4ZZ34eYTmIuU03ran+Kh+Om8pA/pSfpTvii/5AfyD/mN/El+Jv9TvVB9UT1S
/VK9U3+gfkL9h/qV6+fnhG9ZM2nPygrlBeE5wfVdus/CQWWxp6MaT9H89N3x
aRo/9dWBLZdyN2dp334t9H3qhIaY8P4PhSZ27OzW36MZe1YXfKTzMP2/7t6R
cuX1Vp3P8+K1w17paiSuPnT7CKf7RRancDuXcNNBuOmW8FxkeRFueRRueRdu
PoH5RDmtp/0pHoqfzkv6kJ6kP+WL8kt+IP+Q38if5GfyP9UL1RfVI9Uv1Tv1
B+on1H+oX/l5zHE/jznu5zHH/TzmeF+Zx/z9Mbuuvz8WuCGPwv39Mcf9/THH
b7f7Y/55peP+eaXj/nml4/55peN95Xmlf3/Mcf/+mOP+/THH/ftjjveV98cC
t/x47rnnnt/+/F+IRBvc
     "]]}},
  Axes->True,
  AxesLabel->{
    FormBox["x", TraditionalForm], 
    FormBox["y", TraditionalForm], 
    FormBox["z", TraditionalForm]},
  ImageSize->{382.01927500447226`, 413.780443515417},
  ImageSizeRaw->Automatic,
  ViewPoint->{1.7512657124550406`, -1.9042088950588232`, 2.1810678321313612`},
  ViewVertical->{-0.010956556297505719`, 0.08116378970940921, 
   0.9966405536170533}]], "Output",ExpressionUUID->"bab58548-7dfd-48eb-8e9c-\
5045e50a86e2"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"KroneckerProduct", "[", 
   RowBox[{
    SubscriptBox["U", "CNOT"], ",", 
    RowBox[{"IdentityMatrix", "[", "2", "]"}]}], "]"}], ".", 
  RowBox[{"Flatten", "[", 
   RowBox[{"KroneckerProduct", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Alpha]", ",", "\[Beta]"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", 
       FractionBox["1", 
        SqrtBox["2"]], ",", 
       RowBox[{"-", 
        FractionBox["1", 
         SqrtBox["2"]]}], ",", "0"}], "}"}]}], "]"}], "]"}]}]], "Input",Expres\
sionUUID->"cf99e353-19d6-4ca2-bedb-a0ace7542899"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"0", ",", 
   FractionBox["\[Alpha]", 
    SqrtBox["2"]], ",", 
   RowBox[{"-", 
    FractionBox["\[Alpha]", 
     SqrtBox["2"]]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["\[Beta]", 
     SqrtBox["2"]]}], ",", "0", ",", "0", ",", 
   FractionBox["\[Beta]", 
    SqrtBox["2"]]}], "}"}]], "Output",ExpressionUUID->"31c1b557-ad9c-4d82-\
8143-7676b7248b31"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"KroneckerProduct", "[", 
   RowBox[{
    RowBox[{"HadamardMatrix", "[", "2", "]"}], ",", 
    RowBox[{"IdentityMatrix", "[", "4", "]"}]}], "]"}], ".", 
  RowBox[{"KroneckerProduct", "[", 
   RowBox[{
    SubscriptBox["U", "CNOT"], ",", 
    RowBox[{"IdentityMatrix", "[", "2", "]"}]}], "]"}], ".", 
  RowBox[{"Flatten", "[", 
   RowBox[{"KroneckerProduct", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Alpha]", ",", "\[Beta]"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"0", ",", 
       FractionBox["1", 
        SqrtBox["2"]], ",", 
       RowBox[{"-", 
        FractionBox["1", 
         SqrtBox["2"]]}], ",", "0"}], "}"}]}], "]"}], "]"}]}]], "Input",Expres\
sionUUID->"33c15101-2f69-43e9-8d4e-d46ff9b8bf55"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", 
    FractionBox["\[Beta]", "2"]}], ",", 
   FractionBox["\[Alpha]", "2"], ",", 
   RowBox[{"-", 
    FractionBox["\[Alpha]", "2"]}], ",", 
   FractionBox["\[Beta]", "2"], ",", 
   FractionBox["\[Beta]", "2"], ",", 
   FractionBox["\[Alpha]", "2"], ",", 
   RowBox[{"-", 
    FractionBox["\[Alpha]", "2"]}], ",", 
   RowBox[{"-", 
    FractionBox["\[Beta]", "2"]}]}], "}"}]], "Output",ExpressionUUID->\
"3341e183-3629-47fb-9432-84e8f2855518"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"KroneckerProduct", "[", 
    RowBox[{
     RowBox[{"HadamardMatrix", "[", "2", "]"}], ",", 
     RowBox[{"IdentityMatrix", "[", "2", "]"}]}], "]"}], ".", 
   SubscriptBox["U", "CNOT"]}], "//", "MatrixForm"}]], "Input",ExpressionUUID-\
>"9c11552b-8345-4be3-ac3b-83074b49c720"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {
      FractionBox["1", 
       SqrtBox["2"]], "0", "0", 
      FractionBox["1", 
       SqrtBox["2"]]},
     {"0", 
      FractionBox["1", 
       SqrtBox["2"]], 
      FractionBox["1", 
       SqrtBox["2"]], "0"},
     {
      FractionBox["1", 
       SqrtBox["2"]], "0", "0", 
      RowBox[{"-", 
       FractionBox["1", 
        SqrtBox["2"]]}]},
     {"0", 
      FractionBox["1", 
       SqrtBox["2"]], 
      RowBox[{"-", 
       FractionBox["1", 
        SqrtBox["2"]]}], "0"}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",ExpressionUUID->"933666ed-e94c-4951-\
a2cf-773b5372543d"]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1250, 823},
WindowMargins->{{Automatic, 197}, {112, Automatic}},
FrontEndVersion->"11.1 for Microsoft Windows (64-bit) (April 18, 2017)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1486, 35, 118, 0, 43, "Subsection", "ExpressionUUID" -> \
"73ede29f-843e-4acd-bd9d-ffae4f8f049b"],
Cell[1607, 37, 537, 15, 53, "Input", "ExpressionUUID" -> \
"9dbdb527-c714-48a0-837e-314e997c2921"],
Cell[2147, 54, 362, 10, 30, "Input", "ExpressionUUID" -> \
"b0b2bea4-7990-4091-8e18-42468e379de6"],
Cell[CellGroupData[{
Cell[2534, 68, 426, 11, 50, "Input", "ExpressionUUID" -> \
"6644fb38-924f-4732-946f-609bd81a68e6"],
Cell[2963, 81, 209, 6, 30, "Output", "ExpressionUUID" -> \
"c1b55a07-5955-45de-b8bd-4b15a8a3b1af"]
}, Open  ]],
Cell[3187, 90, 639, 18, 30, "Input", "ExpressionUUID" -> \
"e315840c-0329-414d-a179-1f2543b71a7f"],
Cell[CellGroupData[{
Cell[3851, 112, 533, 15, 74, "Input", "ExpressionUUID" -> \
"773cd45c-9b05-404a-bcdd-fa05cd98fda8"],
Cell[4387, 129, 688, 19, 60, "Output", "ExpressionUUID" -> \
"4799e96f-d495-4759-816c-6ac16ba85869"]
}, Open  ]],
Cell[CellGroupData[{
Cell[5112, 153, 533, 15, 74, "Input", "ExpressionUUID" -> \
"2cca2817-2532-4a66-8090-d26d2b67590d"],
Cell[5648, 170, 674, 19, 77, "Output", "ExpressionUUID" -> \
"6bf955f2-bed1-4492-a735-84d3736c80e4"]
}, Open  ]],
Cell[6337, 192, 868, 25, 30, "Input", "ExpressionUUID" -> \
"7191dd54-1146-4815-8afc-8664ad22fb35"],
Cell[CellGroupData[{
Cell[7230, 221, 1808, 50, 88, "Input", "ExpressionUUID" -> \
"8a282d98-ca49-4311-b689-fbdd1fc49677"],
Cell[9041, 273, 106, 0, 30, "Output", "ExpressionUUID" -> \
"9958caac-86d6-43bc-9f60-9a0fc00056b2"]
}, Open  ]],
Cell[9162, 276, 458, 13, 52, "Input", "ExpressionUUID" -> \
"60c6bf91-246f-4419-a6fb-efd6919c5902"],
Cell[9623, 291, 936, 27, 55, "Input", "ExpressionUUID" -> \
"275c6b5b-8a69-4e66-b437-cade9693580e"],
Cell[CellGroupData[{
Cell[10584, 322, 740, 19, 30, "Input", "ExpressionUUID" -> \
"eaa00a33-57cd-4287-87b3-22574755a4da"],
Cell[11327, 343, 83, 0, 30, "Output", "ExpressionUUID" -> \
"c3ac69c1-d575-43af-baa4-6d16215c48f3"]
}, Open  ]],
Cell[11425, 346, 908, 26, 50, "Input", "ExpressionUUID" -> \
"5777eaef-33a8-4d02-80b5-c07118b613bc"]
}, Open  ]],
Cell[CellGroupData[{
Cell[12370, 377, 98, 0, 43, "Subsection", "ExpressionUUID" -> \
"b1f13f03-f80c-408f-a49d-e60ffd32d0af"],
Cell[12471, 379, 281, 9, 62, "Input", "ExpressionUUID" -> \
"d5466d61-3cc6-40a8-b3b3-94cbdae804e7"],
Cell[CellGroupData[{
Cell[12777, 392, 602, 17, 69, "Input", "ExpressionUUID" -> \
"fddcf98c-e9eb-4cfa-a6a9-02744137ce2f"],
Cell[13382, 411, 816, 24, 118, "Output", "ExpressionUUID" -> \
"ea07cc50-f31c-4da0-a828-eb4a25b12187"]
}, Open  ]],
Cell[CellGroupData[{
Cell[14235, 440, 465, 12, 51, "Input", "ExpressionUUID" -> \
"bf580769-445d-49a7-879c-32bcfd744540"],
Cell[14703, 454, 818, 24, 55, "Output", "ExpressionUUID" -> \
"6333d296-5163-4cc8-9a00-f2acf42f7672"],
Cell[15524, 480, 399, 11, 30, "Output", "ExpressionUUID" -> \
"c32402a2-27aa-4f63-a5d7-9917ebb1186c"]
}, Open  ]],
Cell[CellGroupData[{
Cell[15960, 496, 304, 8, 32, "Input", "ExpressionUUID" -> \
"afdcfe56-2f3d-4d3f-8469-596a8f01bbe6"],
Cell[16267, 506, 83, 0, 30, "Output", "ExpressionUUID" -> \
"c5766bda-e4ba-47f8-bbbc-4b455c306cf7"]
}, Open  ]],
Cell[16365, 509, 303, 10, 62, "Input", "ExpressionUUID" -> \
"2098e22c-6a17-4f55-8df4-2890c5a2bf8c"],
Cell[CellGroupData[{
Cell[16693, 523, 602, 17, 69, "Input", "ExpressionUUID" -> \
"79e3a7ec-4a5b-4f74-a66c-dee7855d1aa8"],
Cell[17298, 542, 862, 26, 118, "Output", "ExpressionUUID" -> \
"1749df7b-9737-4376-8ed2-99d6ca3a9dc8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[18197, 573, 645, 17, 70, "Input", "ExpressionUUID" -> \
"e2187186-a7c2-4d39-b79d-1b6f2f637d82"],
Cell[18845, 592, 864, 26, 55, "Output", "ExpressionUUID" -> \
"f3065922-3358-439f-8e62-d4ff6b2518aa"],
Cell[19712, 620, 440, 13, 30, "Output", "ExpressionUUID" -> \
"d8f8823e-f228-4453-80c1-057a777c043f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[20189, 638, 576, 16, 50, "Input", "ExpressionUUID" -> \
"0476d26d-4d51-472b-9e9f-90c27d75216f"],
Cell[20768, 656, 716, 20, 94, "Output", "ExpressionUUID" -> \
"a9a05a22-b9ce-4826-a5ed-3c2bea165df8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[21521, 681, 805, 23, 62, "Input", "ExpressionUUID" -> \
"5fc0cba9-d2f0-4f9f-8673-cd89f3281c45"],
Cell[22329, 706, 458, 13, 53, "Output", "ExpressionUUID" -> \
"fcb68ef3-c5f9-4fba-8951-f4b1f696b131"]
}, Open  ]],
Cell[CellGroupData[{
Cell[22824, 724, 599, 17, 69, "Input", "ExpressionUUID" -> \
"006d9005-2c5a-4b00-815d-dd620ad32e70"],
Cell[23426, 743, 9048, 240, 258, "Output", "ExpressionUUID" -> \
"7d7e8b18-e38c-4fe5-966f-e18be1750246"]
}, Open  ]],
Cell[CellGroupData[{
Cell[32511, 988, 890, 25, 74, "Input", "ExpressionUUID" -> \
"eecae128-4c7e-4b5b-acca-0f5ea437d138"],
Cell[33404, 1015, 808, 26, 53, "Output", "ExpressionUUID" -> \
"8651c27b-1086-487d-80c6-9ff104fb252f"],
Cell[34215, 1043, 307, 8, 34, "Output", "ExpressionUUID" -> \
"25f39ef8-71fd-48f6-92c2-372a9aeda851"]
}, Open  ]],
Cell[CellGroupData[{
Cell[34559, 1056, 1043, 29, 74, "Input", "ExpressionUUID" -> \
"4579ad0a-2678-47db-b31b-e0fdfaa11e87"],
Cell[35605, 1087, 276, 9, 53, "Output", "ExpressionUUID" -> \
"f69fa4ed-76fa-43c6-b2b7-d4670d9ce3e5"],
Cell[35884, 1098, 140, 3, 30, "Output", "ExpressionUUID" -> \
"7012b169-94f3-4ffc-8770-3b9a3a21442f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[36061, 1106, 1044, 29, 74, "Input", "ExpressionUUID" -> \
"9a8a6aa0-516f-4cd2-8a08-fead647002d6"],
Cell[37108, 1137, 276, 9, 53, "Output", "ExpressionUUID" -> \
"0d10be6b-36fe-44a0-a19a-2207513a4b3c"],
Cell[37387, 1148, 140, 3, 30, "Output", "ExpressionUUID" -> \
"769a8123-4233-4891-8e4c-35e706e5ca0a"]
}, Open  ]],
Cell[CellGroupData[{
Cell[37564, 1156, 943, 26, 54, "Input", "ExpressionUUID" -> \
"3d42fe82-ee8a-4a37-8c76-f58adad81369"],
Cell[38510, 1184, 2768, 77, 98, "Output", "ExpressionUUID" -> \
"19d26e4f-111e-41d9-9f37-41ceab9565b4"],
Cell[41281, 1263, 1290, 35, 53, "Output", "ExpressionUUID" -> \
"22439383-3dc3-407a-925c-d3fd84dea4d8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[42608, 1303, 355, 11, 61, "Input", "ExpressionUUID" -> \
"3756924d-fbda-47f4-a6c9-5abdbafbc7f7"],
Cell[42966, 1316, 360, 11, 53, "Output", "ExpressionUUID" -> \
"550f8535-2cf2-4472-b8db-fc3503f76542"]
}, Open  ]],
Cell[CellGroupData[{
Cell[43363, 1332, 1428, 40, 107, "Input", "ExpressionUUID" -> \
"afb0c591-7d60-4544-881d-c49da08f3145"],
Cell[44794, 1374, 2279, 43, 429, "Output", "ExpressionUUID" -> \
"bab58548-7dfd-48eb-8e9c-5045e50a86e2"]
}, Open  ]],
Cell[CellGroupData[{
Cell[47110, 1422, 598, 18, 62, "Input", "ExpressionUUID" -> \
"cf99e353-19d6-4ca2-bedb-a0ace7542899"],
Cell[47711, 1442, 402, 13, 61, "Output", "ExpressionUUID" -> \
"31c1b557-ad9c-4d82-8143-7676b7248b31"]
}, Open  ]],
Cell[CellGroupData[{
Cell[48150, 1460, 761, 22, 62, "Input", "ExpressionUUID" -> \
"33c15101-2f69-43e9-8d4e-d46ff9b8bf55"],
Cell[48914, 1484, 498, 15, 53, "Output", "ExpressionUUID" -> \
"3341e183-3629-47fb-9432-84e8f2855518"]
}, Open  ]],
Cell[CellGroupData[{
Cell[49449, 1504, 322, 8, 30, "Input", "ExpressionUUID" -> \
"9c11552b-8345-4be3-ac3b-83074b49c720"],
Cell[49774, 1514, 1100, 38, 140, "Output", "ExpressionUUID" -> \
"933666ed-e94c-4951-a2cf-773b5372543d"]
}, Open  ]]
}, Open  ]]
}
]
*)

(* NotebookSignature JvT7ajYBeJnfKBggwaeGBEYe *)
