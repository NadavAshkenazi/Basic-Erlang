-module(shapesTest).
-export([testAll/0, test/1]).

rec1() -> {rectangle, {dim, 1, 2}}.
	
rec2() -> {rectangle, {dim, 2, 2}}.
	
rec3() -> {rectangle, {dim, 5, 2}}.
	
rec4() -> {rectangle, {dim, 1, 7}}.
	
rec5() -> {rectangle, {dim, 3.5, 6}}.
	
tri1() -> {triangle, {dim, 1, 2}}.
	
tri2() -> {triangle, {dim, 2, 2}}.
	
tri3() -> {triangle, {dim, 5, 2}}.
	
tri4() -> {triangle, {dim, 1, 7}}.
	
tri5() -> {triangle, {dim, 3.5, 6}}.
	
ell1() -> {ellipse, {radius, 1, 2}}.
	
ell2() -> {ellipse, {radius, 2, 2}}.
	
ell3() -> {ellipse, {radius, 5, 2}}.
	
ell4() -> {ellipse, {radius, 1, 7}}.
	
ell5() -> {ellipse, {radius, 3.5, 6}}.
	
test1() -> 
	io:format("test1 : testing shapesArea~n"),
	Vec1 = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5()]},
	Area1 = shapes:shapesArea(Vec1),
	Area1 = 44.0,

	Vec2 = {shapes, [tri1(), tri2(), tri3(), tri4(), tri5()]},
	Area2 = shapes:shapesArea(Vec2),
	Area2 = 22.0,

	Vec3 = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5(), tri1(), tri2(), tri3(), tri4(), tri5()]},
	Area3 = shapes:shapesArea(Vec3),
	Area3 = 66.0,

	Vec4 = {shapes, [ell1(), ell2(), ell3(), ell4(), ell5()]},
	Area4 = shapes:shapesArea(Vec4),
	Area4 - 44*math:pi() < 0.000000000001,

	Vec5 = {shapes, [rec1(), tri2(), ell3(), rec4(), ell5()]},
	Area5 = shapes:shapesArea(Vec5),
	Area5 = 2 + 2 + 10*math:pi() + 7 + 21*math:pi(),
	io:format("PASS~n~n").
	
test2() ->
	io:format("test2 : testing squaresArea~n"),
	Vec1 = {shapes, [tri1(), tri2(), tri3(), tri4(), tri5()]},
	Area1 = 0,
	Area1 = shapes:squaresArea(Vec1),
	
	Vec2 = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5(), tri1(), tri2(), tri3(), tri4(), tri5()]},
	Area2 = 4,
	Area2 = shapes:squaresArea(Vec2),
	io:format("PASS~n~n").

test3() ->
	io:format("test3 : testing trianglesArea~n"),
	Vec1 = {shapes, [tri1(), tri2(), tri3(), tri4(), tri5()]},
	Area1 = 22.0,
	Area1 = shapes:trianglesArea(Vec1),
	Vec2 = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5()]},
	Area2 = 0,
	Area2 = shapes:trianglesArea(Vec2),
	io:format("PASS~n~n").

test4() ->
	io:format("test4 : testing shapesFilter~n"),
	Vec = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5(), tri1(), tri2(), tri3(), tri4(), tri5(), ell1(), ell2(), ell3(), ell4(), ell5()]},
	
	RecFun = shapes:shapesFilter(rectangle),
	RecVec = RecFun(Vec),
	Area1 = 44.0,
	Area1 = shapes:shapesArea(RecVec),

	TriFun = shapes:shapesFilter(triangle),
	TriVec = TriFun(Vec),
	Area2 = 22.0,
	Area2 = shapes:shapesArea(TriVec),	

	EllFun = shapes:shapesFilter(ellipse),
	EllVec = EllFun(Vec),
	Area3 = shapes:shapesArea(EllVec),
	Area3 - 44*math:pi() < 0.000000000001,
	io:format("PASS~n~n").
	
test5() ->
	io:format("test5 : testing shapesFilter2~n"),
	Vec = {shapes, [rec1(), rec2(), rec3(), rec4(), rec5(), tri1(), tri2(), tri3(), tri4(), tri5(), ell1(), ell2(), ell3(), ell4(), ell5()]},
	
	RecFun = shapes:shapesFilter2(rectangle),
	RecVec = RecFun(Vec),
	Area1 = 44.0,
	Area1 = shapes:shapesArea(RecVec),
	
	TriFun = shapes:shapesFilter2(triangle),
	TriVec = TriFun(Vec),
	Area2 = 22.0,
	Area2 = shapes:shapesArea(TriVec),	

	EllFun = shapes:shapesFilter2(ellipse),
	EllVec = EllFun(Vec),

	Area3 = shapes:shapesArea(EllVec),
	Area3 - 44*math:pi()< 0.000000000001,

	SqrFun = shapes:shapesFilter2(square),
	SqrVec = SqrFun(Vec),
	Area4 = 4,
	Area4 = shapes:shapesArea(SqrVec),

	CrcFun = shapes:shapesFilter2(circle),
	CrcVec = CrcFun(Vec),
	Area5 = 4.0*math:pi(),
	Area5 = shapes:shapesArea(CrcVec),
	
	io:format("PASS~n~n").
	
testFail1() -> shapes:shapesArea({shapes, [{tri, {dim, 1, 1}}]}).
	
testFail2() -> shapes:squaresArea({shape, [{triangle, {dim, 1, 1}}]}).
	
testFail3() -> shapes:trianglesArea({shapes, [{rectangle, {1, 1}}]}).
	
testFail4() -> shapes:shapesArea({shapes, [{ellipse, {dim, 1, 1}}]}).

testFail5() -> shapes:squaresArea({[{ellipse, {radius, 1, 1}}]}).

testFail6() -> shapes:trianglesArea({shapes, {triangle, {dim, 1, 1}}}).

testFail7() -> shapes:shapesArea({shapes, [{ellipse, {radius, 0, 6}}]}).

testFail8() -> shapes:squaresArea({shapes, [{ellipse, {radius, -1, 6}}]}).

testFail9() -> shapes:trianglesArea({shapes, [{triangle, {dim, 0, 6}}]}).

testFail10() -> shapes:shapesArea({shapes, [{triangle, {dim, -1, 6}}]}).

testFail11() -> shapes:squaresArea({shapes, [{rectangle, {dim, 0, 6}}]}).

testFail12() -> shapes:trianglesArea({shapes, [{rectangle, {dim, -1, 6}}]}).

testFail13() -> shapes:shapesFilter({shapes, [{rectangle, {dim, -1, 6}}]}).

testFail14() -> shapes:shapesFilter2(hexagon).

testFail15() -> shapes:shapesFilter(circle).

testAll() ->
	test1(),
	test2(),
	test3(),
	test4(),
	test5(),
	io:format("DONE~n").
	
test(1) -> test1();
test(2) -> test2();
test(3) -> test3();
test(4) -> test4();
test(5) -> test5();
test(-1) -> testFail1();
test(-2) -> testFail2();
test(-3) -> testFail3();
test(-4) -> testFail4();
test(-5) -> testFail5();
test(-6) -> testFail6();
test(-7) -> testFail7();
test(-8) -> testFail8();
test(-9) -> testFail9();
test(-10) -> testFail10();
test(-11) -> testFail11();
test(-12) -> testFail12();
test(-13) -> testFail13();
test(-14) -> testFail14();
test(-15) -> testFail15();
test(X) -> io:format("~w : undefined test~n", [X]).