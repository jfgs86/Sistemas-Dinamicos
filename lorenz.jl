"""
Bibliotecas:
1. PyPlot -> gráficos de nivel
2. ODE -> Resuelve sistema ecuaciones diferenciales 
"""
#using Plots
using PyPlot
pygui(true)
using ODE

"""
Implementanos la funcion que defiene el sistema de ecuaciones del Sistema de Lorenz
"""
function f(t, r)
    
    (x, y, z) = r  #vector donde se van almacenan los valores de x, y, z
    
    #Sistema de Lorenz
    dx_dt = sigma*(y-x)
    dy_dt = x*(rho - z)-y
    dz_dt = x*y-beta*z

    #Devuelve las derivadas del vector
    [dx_dt; dy_dt; dz_dt]
    
end


dt = 0.001 #tamaño de paso
tf = 100.0 #tiempo final
t = collect(0:dt:tf) #intervalo de temporal 

r0 = [0.1; 0.0; 0.0] #condiciones iniciales

#valores de los parametros
sigma = 10.0
rho = 28.0
beta = 8.0/3.0

(t, pos) = ode23(f,r0, t) #solucion del sistema de ecuaciones diferenciales (funcion, condiciones iniciales, intervalo temporal)
#sacamos los valores de x, y, z
x = map(v -> v[1], pos)
y = map(v -> v[2], pos)
z = map(v -> v[3], pos)
#grafica
#plot3D(x, y, z)

#grafica
#fig, ax = subplots(1, 3, sharex=true, sharey=true, figsize=(16, 8))
fig, ax = subplots(1, 3, figsize=(14, 7))
fig.suptitle("TLACUEPALLI GRUPO DE INVESTIGACIÓN EN CIENCIAS DE LA COMPLEJIDAD\nAtractor de Lorenz",fontsize=14)
#fig.text(0.2, -0.02, "TLACUEPALLI\nGrupo de investigación de Ciencias e la Complejidad", ha="center")


ax[1][:plot](x,y)
ax[1][:set_title]("X - Y")
ax[1][:set_xlabel]("eje x")
ax[1][:set_ylabel]("eje y")

ax[2][:plot](x,z)
ax[2][:set_title]("X - Z")
ax[2][:set_xlabel]("eje x")
ax[2][:set_ylabel]("eje z")

ax[3][:plot](y,z)
ax[3][:set_title]("Y - Z")
ax[3][:set_xlabel]("eje y")
ax[3][:set_ylabel]("eje z")

savefig("atractor_lorenz.png")