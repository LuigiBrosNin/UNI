Attaccante -> Consulente del dipendente (chiamato cosi' per comodita')

⚠ DD non genera hash necessariamente uguali ad ogni acquisizione, quindi meglio che usate un altro comando!

## Acquisizione

l'acquisizione e' stata effettuata con Kali Linux 2024.3 Live 32 bit (disponibile da https://www.kali.org/get-kali/#kali-live)

In particolare e' stato effettuato il boot di Kali premendo F12 a startup, avviando Kali in `Forensics mode`.
Successivamente all'avvio, da terminale abbiamo controllato l'indirizzo logico dei dischi con il comando `sudo fdisk -l`.
Avendo individuato l'hard disk da acquisire come quello in `/dev/sda` abbiamo effettuato l'acquisizione tramite il comando

```bash
sudo dd if=/dev/sda of=/media/kali/9C33-6BBD/forensics_acquisizione/acq.img bs=512 conv=noerror,sync status=progress iflag=fullblock
```
nota: il campo `of` e' un path per una cartella di una chiavetta esterna in cui ho messo l'acquisizione

l'acquisizione va' a circa 2-3 MB/s per 60 GB, che sono ammontate a quasi 6 ore di tempo di acquisizione (20.968s lol)

per la chiavetta, prima di inserirla fate attenzione all'automount: c'è un comando da terminale che lo disabilita (cercatelo, lo troverete facilmente). Siate certi che inserita la chiavetta non venga automaticamente montata dal sistema (dato che il mount è read-write)

successivamente lo stesso comando e' stato usato per acquisire i contenuti della chiavetta (7 MB/s, ha finito in pochi minuti dato che si trattava di solo 2 GB di acquisizione)
```bash
sudo dd if=/dev/sdd of=/media/kali/9C33-6BBD/forensics_acquisizione/usb.img bs=512 conv=noerror,sync status=progress iflag=fullblock
```

la versione del tool `dd` utilizzato e' la 9.4

---

