:-consult('Datos').
:-consult('Caras').

% Función: asignarPersonajes
% Se encarga de atribuirle un personaje a cada jugador (JvJ o JvM) y eliminarlo de su propio tablero
% PersonajeX es el nombre y los atributos del jugador X en una sola lista Ej: [nombre,atr1,atr2|...]
% JugadorX es una ED que es una lista con el primer elemento como el nombre del jugador
% y el segundo elemento es una lista con los atributos Ej: [nombre, [atr1,atr2|...]]

asignarPersonajes(Jugador1, Jugador2, TableroJ1, TableroJ2):-
         randset(2, 30, S),                            % Seleccionamos 2 números aleatorios de entre los 30 totales
         [Num1,Num2]=S,                                % Guardamos esos dos números escogidos
         personajes(LP),                               % Cargamos la lista de personajes
         nth1(Num1, LP, Personaje1 ,_),                % Cogemos el primer personaje en la posición Num1 de la lista de personajes
         nth1(Num2, LP, Personaje2 ,_),                % Cogemos el segundo personaje en la posición Num2 de la lista de personajes
         nth0(0,Personaje1,NombreP1,_),                % Obtenemos el nombre del primer personaje
         nth0(0,Personaje2,NombreP2,_),                % Obtenemos el nombre del segundo personaje
         [_|ListaAtrJ1] =  Personaje1,                 % Hacemos una lista de los atributos del Personaje quitando el nombre a la lista (ListaAtrJX)
         [_|ListaAtrJ2] =  Personaje2,
         append([NombreP1], [ListaAtrJ1], Jugador1),   % Atribuimos el nombre y los atributos del primer personaje a jugador1   --> Ej: [nombre, [atr1,atr2|...]]
         append([NombreP2], [ListaAtrJ2], Jugador2),   % Atribuimos el nombre y los atributos del segundo personaje a jugador2
         select(Personaje1, LP, TableroJ1),
         select(Personaje2, LP, TableroJ2).            % Borramos el personaje que el jugador está jugando de su tablero

% ---------------------------------------------------------

% Función: responderPregunta
% Mira si el personaje del rival tiene la característica por el que se le ha preguntado

responderPregunta(Tablero,Pregunta,ListaAtributosJ,Respuesta):-
           member(Pregunta,ListaAtributosJ),                                           % True si tiene la característica
           write("SI.\n"),
           write("Ya sabes que soy uno de los personajes de la siguiente lista: \n"),
           buscarAtributosSI(Pregunta,Tablero,Respuesta);                              % OR
           write("NO.\n"),                                                             % False si no tiene la característica
           write("Ya sabes que soy uno de los personajes de la siguiente lista: \n"),
           buscarAtributosNO(Pregunta,Tablero,Respuesta).

% ---------------------------------------------------------

% Función: buscarAtributosSI
% Busca de forma recursiva y con ayuda de una función auxiliar todos aquellos personajes que cumplen la característica que se pregunta del personaje rival

buscarAtributosSI(Pregunta,Tablero,Respuesta):-buscarAtributosAuxSI(Pregunta,Tablero,Respuesta,[]).

buscarAtributosAuxSI(Atributo,[TableroH|TableroT],Respuesta,ListaAux):- member(Atributo,TableroH),
                                                                        buscarAtributosAuxSI(Atributo,TableroT,Respuesta,[TableroH|ListaAux]),!.

buscarAtributosAuxSI(Atributo,[TableroH|TableroT],Respuesta,ListaAux):- not(member(Atributo,TableroH)),
                                                                        buscarAtributosAuxSI(Atributo,TableroT,Respuesta,ListaAux),!.

buscarAtributosAuxSI(_,[],X,X).

% ---------------------------------------------------------

% Función: buscarAtributosNO
% Busca de forma recursiva y con ayuda de una función auxiliar todos aquellos personajes que NO cumplen la característica que se pregunta del personaje rival

