[Virtuale](https://virtuale.unibo.it/course/view.php?id=59746)

> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)
# Notes

## 1. Distributed systems and SOAs
==Distributed system== -> a network of endpoints that communicate by exchanging messages
Examples: your OS, a browser with a Tab manager

Programming distributed systems tasks:
- handling communications -> ability to exchange messages
- handling heterogeneity -> base standards to make sure different endpoints can communicate (eg. C# on Win / C++ on Linux), aka speak a common tongue
- handling faults -> Make sure to avoid crashes when errors occur, since it's expected (eg. an endpoint can go down)
- handling the evolution of systems -> update without "turning off" an endpoint

Always remember to close channels and catch exceptions, error handling

Faults can affect multiple endpoints (eg. in a client/store transaction, many things can go wrong from any client/bank/store endpoint)

Things can be made easier by hiding low level details, abstracting. It can be done with libraries, tools, frameworks or by making new programming languages

==Service-oriented Computing (SOC)== -> A design paradigm for distributed systems.
A service-oriented system is a network of services. Services communicate through message passing.

Service-Oriented Architecture (SOA) -> architecture based of the Service-oriented computing paradigm.

Services in SOA offer operations, as Objects offer methods
![[Pasted image 20240916133419.png]]

