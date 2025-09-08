# DNS Configuration for axis.easyapps.io with Cloudflare

To fix the HTTPS issue and properly configure your custom domain `axis.easyapps.io` for GitHub Pages with Cloudflare, you need to set up the correct DNS records and SSL settings.

## Required Cloudflare Configuration

### Step 1: DNS Records in Cloudflare

1. **Log into Cloudflare Dashboard**
2. **Select your domain**: `easyapps.io`
3. **Go to DNS > Records**
4. **Add/Edit CNAME Record**:

```
Type: CNAME
Name: axis
Target: bilal-murtaza.github.io
Proxy status: DNS only (Gray cloud) ⚠️ IMPORTANT
TTL: Auto
```

**Critical**: The proxy status MUST be "DNS only" (gray cloud), NOT "Proxied" (orange cloud). GitHub Pages requires direct access to handle SSL certificates.

### Step 2: SSL/TLS Settings in Cloudflare

1. **Go to SSL/TLS > Overview**
2. **Set SSL/TLS encryption mode to**: `Full` or `Full (strict)`
3. **Go to SSL/TLS > Edge Certificates**
4. **Ensure these settings**:
    - Always Use HTTPS: `On`
    - HTTP Strict Transport Security (HSTS): `Enabled`
    - Minimum TLS Version: `1.2`

### Step 3: Verify Cloudflare DNS Propagation

After configuring DNS records, verify they're working:

```bash
# Check CNAME record (should show bilal-murtaza.github.io)
dig axis.easyapps.io CNAME

# Check if it resolves to GitHub's IPs
nslookup axis.easyapps.io

# Verify it's not proxied through Cloudflare
dig axis.easyapps.io A
# Should return GitHub's IPs: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
```

### Step 4: Configure GitHub Pages

1. Go to your repository: https://github.com/bilal-murtaza/h-axis
2. Navigate to Settings → Pages
3. Under "Custom domain", enter: `axis.easyapps.io`
4. **Wait for DNS check to pass** (green checkmark)
5. **Then** check "Enforce HTTPS"

### Step 5: Deploy with CNAME

Build and deploy your site:

```bash
./build-static.sh
```

## Cloudflare-Specific Troubleshooting

### Common Cloudflare Issues with GitHub Pages

1. **Orange Cloud (Proxied) - MOST COMMON ISSUE**
    - ❌ Problem: CNAME record is proxied (orange cloud)
    - ✅ Solution: Set to "DNS only" (gray cloud)
    - Why: GitHub Pages needs direct access to generate SSL certificates

2. **SSL/TLS Mode Issues**
    - ❌ Problem: SSL mode set to "Flexible"
    - ✅ Solution: Use "Full" or "Full (strict)"
    - Why: Prevents SSL errors and mixed content issues

3. **Page Rules Conflicts**
    - Check if you have Page Rules that might interfere
    - Ensure no redirects or cache rules conflict with GitHub Pages

### Expected Cloudflare DNS Results

After correct configuration:

```bash
$ dig axis.easyapps.io CNAME
axis.easyapps.io.    300    IN    CNAME    bilal-murtaza.github.io.

$ dig axis.easyapps.io A
axis.easyapps.io.    300    IN    A    185.199.108.153
axis.easyapps.io.    300    IN    A    185.199.109.153
axis.easyapps.io.    300    IN    A    185.199.110.153
axis.easyapps.io.    300    IN    A    185.199.111.153
```

### Cloudflare Dashboard Checklist

- [ ] CNAME record: `axis` → `bilal-murtaza.github.io`
- [ ] Proxy status: **DNS only** (gray cloud)
- [ ] SSL/TLS mode: **Full** or **Full (strict)**
- [ ] Always Use HTTPS: **On**
- [ ] No conflicting Page Rules
- [ ] No conflicting Firewall Rules

## Quick Fix Summary

**The most likely cause of your HTTPS issue is that your CNAME record in Cloudflare is set to "Proxied" (orange cloud). Here's the quick fix:**

1. **Log into Cloudflare Dashboard**
2. **Go to DNS > Records**
3. **Find your CNAME record**: `axis` → `bilal-murtaza.github.io`
4. **Click the orange cloud** to turn it **gray** (DNS only)
5. **Wait 5-10 minutes** for propagation
6. **Go back to GitHub Pages Settings** and try enabling HTTPS again

## Why This Matters

- **Orange Cloud (Proxied)**: Traffic goes through Cloudflare's servers, GitHub Pages can't generate SSL certificates
- **Gray Cloud (DNS only)**: Direct connection to GitHub Pages, allows proper HTTPS setup

## Alternative: Use GitHub's Default Domain

If DNS configuration is problematic, you can always use GitHub's default domain:

- https://bilal-murtaza.github.io/h-axis/

Just update the base path in `vite.static.config.mts`:

```js
base: '/h-axis/', // For repository pages
```
