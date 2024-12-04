Attaccante -> Consulente del dipendente (chiamato cosi' per comodita')
## Acquisizione

l'acquisizione e' stata effettuata con Kali Linux 2024.3 Live 32 bit (disponibile da https://www.kali.org/get-kali/#kali-live)

In particolare e' stato effettuato il boot di Kali premendo F12 a startup, avviando Kali in `Forensics mode`.
Successivamente all'avvio, da terminale abbiamo controllato l'indirizzo logico dei dischi con il comando `sudo fdisk -l`.
Avendo individuato l'hard disk da acquisire come quello in `/dev/sda`