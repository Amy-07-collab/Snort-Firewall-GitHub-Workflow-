# Findings and Analysis

## 1. IDS Detection

Snort was used to monitor traffic and generate alerts when traffic matched configured IDS signatures.

### Observed Alert

```text
[**] [1:1000003:0] Malicious Server Hit! [**]
{TCP} 209.165.200.235:34484 -> 209.165.202.133:6666
```

### Interpretation

| Field | Value |
|---|---|
| Protocol | TCP |
| Source IP | 209.165.200.235 |
| Source Port | 34484 |
| Destination IP | 209.165.202.133 |
| Destination Port | 6666 |
| Signature | Malicious Server Hit! |

---

## 2. Firewall Response

The malicious server was blocked using:

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

This targets TCP traffic destined for the identified server on port 6666.

---

## 3. Before vs After

### Before Firewall Rule

The test download was able to connect to the server.

### After Firewall Rule

The connection timed out.

### Security Workflow

```text
Traffic
  ↓
Snort inspection
  ↓
Alert
  ↓
Identify malicious destination
  ↓
iptables FORWARD rule
  ↓
DROP
  ↓
Connection blocked
```

---

## 4. Analyst Takeaway

This exercise demonstrates how security monitoring and network enforcement can work together:

**Detection → Investigation → Response → Verification**

The IDS identifies suspicious activity, while the firewall can be configured to prevent subsequent traffic to the identified destination.
