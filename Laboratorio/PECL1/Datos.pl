%persona[chico/a, pelo, ropa, estado de animo, gafas, ojos, lunares, barba, arrugas, gorro, pendientes, maquillaje]

%chicos
albert(['albert','chico','pelo_negro','ropa_verde','feliz','gafas','ojos_azules','no_lunares','no_barba','no_arrugas','gorro','no_pendientes','maquillaje']).
paul(['paul','chico','pelo_rubio','ropa_azul','triste','no_gafas','ojos_marrones','lunares','no_barba','no_arrugas','no_gorro','pendientes','no_maquillaje']).
tom(['tom','chico','calvo','ropa_verde','feliz','no_gafas','ojos_marrones','lunares','no_barba','arrugas','no_gorro','no_pendientes','no_maquillaje']).
derek(['derek','chico','pelo_rojo','ropa_roja','triste','no_gafas','ojos_marrones','no_lunares','barba','arrugas','gorro','no_pendientes','maquillaje']).
richard(['richard','chico','calvo','ropa_amarilla','feliz','gafas','ojos_azules','no_lunares','barba','no_arrugas','no_gorro','pendientes','no_maquillaje']).
louis(['louis','chico','pelo_negro','ropa_roja','triste','no_gafas','ojos_azules','lunares','no_barba','no_arrugas','no_gorro','pendientes','maquillaje']).
michael(['michael','chico','pelo_rubio','ropa_azul','feliz','gafas','ojos_marrones','lunares','barba','arrugas','gorro','no_pendientes','maquillaje']).
charles(['charles','chico','pelo_rojo','ropa_azul','feliz','gafas','ojos_marrones','lunares','no_barba','no_arrugas','gorro','pendientes','no_maquillaje']).
sam(['sam','chico','pelo_rubio','ropa_roja','triste','no_gafas','ojos_azules','no_lunares','no_barba','arrugas','gorro','no_pendientes','maquillaje']).
will(['will','chico','pelo_rubio','ropa_verde','feliz','no_gafas','ojos_azules','lunares','no_barba','arrugas','no_gorro','no_pendientes','no_maquillaje']).
anthony(['anthony','chico','calvo','ropa_amarilla','feliz','gafas','ojos_marrones','no_lunares','no_barba','arrugas','gorro','no_pendientes','maquillaje']).
billy(['billy','chico','pelo_rubio','ropa_verde','triste','no_gafas','ojos_azules','no_lunares','no_barba','arrugas','gorro','pendientes','maquillaje']).
henry(['henry','chico','calvo','ropa_roja','triste','no_gafas','ojos_marrones','lunares','barba','arrugas','gorro','no_pendientes','no_maquillaje']).
alvaro(['alvaro','chico','pelo_rojo','ropa_roja','triste','gafas','ojos_marrones','lunares','barba','arrugas','gorro','pendientes','maquillaje']).
victor(['victor','chico','calvo','ropa_amarilla','feliz','no_gafas','ojos_azules','lunares','barba','no_arrugas','no_gorro','no_pendientes','no_maquillaje']).

%chicas
tiffany(['tiffany','chica','calvo','ropa_verde','triste','no_gafas','ojos_marrones','lunares','no_barba','arrugas','gorro','pendientes','no_maquillaje']).
natalie(['natalie','chica','pelo_rojo','ropa_roja','feliz','gafas','ojos_azules','no_lunares','no_barba','arrugas','gorro','no_pendientes','no_maquillaje']).
roxanne(['roxanne','chica','pelo_negro','ropa_amarilla','triste','no_gafas','ojos_azules','lunares','no_barba','arrugas','gorro','no_pendientes','maquillaje']).
sarah(['sarah','chica','pelo_negro','ropa_azul','triste','gafas','ojos_marrones','no_lunares','no_barba','no_arrugas','gorro','pendientes','maquillaje']).
sabrina(['sabrina','chica','calvo','ropa_verde','feliz','gafas','ojos_azules','lunares','no_barba','arrugas','gorro','no_pendientes','maquillaje']).
cindy(['cindy','chica','calvo','ropa_roja','feliz','no_gafas','ojos_marrones','lunares','no_barba','no_arrugas','gorro','pendientes','maquillaje']).
laura(['laura','chica','pelo_rojo','ropa_amarilla','triste','no_gafas','ojos_azules','no_lunares','no_barba','arrugas','no_gorro','pendientes','no_maquillaje']).
victoria(['victoria','chica','pelo_rubio','ropa_azul','feliz','gafas','ojos_marrones','lunares','barba','no_arrugas','no_gorro','pendientes','no_maquillaje']).
alba(['alba','chica','pelo_rubio','ropa_verde','feliz','gafas','ojos_marrones','lunares','barba','no_arrugas','no_gorro','no_pendientes','maquillaje']).
eva(['eva','chica','pelo_rubio','ropa_amarilla','feliz','no_gafas','ojos_marrones','no_lunares','no_barba','arrugas','no_gorro','no_pendientes','maquillaje']).
pepa(['pepa','chica','calvo','ropa_roja','feliz','no_gafas','ojos_marrones','lunares','no_barba','no_arrugas','no_gorro','pendientes','no_maquillaje']).
rosa(['rosa','chica','pelo_negro','ropa_amarilla','triste','no_gafas','ojos_azules','no_lunares','no_barba','arrugas','gorro','pendientes','no_maquillaje']).
margarita(['margarita','chica','calvo','ropa_azul','feliz','gafas','ojos_marrones','lunares','barba','no_arrugas','no_gorro','pendientes','no_maquillaje']).
ines(['ines','chica','pelo_rojo','ropa_verde','feliz','gafas','ojos_azules','lunares','barba','no_arrugas','no_gorro','no_pendientes','maquillaje']).
paula(['paula','chica','pelo_negro','ropa_amarilla','triste','no_gafas','ojos_marrones','no_lunares','no_barba','arrugas','gorro','no_pendientes','maquillaje']).

preguntas(Preguntas):- Preguntas = ['chica','calvo','pelo_negro','pelo_rubio','pelo_rojo','ropa_roja','ropa_verde','ropa_azul','feliz','ojos_marrones','lunares','barba','arrugas','gafas','gorro','pendientes','maquillaje'].
personajes(ListaPersonajes):- albert(P1),paul(P2),tom(P3),derek(P4),richard(P5),louis(P6),michael(P7),charles(P8),sam(P9),will(P10),anthony(P11),billy(P12),henry(P13),tiffany(P14),natalie(P15),
                              roxanne(P16),sarah(P17),sabrina(P18),cindy(P19),laura(P20),victoria(P21),alba(P22),eva(P23),alvaro(P24),victor(P25),pepa(P26),rosa(P27),margarita(P28),ines(P29),paula(P30), ListaPersonajes =[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,P24,P25,P26,P27,P28,P29,P30].
