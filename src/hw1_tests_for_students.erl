-module(hw1_tests_for_students).
-export ([run_test/0]).


%---valid shapes

validRectangle1() -> {rectangle,{dim,1,2}}.		% size 2
validRectangle3() -> {rectangle,{dim,5,5}}.		% size 25
validRectangle4() -> {rectangle,{dim,1,1}}.		% size 1

invalidTriangle() -> {triangle, {radius, 1,1}}.
validTriangle2() -> {triangle,{dim,3,2}}.		% size 3
validTriangle3() -> {triangle,{dim,4,4}}.		% size 8

validEllipse1() -> {ellipse,{radius,1,2}}.
validEllipse2() -> {ellipse,{radius,3,2}}.

validCircle1() -> {ellipse,{radius,1,1}}.

%---valid structs
validShapes1() -> {shapes,[validEllipse1(), validEllipse1(), validRectangle1(), validTriangle2(), validRectangle3() ]}.
validShapes4() -> {shapes,[validEllipse2(),validRectangle1(), validTriangle2() , validTriangle3(), validRectangle3(), validRectangle4()]}.
invalidShapes() -> {shapes,[{triangle},{ellipse}]}.
validShapes2() -> {shapes,[validCircle1(), validEllipse1(), validRectangle1(), validTriangle2(), validRectangle3() ]}.
invalidShapes2() -> {shapes,[invalidTriangle(),validRectangle1()]}.
invalidShapes3() -> {shps,[validCircle1(), validEllipse1(), validRectangle1(), validTriangle2(), validRectangle3() ]}.



run_test() ->
	io:format("expecting ~p and got ~p ~n",[26,shapes:squaresArea(validShapes4())]),
	io:format("expecting ~p and got ~p ~n",[57.84955592153876,shapes:shapesArea(validShapes4())]),
	io:format("expecting ~p and got ~p ~n",[11.0,shapes:trianglesArea(validShapes4())]),
	%shapes:trianglesArea(invalidShapes()),
	RectFun1 = shapes:shapesFilter(rectangle),
	CircFun1 = shapes:shapesFilter2(circle),
	TriFun1 = shapes:shapesFilter(triangle),
	io:format("expecting ~p and got ~p ~n",[{shapes,[{rectangle,{dim,1,2}},{rectangle,{dim,5,5}}]},RectFun1(validShapes1())]),
	io:format("expecting ~p and got ~p ~n",[{shapes,[{ellipse,{radius,1,1}}]},CircFun1(validShapes2())]),
	io:format("expecting ~p and got ~p ~n",[{shapes,[{triangle,{dim,3,2},{triangle,{dim,4,4}}}]},TriFun1(validShapes4())]),
	%CircFun1(invalidShapes2()),
	%shapes:shapesArea(invalidShapes3()),
	%CircFun1(invalidShapes3()),
	%shapes:shapesFilter(blabla),
	io:format("expecting ~p and got ~p ~n",[true, game:canWin(2)]),
	io:format("expecting ~p and got ~p ~n",[false, game:canWin(3)]),
	io:format("expecting ~p and got ~p ~n",[true, game:canWin(4)]),
	io:format("expecting ~p and got ~p ~n",[true,game:canWin(2)]),
	io:format("expecting ~p and got ~p ~n",[false,game:canWin(3)]),
	%game:canWin(-5),
	io:format("expecting ~p and got ~p ~n",[false,game:canWin(6)]),
	io:format("expecting ~p and got ~p ~n",[false,game:nextMove(3)]),
	%game:nextMove(-5),
	io:format("expecting ~p and got ~p ~n",[{true,1},game:nextMove(4)]),
	%game:nextMove(0),
	io:format("expecting ~p and got ~p ~n",[true,game:canWin(0)]), %% needs to be false?
	io:format("explanation is ~p ~n",[game:explanation()]),
	io:format("canWin: ~n"),
	io:format("~p expecting ~p and got ~p ~n", [0, false, game:canWin(0)]),
	io:format("~p expecting ~p and got ~p ~n", [1, true, game:canWin(1)]),
	io:format("~p expecting ~p and got ~p ~n", [2, true, game:canWin(2)]),
	io:format("~p expecting ~p and got ~p ~n", [3, false, game:canWin(3)]),
	io:format("~p expecting ~p and got ~p ~n", [4, true, game:canWin(4)]),
	io:format("~p expecting ~p and got ~p ~n", [5, true, game:canWin(5)]),
	io:format("~p expecting ~p and got ~p ~n", [6, false, game:canWin(6)]),
	io:format("~p expecting ~p and got ~p ~n", [7, true, game:canWin(7)]),
	io:format("~p expecting ~p and got ~p ~n", [8, true, game:canWin(8)]),
	io:format("~p expecting ~p and got ~p ~n", [9, false, game:canWin(9)]),
	%%  io:format("~p expecting ~p and got ~p ~n", [3000000, false, canWin(3000000)]),
	io:format("~nnextMove: ~n"),
	io:format("~p expecting ~p and got ~p ~n", [0, false, game:nextMove(0)]),
	io:format("~p expecting ~p and got ~p ~n", [1, {true, 1}, game:nextMove(1)]),
	io:format("~p expecting ~p and got ~p ~n", [2, {true, 2}, game:nextMove(2)]),
	io:format("~p expecting ~p and got ~p ~n", [3, false, game:nextMove(3)]),
	io:format("~p expecting ~p and got ~p ~n", [4, {true, 1}, game:nextMove(4)]),
	io:format("~p expecting ~p and got ~p ~n", [5, {true, 2}, game:nextMove(5)]),
	io:format("~p expecting ~p and got ~p ~n", [6, false, game:nextMove(6)]),
	io:format("~p expecting ~p and got ~p ~n", [7, {true, 1}, game:nextMove(7)]),
	io:format("~p expecting ~p and got ~p ~n", [8, {true, 2}, game:nextMove(8)]).




	