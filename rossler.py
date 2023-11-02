
"""
Modulos:
 1. numpy -> manejo de arreglos
 2. solve_ivp -> funcion que resuelve EDO
 3. matplotlib -> graficas
 4. mpl_toolkits.mplot3d -> graficos en 3d
"""

import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

"""
Definimos el sistema de ecuaciones diferenciales del atractor de Rossler
"""

def f(t, X, a, b, c):
    x, y, z = X
    dx_dt = -(y + z)
    dy_dt = x+a*y
    dz_dt = b + z*(x-c)
    return dx_dt, dy_dt, dz_dt

# Parametros
a, b, c = 0.2, 0.2, 5.7

# Condiciones iniciales
x0, y0, z0 = 0, 1, 1.05

# Maximum time point and total number of time points.
tmax, n = 1000, 10000


# Integración del sistema
soln = solve_ivp(f, (0, tmax), (x0, x0, x0), args=(a, b, c),
                 dense_output=True)

# Interpolar la solucion en una malla temporal
t = np.linspace(0, tmax, n)
x, y, z = soln.sol(t)

# Tamaño de la ventana del grafico 
largo, alto, DPI = 1000, 750, 100

fig = plt.figure(facecolor='k', figsize=(largo/DPI, alto/DPI))
ax = fig.add_subplot(projection='3d')
ax.set_facecolor('k')


#Graficamos una línea multicolor trazándola en segmentos de longitud "s" 
#que cambian de color a lo largo de toda la serie temporal

s = 100
cmap = plt.cm.hot
for i in range(0,n-s,s):
    ax.plot(x[i:i+s+1], y[i:i+s+1], z[i:i+s+1], color=cmap(i/n), alpha=0.4)

# Quitamos los ejes
ax.set_axis_off()
ax.set_title('TLACUEPALLI GRUPO DE INVESTIGACIÓN EN CIENCIAS DE LA COMPLEJIDAD\n\nATRACTOR DE RÖSSLER', color='white')
plt.savefig('rossler.png', dpi=DPI)
plt.show()


