"""
Cargamos librerias:
1. ODE -> resuleve sistemas en ecuaciones diferenciales ordinarias
2. Pyplot -> crea gráficas
"""

using ODE
using PyPlot

"""
Funcion del sistema dinamico de Lotka-Volterra
"""
function f(t, r)

    (x, y) = r
    dx_dt = x*(alpha - beta *y) ###ecuación de la presa (conejos)
    dy_dt = y*(-delta + gamma * x) ###ecuacion del depredador (lobos)

    [dx_dt; dy_dt]
end 


t = LinRange(0.0,30,1000) ##tiempo

r0 = [4.0; 2.0] ##condiciones iniciales

"""
Parametros del sistema
"""
alpha=1.0 #nacimientos de presas 
beta=1.0  ##muertes de presas
delta=1.0 ##nacimientos de depredadores
gamma=1.0 ##muertes de depredadores

(t,pos) = ode23(f,r0,t) ## funcion ode23 resuelve el sistema de ecuaciones en diferenciales (funcion, condiciones iniciales, tiempo)

x = map(v -> v[1],pos) ## resultados de la dinamica de las presas
y = map(v -> v[2], pos) ##resultados de la dinamica de los depredadores

"""
Graficas
"""
#plot(t,x,"xb",label="Conejos")
#plot(t,y,"+r",label="Lobos")
#xlabel("tiempo")
#ylabel("Población")
#title("Modelo de Lotka-Volterra")
 
fig, ax = subplots(1, 2, figsize=(14, 7))
fig.suptitle("TLACUEPALLI GRUPO DE INVESTIGACIÓN EN CIENCIAS DE LA COMPLEJIDAD\nModelo de Lotka_Volterra",fontsize=14)
#fig.text(0.2, -0.02, "TLACUEPALLI\nGrupo de investigación de Ciencias e la Complejidad", ha="center")

"""
Dinamica temporal
"""
ax[1][:plot](t,x,"xb")
ax[1][:plot](t,y,"+r")
ax[1][:legend](["Conejos";"Lobos"], loc="upper right")
ax[1][:set_xlabel]("Tiempo")
ax[1][:set_ylabel]("Población")
ax[1][:set_title]("Diagrama de Fase")

"""
Diagrama de Fase
"""
ax[2][:plot](x,y)
ax[2][:set_xlabel]("Conejos")
ax[2][:set_ylabel]("Lobos")
ax[2][:set_title]("Diagrama de Fase")

savefig("lotka_volterra.png")