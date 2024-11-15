import numpy as np

def suavizar_bordes(x, fade):
    """
    Suaviza los bordes de una señal.
    
    Parámetros:
    x (array): señal original
    fade (float): representa el tiempo de transición como un porcentaje del largo de x
    
    Retorna:
    s (array): versión suavizada de x
    """
    M = len(x)
    
    # Limitar el valor de fade entre 1 y 50
    fade = min(max(fade, 1), 50)
    
    # Asegurarse de que x sea un array 1D
    x = np.ravel(x)
    
    # Calcular el tamaño del desvanecimiento
    N = 2 * int(fade / 100 * M) // 2  # Asegura que N sea par
    v = np.hamming(N)
    
    # Dividir en fade_in y fade_out
    fade_in = v[:N // 2]
    fade_out = v[N // 2:]
    
    # Aplicar la ventana para suavizar bordes
    s = np.concatenate((fade_in, np.ones(M - N), fade_out)) * x
    
    return s
