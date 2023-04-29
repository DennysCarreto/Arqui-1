def convertbase(numero, base_original, base_nueva):
    # convertir número a base 10
    valor_Decimal = 0
    for digito in str(numero):
        valor_Decimal = valor_Decimal * base_original + int(digito)

    # convertir número de base 10 a nueva base

    digitos_nueva_base = []
    while valor_Decimal > 0:
        residuo = valor_Decimal % base_nueva
        digitos_nueva_base.append(residuo)
        valor_Decimal //= base_nueva

    # convertir lista de digitos de nueva base a string
    digitos_nueva_base.reverse()
    nueva_base_str = ''
    for digito in digitos_nueva_base:
        nueva_base_str += str(digito)

    return nueva_base_str


while True:
    dato = int(input("Ingrese lo que desea convertir: "))
    baseEntrada = int(input("Ingrese la base Actual: "))
    baseSalida = int(input("Ingrese la base para hacer la conversion: "))
    resultado = convertbase(dato, baseEntrada, baseSalida)

    print('******************************************12')
    print(f"Ingresado: {dato}")
    print(f"La base de entrada: {baseEntrada}, Base de salida: {baseSalida}")
    print(f"El resultado es: {resultado}")