buscarAtributosNO(Pregunta,Tablero,Respuesta):-buscarAtributosAuxNO(Pregunta,Tablero,Respuesta,[]).

buscarAtributosAuxNO(Atributo,[TableroH|TableroT],Respuesta,ListaAux):- member(Atributo,TableroH),
                                                                        buscarAtributosAuxNO(Atributo,TableroT,Respuesta,ListaAux),!.

buscarAtributosAuxNO(Atributo,[TableroH|TableroT],Respuesta,ListaAux):- not(member(Atributo,TableroH)),
                                                                        buscarAtributosAuxNO(Atributo,TableroT,Respuesta,[TableroH|ListaAux]),!.

buscarAtributosAuxNO(_,[],X,X).

% ---------------------------------------------------------

% Función: inversa
% Devuelve la lista inversa
% Cómo llamarla: inversa([a,b,c],Resultado,[]).

inversa([H|T],X,Acc) :- inversa(T,X,[H|Acc]).
inversa([],X,X).

% ---------------------------------------------------------

% Función: imprimirTablero
% Para imprimir por pantalla todos los personajes encontrados con una característica actualizados

imprimirTablero(Tablero):- imprimirTableroAux(Tablero).

imprimirTableroAux([PersonajeH|PersonajeT]):- write(PersonajeH),write("\n"),
                                              imprimirTableroAux(PersonajeT),!.
imprimirTableroAux([]).

% ---------------------------------------------------------

% Función: num_elementos
% Sirve como condición de parada para comprobar que el juego ha acabado, que será cuando sólo quede un único personaje en el tablero.

num_elementos([_|Xs],Total):- num_elementos(Xs,Aux), Total is Aux + 1.
num_elementos([],0).

% ---------------------------------------------------------

% Función: jugar
% TableroJX --> lista de listas donde se guardan los posibles personajes del contrincante

jugar():-    asignarPersonajes(Jugador1, Jugador2, TableroJ1, TableroJ2),
             preguntas(ListaPreguntasIA),
             write("\n"),
             write("      ¿¿¿¿¿ QUIEN ES QUIEN ?????      "),
             write("\n"),
             write("##########################################"),
             write("\n"),
             nth0(0,Jugador1,NombreJ1,LAtrJ1),                                  % Obtenemos el nombre del jugador
             nth0(0,Jugador2,NombreJ2,LAtrJ2),
             flatten(LAtrJ1,ListaAtrJ1),                                        %Eliminamos las posibles listas de listas de LAtrJX.  ||   flatten([[1,2],3] ,X) --> X=[1,2,3]
             flatten(LAtrJ2,ListaAtrJ2),
             write("\n"), write("\nTu personaje es: "),
             write(NombreJ1),write("\n"),
             write("Sus características son: "),
             write(ListaAtrJ1),
             write("\n"), write("\nTu personaje2 es: "),
             write(NombreJ2),write("\n"),
             write("Sus características son: "),
             write(ListaAtrJ2),
             write("\n"), write("\nElige de entre las siguientes preguntas una que quieras hacerme y escribela "),
             write("\n"), write(" cambiando la interrogacion por un punto: "),
             write("\n"), write("  - Sexo: chico?, chica?"),
             write("\n"), write("  - Pelo: pelo_negro?, pelo_rubio?, pelo_rojo?, calvo?"),
             write("\n"), write("  - Ropa: ropa_roja?, ropa_amarilla?, ropa_verde?, ropa_azul?"),
             write("\n"), write("  - Estado de animo: feliz?, triste?"),
             write("\n"), write("  - Ojos: ojos_azules?, ojos_marrones?"),
             write("\n"), write("  - Caracteristicas faciales: lunares?, barba?, arrugas?"),
             write("\n"), write("  - Accesorios: gafas?, gorro?, pendientes?, maquillaje?\n"),
             turnosVsIAFacil(ListaAtrJ1,ListaAtrJ2,TableroJ1,TableroJ2,1,ListaPreguntasIA).

