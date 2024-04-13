%%%% Ejercicio 1 %%%%

sub_conjunto([], _).
sub_conjunto([X|Xs], Ys) :- member(X, Ys), sub_conjunto(Xs, Ys).

/*Pruebas de ejercicio:*/
ejemplo_true :-
    sub_conjunto([1,2,3], [1,2,3,4,5]).
ejemplo_false :-
    sub_conjunto([1,2,6], [1,2,3,4,5]).



%%%% Ejercicio 2 %%%%

aplanar([], []).
aplanar([Lista|Resto], Aplanado) :- is_list(Lista),!, aplanar(Lista, ListaAplanada), aplanar(Resto, RestoAplanado),
append(ListaAplanada, RestoAplanado, Aplanado).

aplanar([Elemento|Resto], [Elemento|RestoAplanado]):- aplanar(Resto, RestoAplanado).

/*Pruebas de ejercicio:*/
ejemplo_aplanar:- X=([1,2,[3,[4,5],[6,7]]],X).
ejemplo_aplanar:- X=([2,1,[4,[3,6],[5,7]]],X).
%aplanar([1,2,[3,[4,5],[6,7]]],X).



%%%% Ejercicio 3 %%%%

distanciaH(Str1, Str2, N) :-
    string_chars(Str1, Chars1),
    string_chars(Str2, Chars2),
    distanciaHaming(Chars1, Chars2, 0, N).

distanciaHaming([], [], N, N).
distanciaHaming([H1|T1], [H2|T2], Acc, N) :-
    (H1 \= H2 -> N1 is Acc + 1; N1 is Acc),
    distanciaHaming(T1, T2, N1, N).

/*Pruebas de ejercicio:*/
%distanciaH("romano","comino",X).
%distanciaH("romano","camino",X).
%distanciaH("roma","comino",X).
%distanciaH("romano","ron",X).
%distanciaH("romano","cama",X).


%%%% Ejercicio 4 %%%%

% Tipos de platos dados en el enunciado
tipo_plato(entrada, [guacamole, ensalada, consome, tostadas_caprese]).
tipo_plato(carne, [filete_de_cerdo, pollo_al_horno, carne_en_salsa]).
tipo_plato(pescado, [tilapia, salmon, trucha]).
tipo_plato(postre, [flan, nueces_con_miel, naranja_confitada, flan_de_coco]).

% Calorías por cada plato brindados
calorias(guacamole, 200).
calorias(ensalada, 150).
calorias(consome, 300).
calorias(tostadas_caprese, 250).
calorias(filete_de_cerdo, 400).
calorias(pollo_al_horno, 280).
calorias(carne_en_salsa, 320).
calorias(tilapia, 160).
calorias(salmon, 300).
calorias(trucha, 225).
calorias(flan, 200).
calorias(nueces_con_miel, 500).
calorias(naranja_confitada, 450).
calorias(flan_de_coco, 375).
% Categorias de platos
categoria_plato(entrada, [guacamole, ensalada, consome, tostadas_caprese]).
categoria_plato(carne, [filete_de_cerdo, pollo_al_horno, carne_en_salsa]).
categoria_plato(pescado, [tilapia, salmon, trucha]).
categoria_plato(postre, [flan, nueces_con_miel, naranja_confitada, flan_de_coco]).

% Calorías por cada plato
calorias_plato(guacamole, 200).
calorias_plato(ensalada, 150).
calorias_plato(consome, 300).
calorias_plato(tostadas_caprese, 250).
calorias_plato(filete_de_cerdo, 400).
calorias_plato(pollo_al_horno, 280).
calorias_plato(carne_en_salsa, 320).
calorias_plato(tilapia, 160).
calorias_plato(salmon, 300).
calorias_plato(trucha, 225).
calorias_plato(flan, 200).
calorias_plato(nueces_con_miel, 500).
calorias_plato(naranja_confitada, 450).
calorias_plato(flan_de_coco, 375).
%Sumatoria de platos que no sobrepasan la cantidad de calorias máximas
suma_calorias_platos([], 0).
suma_calorias_platos([Plato|Platos], TotalCalorias) :-
    calorias_plato(Plato, CaloriasPlato),
    suma_calorias_platos(Platos, CaloriasRestantes),
    TotalCalorias is CaloriasPlato + CaloriasRestantes.

esta_en(Elem, [Elem|_]).
esta_en(Elem, [_|T]) :- esta_en(Elem, T).

%Sin repetición de platos

comida_completa_sin_repeticiones(ComidasAnteriores, MaxCalorias, ComidaCompleta) :-
    categoria_plato(entrada, Entradas),
    categoria_plato(carne, Carnes),
    categoria_plato(pescado, Pescados),
    categoria_plato(postre, Postres),
    esta_en(Entrada, Entradas),
    esta_en(Carne, Carnes),
    esta_en(Pescado, Pescados),
    esta_en(Postre, Postres),
    not(esta_en(Entrada, ComidasAnteriores)),
    not(esta_en(Carne, ComidasAnteriores)),
    not(esta_en(Pescado, ComidasAnteriores)),
    not(esta_en(Postre, ComidasAnteriores)),
    suma_calorias_platos([Entrada, Carne, Pescado, Postre], TotalCalorias),
    TotalCalorias =< MaxCalorias,
    ComidaCompleta = [Entrada, Carne, Pescado, Postre].
% Consulta de platos según, la cantiada de comidas, cantidad de calorias
% y las combinaciones.

consultar_comidas(N, MaxCalorias, Combinaciones) :-
    findall(Combinacion, (between(1, N, _), comida_completa_sin_repeticiones([], MaxCalorias, Combinacion)), Combinaciones).

/*Pruebas de ejercicio:*/
%consultar_comidas(5, 1000, Combinaciones).
%sultar_comidas(5, 900, Combinaciones).


