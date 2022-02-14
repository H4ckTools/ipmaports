#!/usr/bin/python3
import re
import sys
import subprocess

# usage: $ python3 whichSystem.py <ip>
#    e.g: $ python3 whichSystem.py 0.0.0.0

if len(sys.argv) != 2:
    print("\n[!] Uso: python3 " + sys.argv[0] + " <direccion-ip>\n")
    sys.exit(1)


def get_ttl(ip_address):
    proc = subprocess.Popen(
        ["/usr/bin/ping -c 1 %s" % ip_address, ""],
        stdout=subprocess.PIPE,
        shell=True
    )
    (out, err) = proc.communicate()
    out = out.split()
    out = out[12].decode('utf-8')
    ttl_value = re.findall(r"\d{1,3}", out)[0]

    return ttl_value


def get_os(ttl):
    ttl = int(ttl)
    if ttl >= 0 and ttl <= 64:
        return "Linux"
    elif ttl >= 65 and ttl <= 128:
        return "Windows"
    else:
        return "Not Found"


if __name__ == '__main__':
    ip_address = sys.argv[1]
    ttl = get_ttl(ip_address)
    os_name = get_os(ttl)
    print("%s (ttl -> %s): %s" % (ip_address, ttl, os_name))