% ---------------------------------------------------------

% Función: turnosVsIAFacil
% Pregunta de forma aleatoria y sin repeticiones por características al jugador humano

turnosVsIAFacil(ListaAtrJ1,ListaAtrJ2,TableroJ1,TableroJ2,NumeroJugador,ListaPreguntasIA):-
           num_elementos(TableroJ1,X),
           X = 1, write("¡¡Ha ganado el jugador 1!!\n\n"),
           imprimirCaras(ListaAtrJ2),!;                                                         % OR
           num_elementos(TableroJ2,X),
           X = 1, write("¡¡Ha ganado la maquina, pringado!!\n\n"),
           imprimirCaras(ListaAtrJ1),!;                                                         % OR
           NumeroJugador = 1,                                                                   % Si le toca preguntar al jugador 1
           write("\nJugador  "),
           write(NumeroJugador),
           write("\nTu pregunta: "),
           read(Pregunta),                                                                      % Lee la pregunta
           responderPregunta(TableroJ1,Pregunta,ListaAtrJ2,RespuestaJ1),                        % Responde a la pregunta
           imprimirTablero(RespuestaJ1),                                                        % Enseñamos la respuesta
           inversa(RespuestaJ1,TableroJ1Bien,[]),
           turnosVsIAFacil(ListaAtrJ1,ListaAtrJ2,TableroJ1Bien,TableroJ2,2,ListaPreguntasIA);     % TableroJ1 es la respuesta y ahora le toca a jugador 2
           NumeroJugador = 2,                                                                   % Si le toca preguntar al jugador 2
           write("\nMaquina  "),
           write("\nSu pregunta es: "),
           num_elementos(ListaPreguntasIA,N),
           randset(1, N, S),
           [NumPregunta]=S,
           nth1(NumPregunta,ListaPreguntasIA,PreguntaIA,ListaPreguntasActIA),                   % Coge la pregunta de la posición aleatoria de la ListaPreguntasIA y lo devuelve como pregunta
           write(PreguntaIA),
           write("\n"),
           responderPregunta(TableroJ2,PreguntaIA,ListaAtrJ1,RespuestaJ2),                      % Responde a la pregunta
           imprimirTablero(RespuestaJ2),
           inversa(RespuestaJ2,TableroJ2Bien,[]),
           turnosVsIAFacil(ListaAtrJ1,ListaAtrJ2,TableroJ1,TableroJ2Bien,1,ListaPreguntasActIA).  % TableroJ2 es la respuesta y ahora le toca a jugador 2

% ---------------------------------------------------------
           
% Función: imprimirCaras
% Saca con ASCII art una representación gráfica básica del personaje que se ha adivinado

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 member(barba,ListaAtributos),
                                 member(gorro,ListaAtributos),
                                 cara13().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 member(barba,ListaAtributos),
                                 member(gorro,ListaAtributos),
                                 cara10().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 member(gafas,ListaAtributos),
                                 cara1().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 member(arrugas,ListaAtributos),
                                 cara2().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 cara3().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara4().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(pelo_rubio,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 cara5().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(pelo_rubio,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara6().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(gafas,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara7().

imprimirCaras(ListaAtributos):-  member(chica,ListaAtributos),
                                 member(arrugas,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara8().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 member(gafas,ListaAtributos),
                                 cara9().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 member(gorro,ListaAtributos),
                                 cara11().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 member(gafas,ListaAtributos),
                                 cara12().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 member(gorro,ListaAtributos),
                                 cara14().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(calvo,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara16().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(calvo,ListaAtributos),
                                 member(feliz,ListaAtributos),
                                 cara17().

imprimirCaras(ListaAtributos):-  member(chico,ListaAtributos),
                                 member(triste,ListaAtributos),
                                 cara14().
