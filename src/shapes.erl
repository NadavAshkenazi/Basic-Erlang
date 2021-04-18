%%%-------------------------------------------------------------------
%%% @author nadav ashkenazi
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Apr 2021 16:33
%%%-------------------------------------------------------------------
-module(shapes).
-author("nadav ashkenazi").

%% API
-export([shapesArea/1, squaresArea/1, trianglesArea/1, shapesFilter/1, shapesFilter2/1]).


isParametersValid(Shape) ->
  Params = element(2, Shape),
  element(2,Params) >= 0 andalso element(3,Params) >= 0.


isShapeValid(Shape) when erlang:is_tuple(Shape) ->
  if
    erlang:element(1, Shape) =:= 'rectangle' -> isParametersValid(Shape);
    erlang:element(1, Shape) =:= 'triangle' -> isParametersValid(Shape);
    erlang:element(1, Shape) =:= 'ellipse' -> isParametersValid(Shape);
    true -> false
  end.

isShapesListValid([]) -> true;
isShapesListValid([H|T]) -> isShapeValid(H) andalso isShapesListValid(T).
  

isShapesValid(Shapes) when is_tuple(Shapes) andalso element(1, Shapes) =:= 'shapes' ->
    isShapesListValid(erlang:element(2, Shapes)).


getTriangleArea(Shape) when erlang:element(1, Shape) =:= 'triangle' ->
  {dim, Base, Height} = erlang:element(2, Shape),
  Base*Height/2.

getRectangleArea(Shape) when erlang:element(1, Shape) =:= 'rectangle' ->
  {dim, Width, Height} = erlang:element(2, Shape),
  Width*Height.

getEllipseArea(Shape) when erlang:element(1, Shape) =:= 'ellipse' ->
  {radius, Radius1, Radius2} = erlang:element(2, Shape),
  Radius1*Radius2*math:pi().

getShapeArea(Shape) ->
  if
    erlang:element(1, Shape) =:= 'triangle'-> getTriangleArea(Shape);
    erlang:element(1, Shape) =:= 'rectangle'-> getRectangleArea(Shape);
    erlang:element(1, Shape) =:= 'ellipse'-> getEllipseArea(Shape)
  end.

getShapesListArea([]) -> 0;
getShapesListArea([H|T]) ->
  getShapeArea(H) + getShapesListArea(T).

shapesArea(Shapes) ->
  case isShapesValid(Shapes) of
    true -> getShapesListArea(element(2,Shapes))
  end.

isSquare(Shape) ->
  {_Dim, Width, Height} = erlang:element(2, Shape),
  element(1,Shape) =:= 'rectangle' andalso Width == Height.

getSquaresListArea([]) -> 0;
getSquaresListArea([H|T]) ->
  case isSquare(H) of
    true -> getRectangleArea(H) + getSquaresListArea(T);
    false -> getSquaresListArea(T)
  end.

squaresArea(Shapes) ->
  case isShapesValid(Shapes) of
    true -> getSquaresListArea(element(2,Shapes))
  end.

getTrianglesListArea([]) -> 0;
getTrianglesListArea([H|T]) ->
  if
    element(1,H) =:= 'triangle' -> getTriangleArea(H) + getTrianglesListArea(T);
    true -> getTrianglesListArea(T)
  end.

trianglesArea(Shapes) ->
  case isShapesValid(Shapes) of
    true -> getTrianglesListArea(element(2,Shapes))
  end.


shapesFilter(Shape, Shapes) ->
  case isShapesValid(Shapes) of
    true ->
      IsShape = fun(NewShape) -> element(1,NewShape) =:= Shape end,
      {shapes, lists:filter(IsShape, element(2,Shapes))}
end.

shapesFilter(Shape) when is_atom(Shape)->
  fun(Shapes) -> shapesFilter(Shape, Shapes) end.

circleFilter(Shapes) ->
  case isShapesValid(Shapes) of
    true ->
      IsCircle = fun(NewShape) ->
        {_, Radius1, Radius2} = element(2, NewShape),
        element(1,NewShape) =:= 'ellipse' andalso Radius1 == Radius2 end,
      {shapes, lists:filter(IsCircle, element(2,Shapes))}
  end.

squareFilter(Shapes) ->
  case isShapesValid(Shapes) of
    true ->
      IsSquare = fun(NewShape) ->
        {_, Width, Height} = element(2, NewShape),
        element(1,NewShape) =:= 'rectangle' andalso Width == Height end,
      {shapes, lists:filter(IsSquare, element(2,Shapes))}
  end.

shapesFilter2(Shape) when is_atom(Shape) ->
  case Shape of
    'circle' -> (fun(Shapes) -> circleFilter(Shapes) end);
    'square' -> (fun(Shapes) -> squareFilter(Shapes) end);
    _ -> shapes:shapesFilter(Shape)
  end.
