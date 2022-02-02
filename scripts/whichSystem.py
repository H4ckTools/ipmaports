#!/usr/bin/python3
# -*- coding: utf-8 -*-
import re
import sys
import subprocess
import ipaddress
# python3 whichSystem.py ipaddress
try:
    def get_ttl(ip_address):
        ip_address = ipaddress.ip_address(sys.argv[1])
        #                       proc = subprocess.Popen(["/sbin/ping -c 1 2>/dev/null %s" % ip_address, ""], stdout=subprocess.PIPE, shell=True)
        proc = subprocess.Popen(["/bin/ping -c 1 %s" % ip_address, ""], stdout=subprocess.PIPE, shell=True)
        (out, err) = proc.communicate()
        out = out.split()
    #   usar la posicion 12 funciona en linux
    #   out = out[12].decode('utf-8')
        out = out[13].decode('utf-8')
        ttl_value = re.findall(r"\d{1,3}", out)[0]
    #   retorna el varlor del ttl para utilizarlo en la funcion get_os
        return ttl_value
    #   modificado porque imprime en la funcion get_os
    #   print(ttl_value)
    #   print (out)
    def get_os(ttl):
        #       el valor ttl lo convertimos en entero porque seguia siendo string
        ttl = int(ttl)
    #   este print es para debuguear el tipo de datos que debe ser entero
    #   print(type(ttl))
    #   verificamos el valor del ttl
    #   print (ttl)
        if ttl >= 0 and ttl <= 64:
            return "Linux"
        elif ttl >= 64 and ttl <= 128:
            return "Windows"
        else:
            return "Not found"
    if __name__ == '__main__':
        ip_address = sys.argv[1]
        get_ttl(ip_address)
        ttl = get_ttl(ip_address)
        get_os(ttl)
        os_name = get_os(ttl)
        print("%s (ttl -> %s): %s" % (ip_address, ttl, os_name))
except ValueError:
#     if len(sys.argv) != 2:
        print('address is invalid: %s' % sys.argv[1])
        sys.exit(1)
#     else:
except: 
        print("\n[!] use: python3 " + sys.argv[0] + " <ip address>\n")
