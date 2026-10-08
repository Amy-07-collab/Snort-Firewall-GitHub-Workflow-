# Troubleshooting

## VM Memory Error

The lab notes that the CyberOps Workstation VM may require additional memory when running commands.

If a memory error occurs:

1. Stop or exit the affected step.
2. Open the VM settings.
3. Increase the VM memory.
4. The lab notes that the default is 1 GB and suggests trying 2 GB.

---

## Snort Stops Running

If Snort stops and the shell prompt returns, restart it:

```bash
./lab.support.files/scripts/start_snort.sh
```

Snort needs to be running so alerts can be captured.

---

## No Snort Alerts

Check:

```bash
tail -f /var/log/snort/alert
```

Then repeat the test download from H5.

---

## PCAP Not Created

Start tcpdump in the background:

```bash
tcpdump -i H5-eth0 -w nimda.download.pcap &
```

Repeat the download, then stop tcpdump:

```bash
fg
```

Press:

```text
Ctrl+C
```

Verify:

```bash
ls -l nimda.download.pcap
```

---

## Firewall Rule Not Present

Check:

```bash
iptables -L -v
```

Re-add the lab rule if necessary:

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

---

## Mininet Cleanup

After quitting Mininet:

```bash
sudo mn -c
```

Enter the required password when prompted.
