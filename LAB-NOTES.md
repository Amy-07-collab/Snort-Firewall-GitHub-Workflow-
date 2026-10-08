# Lab Notes — Snort and Firewall Rules

## 1. Lab Information

**Lab:** Snort and Firewall Rules  
**Platform:** CyberOps Workstation  
**Tools:** Mininet, Snort, iptables, tcpdump  
**Date completed:** `YYYY-MM-DD`

---

## 2. Part 1 — Preparing the Virtual Environment

### Step 1: Configure VM Networking

The lab instructs the CyberOps Workstation VM to use a Bridged Adapter when necessary. NAT may be required when using WiFi with a proxy.

**Command used:**

```bash
sudo ./lab.support.files/scripts/configure_as_dhcp.sh
```

### Evidence

Screenshot:

```text
screenshots/01-vm-network.png
screenshots/02-dhcp-ip.png
```

### Result

Record the interface and IP address obtained:

```text
Interface:
IPv4 address:
```

### Connectivity Test

```bash
ping www.cisco.com
```

**Result:**

```text
Packets transmitted:
Packets received:
Packet loss:
```

---

# 3. Part 2 — Firewall and IDS Logs

## Step 1: Start Mininet

```bash
sudo ./lab.support.files/scripts/cyberops_extended_topo_no_fw.py
```

Expected topology output includes:

```text
R1 R4 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11
```

### Evidence

`screenshots/03-mininet-started.png`

---

## Step 2: Open R1

```text
mininet> xterm R1
```

### Question

**What user is logged into the R1 shell? What is the indicator?**

**Answer:**

```text
User:
Indicator:
```

### Evidence

`screenshots/04-r1-shell.png`

---

## Step 3: Start Snort

From R1:

```bash
./lab.support.files/scripts/start_snort.sh
```

Expected output includes:

```text
Running in IDS mode
--== Initializing Snort ==--
Parsing Rules file "/etc/snort/snort.conf"
```

### Evidence

`screenshots/04-snort-running.png`

---

## Step 4: Start the Malware Server

Open H5 and H10:

```text
mininet> xterm H5
mininet> xterm H10
```

On H10:

```bash
./lab.support.files/scripts/mal_server_start.sh
```

Verify the server:

```bash
netstat -tunpa
```

The lab demonstrates nginx listening on:

```text
TCP 6666
```

### Evidence

`screenshots/05-malware-server.png`

---

## Step 5: Monitor Snort Alerts

On another R1 terminal:

```bash
tail -f /var/log/snort/alert
```

This terminal displays alerts as they occur.

### Evidence

`screenshots/06-snort-alert.png`

---

## Step 6: Download the Test File

From H5:

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
```

### Questions

**What port is used when communicating with the malware web server?**

```text
Answer:
```

**Was the file completely downloaded?**

```text
Answer:
```

**Did the IDS generate an alert?**

```text
Answer:
```

---

## Step 7: Document the Snort Alert

Example alert from the lab:

```text
04/28-17:00:04.092153 [**] [1:1000003:0] Malicious Server Hit! [**] [Priority: 0]
{TCP} 209.165.200.235:34484 -> 209.165.202.133:6666
```

### Questions

**Source IPv4:**

```text
Your result:
```

**Destination IPv4:**

```text
Your result:
```

**Source port:**

```text
Your result:
```

**Destination port:**

```text
Your result:
```

**Timestamp:**

```text
Your result:
```

**IDS signature message:**

```text
Your result:
```

---

# 4. Packet Capture

## Start tcpdump

On H5:

```bash
tcpdump -i H5-eth0 -w nimda.download.pcap &
```

Then repeat the download:

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
```

Stop tcpdump:

```bash
fg
```

Then:

```text
Ctrl+C
```

### Evidence

`screenshots/07-tcpdump-capture.png`

---

## Verify PCAP

```bash
ls -l
```

Confirm that:

```text
nimda.download.pcap
```

exists and has a size greater than zero.

### Evidence

`screenshots/08-pcap-file.png`

### Security Analyst Use

**How can the PCAP file be useful to a security analyst?**

```text
Your answer:

The PCAP can be retained as packet-level evidence for later traffic analysis,
investigation, and validation of what occurred during the event.
```

> The source lab states that PCAP analysis is performed in another lab.

---

# 5. Step 2 — Tuning Firewall Rules Based on IDS Alerts

## Inspect Existing iptables Rules

Open another R1 terminal:

```text
mininet> xterm R1
```

Run:

```bash
iptables -L -v
```

### Evidence

`screenshots/09-iptables-before.png`

### Question

**What chains are currently in use by R1?**

```text
Answer:
INPUT
FORWARD
OUTPUT
```

---

## Add the Blocking Rule

The lab uses:

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

### Rule Breakdown

| Option | Meaning |
|---|---|
| `-I FORWARD` | Insert the rule into the FORWARD chain |
| `-p tcp` | Match TCP traffic |
| `-d 209.165.202.133` | Match the destination IP |
| `--dport 6666` | Match destination TCP port 6666 |
| `-j DROP` | Drop matching packets |

### Evidence

`screenshots/10-iptables-block-rule.png`

---

## Verify the Rule

```bash
iptables -L -v
```

Expected rule structure:

```text
DROP tcp -- anywhere 209.165.202.133
tcp dpt:6666
```

Record your actual packet/byte counters:

```text
Packets:
Bytes:
```

---

# 6. Verify the Firewall Block

From H5:

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
```

The lab demonstrates a connection timeout after the firewall rule is applied.

### Evidence

`screenshots/11-blocked-download.png`

### Question

**Was the download successful this time? Explain.**

```text
Your answer:
```

### Question

**What would be a more aggressive but also valid approach when blocking the offending server?**

```text
Your answer:
```

---

# 7. Part 3 — Terminate and Clear Mininet

Return to the terminal used to start Mininet.

At the Mininet prompt:

```text
quit
```

Then clean up:

```bash
sudo mn -c
```

### Evidence

`screenshots/12-mininet-cleanup.png`

---

# 8. Final Findings

## Detection

Snort detected traffic matching a configured signature during the simulated malicious-file download.

## Evidence

The alert provided information including:

- Timestamp
- Protocol
- Source IPv4 address
- Source port
- Destination IPv4 address
- Destination port
- IDS signature message

## Response

The identified destination was blocked with an `iptables` rule in the `FORWARD` chain.

## Verification

The subsequent download attempt timed out, demonstrating that the firewall rule prevented the connection from succeeding.

## Lessons Learned

1. IDS alerts provide useful evidence about suspicious network activity.
2. Packet captures preserve traffic for later investigation.
3. Firewall rules can be tuned based on intelligence obtained from IDS alerts.
4. The `FORWARD` chain is relevant when R1 is routing traffic between other hosts.
5. Documentation and screenshots provide evidence that each lab stage was completed.
