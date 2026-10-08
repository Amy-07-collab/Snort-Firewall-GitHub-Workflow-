# Command Reference

## Virtual Environment

```bash
sudo ./lab.support.files/scripts/configure_as_dhcp.sh
```

```bash
ifconfig
```

```bash
ping www.cisco.com
```

## Mininet

```bash
sudo ./lab.support.files/scripts/cyberops_extended_topo_no_fw.py
```

```text
mininet> xterm R1
mininet> xterm H5
mininet> xterm H10
```

## Snort

```bash
./lab.support.files/scripts/start_snort.sh
```

```bash
tail -f /var/log/snort/alert
```

## Malware Server Simulation

```bash
./lab.support.files/scripts/mal_server_start.sh
```

```bash
netstat -tunpa
```

## Test Download

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
```

## Packet Capture

```bash
tcpdump -i H5-eth0 -w nimda.download.pcap &
```

```bash
fg
```

```bash
ls -l
```

## Firewall

```bash
iptables -L -v
```

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

## Cleanup

```text
quit
```

```bash
sudo mn -c
```

## Git Bash — Push to GitHub

From the repository directory:

```bash
git init
git branch -M main
git add .
git commit -m "Document Snort and firewall rules lab"
git remote add origin https://github.com/YOUR-USERNAME/snort-firewall-lab.git
git push -u origin main
```

For an existing repository:

```bash
git add .
git commit -m "Update Snort and firewall lab documentation"
git push
```
