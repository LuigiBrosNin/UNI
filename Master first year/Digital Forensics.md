> Notes taken by Luizo ( [@LuigiBrosNin](https://t.me/LuigiBrosNin) on Telegram)

TODO - Download Autopsy software - FTK (only windows :^)
#### Info Esame
Simulazione di un caso giuridico
t1 e t2 lavorano per azienza x, cambiano azienda / c'e' un caso di accordi che compromettono la proprieta' di dati.
gruppo da 3 ruoli di 3 persone (9 persone totale): consulente del dipendente, consulente dell'azienda, consulente del giudice
L'esame e' la discussione delle relazioni scambiate tra queste 3 figure
sostanzialmente sara' un finto processo da mandare avanti e successivamente analizzare.
c. attore -> produce relazione sul caso
c. azienda -> relazione risposta
c. attore -> relazione risposta a sua volta
c. azienda -> relazione risposta ancora
c. giudice -> studia le relazioni, ne fa una per raccapazzare i fatti

dalla seconda meta' di novembre i casi saranno dati, da gennaio si possono fare gli esami.
discussione progetto + orale (il progetto e' indicativo sul voto)
medie alte dei voti (lol)

le informazioni nei dati sono condivisibili con altri gruppi liberamente (la collaborazione e' giusta)

# Teoria

## Introduction
==Digital forensics== -> division of forensics involving the recovery and analysis of data that has been recovered from digital devices.

CS doctors can do many things that can't be done normally (eg. packet sniffing with wireshark, which is a criminal offence)

==ISO/IEC 27043:2015== -> standard for digital evidence investigation principles and processes

Steps in the process
- Identification
- Seizing or Acquisition (Seizing also makes an acquisition, aka making a copy of the files)
- Conservation & Analysis (they can go back and forth)
- Reporting (final report, that has to include the report of all steps)

**Digital forensic examiner** -> to be one, you need to have a desire to ask questions, have specialized equipment and have the required training.

Digital forensics -> not finding the manufact, as they're just the breadcrumbs leading to the identity of the person conducting the illegal activity, but they do not identify the user.

Cybercrime -> wrongdoing that touches the digital world.

## Civil case

**Compensation** -> the end result of a civil case towards 1 end to the other

==Structure of a civil case==
**Actor** -> who threw the case
**Concerned/Convicted** -> against who the actor threw the case
**Judge** -> who decides who won

Each part has a Technical Consultant who examines the evidence, that write a report on the matter, on behalf of their respective client (the judge has an Office TC who helps him verify the validity of the reports). Lawyers are involved as middle men trough reports, but we don't care much about them for now lol.

The Actor has to obligatory produce something to prove their case, based on evidence

**Subscriptions** -> Signatures synonym

**Private writing** -> a writing that has at least a subscription and a date. It's necessary for sustaining a case, we're talking 1942, its relation with files and non-existent files is kinda meh

**Electronic signature** -> data associated with other data

an **Informatic Document** (in CAD) can be have
- no signature
- Simple electronic signature (FES "Firma Elettronica Semplice")
- Advanced electronic signature (FEA "Firma Elettronica Avanzata") -> signature done with an authentication method
- Qualified signature (FQ "Firma qualificata / digitale") -> criptografy RSA
$$Documents\Bigg ( FES \bigg ( FEA \Big ( FQ \Big ) \bigg )  \Bigg)$$
they're all nested sets
## Criminal investigations
the most basic positions are:
- **the first responder** -> they secure what may be a chaotic scene, understand what happened, trying to identify victims, witnesses, suspects.
- **the investigator** -> will respond to the scene after request from the responder, they'll coordinate and share information.
- **crime scene technician** -> specialized training in the collection of evidence, preserving evidence and starting the chain of custody.

Email is one of the easiest ways to share information trough files between two or more people.
the email address does not automatically point to a specific user

(Here there are some examples of crimes, but they don't seem important to the study of the course, just informative,, so i skipped them)

**Criminal Conspiracy** -> when two or more people agree to commit a illegal act

The **Internet of Things** -> anything that has an app (Alexa, smartwatches, Siri, whatever connects to internet) might contain evidence and show the criminals' intent to commit the crime. Missing the digital devices can result in significant damage in investigations.

Social media is a source of digital evidence for showing conspiracy. There could be a Facebook page with photo of an evidence (ofc it happened)

## Corporate (Civil) investigations

Private accords (privacy policies) -> used by one part to get access from the devices
in other words: "i'll give you the company's PC, Phone etc. and i retain the right to access the devices and check for whatever i need"

**Policy** -> statement from the organization addressing a specific issue
**Procedure** -> the specific instructions regarding how to accomplish the goals of the policy

Policies should be simple to understand.
Procedures should specify all the steps needed to implement the task outlined in the policy.
Policies and procedures are below the law

The organization must enforce the policies, and there must be documentation that employee knew and understood the policies.

Passepartouts of any kind are always insecure, since a leak will sooner or later occur

## Pre-Investigation consideration

**Pre-Investigation consideration** -> Phase where you determine the <u>capabilities and equipment</u> specifications to conduct a forensic exam, regardless of whether it is in the field or a lab environment

Tech changes, methods of hiding data or conducting criminal activities, we need to adjust.

**Drive blocker** -> blocks modifications on devices (so we can make the acquisition without modifying anything)

==forensic workstation hardware==
- RAM -> Them more the merrier
- SSD drives -> size and number both matter, 5 disks for
	- Operating system drive
	- Evidence/data storage
	- Database storage
	- Processing drive storage
- Processor -> i9 is the least
- OS -> Windows, our only option B,)
They're not cheap, software is expensive too

**Response kit** -> equipment that contains everything you need to collect digital evidence
- Digital camera, capable of still and video recording, removable card
- Latex gloves
- Notepads (digital / pen & paper)
- Organizational paperwork (checklists)
- Paper storage bags/antistatic bags
- Storage media
- Write blocking devices -> blocks all writing ops from drives, eg Tableau TK8u USB 3.0 frensic bridge, the one we have and will use
- frequency shielding material
- toolkit (screwdrivers, piches etc)
- miscellaneous items
- forensic laptop
- hardware and software duplicator
- encryption
- software security keys (dongles)
- pelican case (the type of hard case, pelican is just a reference mark)

==Forensic software==
Open source tools are a choice and are a good one.
Tho it has some problems that fully licensed software doesn't have, so we use FOSS when we can, but sometimes it's not possible mainly for stability reasons.
- FOSS used for educational, profit, testing purposes
- ✅ Available at no cost in most situations
- ❌ Little or no technical support if something goes wrong
Commercial tool
- ✅ Better customer support
- ✅ Documentation
- ✅ Timely updates
- ❌ you have to pay lol

The important thing is to **validate** the results provided by any tool.
We need to **explain in the administrative/juridical process** whether the tool we used produces reliable results and is accepted within the forensics community.

Requirements (by the US court)
- theory or technique **can be or has been tested**
- it has been subjected to **peer review and publication**
- known or potential **error rate**
- existence and maintenance of **standards**
- acceptance within the **scientific community**
## Understanding case information and legal issues
As a government and corporate digital forensic investigator, *i have had limits* on what i can search for or view on digital devices many times

There will be times when you have been presented the digital evidence *after someone else collected it*
You must ask questions and the source of your answers may only come from <u>investigative reports</u>

**Temporal mark** -> guarantees *when* the document was signed

==Understanding data acquisition==
multiple scenarios when someone calls you to acquire data
- Potential evidence in <u>volatile memory</u>, but it's not always possible to collect volatile data
- During a destructive process running on the machine, you may not want to take the time to collect the RAM as evidence it's being manipulated (as some devices can have such processes triggering when some conditions meet)
**Chain of custody** -> documents all access to the evidence, who accessed it, when it was accessed and what purpose it was accessed
- *Maintaining the chain of custody* is an integral part of preserving and authenticating physical and digital evidence for an administrative of judicial proceeding.
- Check that your given devices are exactly like it's claimed they are in the papers
- **Evidence chain of custody tracking form** -> form to track all the info regarding the acquired evidence (self explanatory)
	- Evidence has to have an id, usually something like `HDD001` for example
	- Id has to be written with a permanent marker on the evidence
Evidence must be analized "post mortem" (we can't boot it since it will be altered)
Three choices for making a working copy
- **forensic copy** -> bit-for-bit copy of the source to the destination (not common)
- **forensic image** -> bit-for-bit copy of the source device, stored in a forensic image format
- **logical forensic image** -> selected folders/files in a forensic image

==Dates and time zones== -> setting the forensic machine and tools to use universal time (UTC) is a standard frame of reference, since the suspect may have changed the time zone settings on their device

**Hash analysis** -> analysis of the digital fingerprint for a file or piece of digital media (generated using a one-way cryptographic algorithm)

if the OG file hash is the same as the acquisition, we don't need the original anymore

**File signature** -> get identified in the file system trough an unique signature

file extensions can be changed as they're not part of the digital signature. Software have methods to find the original file extension in case it does not correspond to the actual type of the file. There's also [filesignatures.net] as a DB we can consult to get the original file extension

==Antivirus==
Antiviruses can change the metadata of all the files in the disk.
Use a different boot than the acquired one in the disk as it prevents dynamic operations that the antivirus on the original boot could do.

The acquired drive might have a virus and thus the place where we access the drive must be protected by an antivirus too.

"A virus did it" -> verify whether that is a valid claim

==Reporting your findings==
- Explain to a non-technical person our findings
- Say what you find precisely, do not assume anything
	example: you see a black sheep while passing by in a train
	- ❌ all sheeps are black
	- ❌ at least 1 sheep is black
	- ✅ at least that side of the sheep is black
- Notes add details to explain technical stuff *(eg. what an Hash is)*

> [!notes] ==Details to include in your report==
> - Communication between primary investigator and prosecutor
> - Condition of the evidence containers
> - Specifics of the storage device (make, model, serial, condition)
> - Personal identifiers of suspect, victim, witness
> - Forensic hardware/software used
> - What you examined
> - What you found



## 
##

