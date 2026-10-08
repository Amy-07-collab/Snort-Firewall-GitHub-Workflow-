# Snort and Firewall Rules Lab

A GitHub documentation project for the **Snort and Firewall Rules** CyberOps lab.

## Lab Overview

This lab focuses on:

- Preparing the CyberOps Workstation virtual environment
- Starting a Mininet topology
- Running Snort as an intrusion detection system (IDS)
- Monitoring `/var/log/snort/alert`
- Simulating a malicious web server
- Capturing traffic with `tcpdump`
- Understanding IDS alerts
- Inspecting firewall chains with `iptables`
- Adding a blocking rule to the `FORWARD` chain
- Verifying that the malicious-server connection is blocked
- Terminating and cleaning up the Mininet environment

> **Source:** Cisco Networking Academy, *Lab - Snort and Firewall Rules*.

## Lab Environment

| Item | Details |
|---|---|
| VM | CyberOps Workstation |
| Virtualization | Oracle VirtualBox |
| Network | Bridged Adapter (or NAT when required by the lab environment) |
| Network simulator | Mininet |
| IDS | Snort |
| Firewall | iptables |
| Packet capture | tcpdump |
| Main simulated devices | R1, H1–H11 |

## Repository Structure

```text
snort-firewall-lab/
├── README.md
├── LAB-NOTES.md
├── COMMANDS.md
├── FINDINGS.md
├── TROUBLESHOOTING.md
├── screenshots/
│   ├── README.md
│   ├── 01-vm-network.png
│   ├── 02-dhcp-ip.png
│   ├── 03-mininet-started.png
│   ├── 04-snort-running.png
│   ├── 05-malware-server.png
│   ├── 06-snort-alert.png
│   ├── 07-tcpdump-capture.png
│   ├── 08-pcap-file.png
│   ├── 09-iptables-before.png
│   ├── 10-iptables-block-rule.png
│   ├── 11-blocked-download.png
│   └── 12-mininet-cleanup.png
└── docs/
    └── lab-source.md
```

## Objectives

1. Prepare the virtual environment.
2. Observe firewall and IDS logs.
3. Use a Snort alert to identify suspicious traffic.
4. Capture the traffic in a PCAP file.
5. Tune an `iptables` firewall rule based on the IDS alert.
6. Verify that the malicious-server connection is blocked.
7. Terminate and clean up Mininet.

## Key Security Concepts

### IDS

Snort inspects traffic and compares traffic against configured signatures. In this lab, the malicious download triggers a Snort alert.

### Firewall

The lab uses `iptables` to filter traffic. Traffic passing through R1 is handled by the `FORWARD` chain.

### Detection → Response

The central workflow demonstrated by this lab is:

```text
Suspicious traffic
       ↓
     Snort
       ↓
   IDS alert
       ↓
Identify source/destination
       ↓
Create firewall rule
       ↓
     iptables
       ↓
Traffic blocked
```

## Important Lab Values

The lab uses the following malicious-server destination:

- Destination IPv4: `209.165.202.133`
- Destination TCP port: `6666`
- File: `W32.Nimda.Amm.exe`
- Firewall chain: `FORWARD`
- Firewall action: `DROP`

The lab's example Snort alert shows traffic from `209.165.200.235:34484` to `209.165.202.133:6666`.

## Evidence

Screenshots belong in the `screenshots/` folder. Use the filenames provided in `screenshots/README.md` so the documentation remains organized.

## Completion Checklist

- [ ] CyberOps VM network configured
- [ ] IP address verified
- [ ] Internet connectivity tested
- [ ] Mininet started
- [ ] R1 terminal opened
- [ ] Snort started
- [ ] H5 and H10 terminals opened
- [ ] Malware server started on H10
- [ ] Port 6666 verified
- [ ] Snort alert observed
- [ ] Source/destination information documented
- [ ] tcpdump capture created
- [ ] PCAP file verified
- [ ] iptables chains inspected
- [ ] FORWARD DROP rule added
- [ ] Malicious download blocked
- [ ] Mininet terminated
- [ ] `sudo mn -c` cleanup completed

## GitHub Documentation Workflow

After completing the lab:

```bash
git status
git add .
git commit -m "Document Snort and firewall rules lab"
git push origin main
```

See `LAB-NOTES.md` for the detailed documentation template.
