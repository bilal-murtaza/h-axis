# DNS Configuration for axis.easyapps.io

To fix the "InvalidDNSError" and properly configure your custom domain `axis.easyapps.io` for GitHub Pages, you need to set up the correct DNS records.

## Required DNS Records

You need to configure **one** of the following options in your DNS provider:

### Option 1: CNAME Record (Recommended for subdomains)

```
Type: CNAME
Name: axis (or axis.easyapps.io)
Value: bilal-murtaza.github.io
TTL: 3600 (or Auto)
```

### Option 2: A Records (For apex domains)

If you want to use the apex domain (easyapps.io), use these A records:

```
Type: A
Name: @ (or leave blank for root domain)
Value: 185.199.108.153
TTL: 3600

Type: A
Name: @ (or leave blank for root domain)
Value: 185.199.109.153
TTL: 3600

Type: A
Name: @ (or leave blank for root domain)
Value: 185.199.110.153
TTL: 3600

Type: A
Name: @ (or leave blank for root domain)
Value: 185.199.111.153
TTL: 3600
```

## Step-by-Step Setup

### 1. Configure DNS Records

Log into your DNS provider (where easyapps.io is registered) and add the CNAME record:

- **Type**: CNAME
- **Name**: axis
- **Value**: bilal-murtaza.github.io
- **TTL**: 3600 or Auto

### 2. Verify DNS Propagation

After adding the DNS records, verify they're working:

```bash
# Check CNAME record
dig axis.easyapps.io CNAME

# Check if it resolves to GitHub's IPs
nslookup axis.easyapps.io
```

### 3. Configure GitHub Pages

1. Go to your repository: https://github.com/bilal-murtaza/h-axis
2. Navigate to Settings → Pages
3. Under "Custom domain", enter: `axis.easyapps.io`
4. Check "Enforce HTTPS" (after DNS propagates)

### 4. Deploy with CNAME

Build and deploy your site (the CNAME file will be automatically created):

```bash
./build-static.sh
```

## Troubleshooting

### DNS Propagation Time

- DNS changes can take up to 24-48 hours to fully propagate
- Use online DNS checker tools to verify propagation

### Common Issues

1. **Subdomain vs Apex Domain**
    - `axis.easyapps.io` = subdomain (use CNAME)
    - `easyapps.io` = apex domain (use A records)

2. **TTL (Time To Live)**
    - Lower TTL (300-3600) for faster updates during setup
    - Higher TTL (86400) for stable production

3. **DNS Provider Specific**
    - Some providers require different formats
    - Cloudflare: Use "axis" as name, not "axis.easyapps.io"
    - Others: May require full domain name

### Verification Commands

```bash
# Check if CNAME exists
dig axis.easyapps.io CNAME

# Check what IP it resolves to
dig axis.easyapps.io A

# Trace DNS resolution
dig axis.easyapps.io +trace
```

### Expected Results

After correct configuration:

```bash
$ dig axis.easyapps.io CNAME
axis.easyapps.io.    3600    IN    CNAME    bilal-murtaza.github.io.

$ dig axis.easyapps.io A
axis.easyapps.io.    3600    IN    A    185.199.108.153
axis.easyapps.io.    3600    IN    A    185.199.109.153
axis.easyapps.io.    3600    IN    A    185.199.110.153
axis.easyapps.io.    3600    IN    A    185.199.111.153
```

## Alternative: Use GitHub's Default Domain

If DNS configuration is problematic, you can always use GitHub's default domain:

- https://bilal-murtaza.github.io/h-axis/

Just update the base path in `vite.static.config.mts`:

```js
base: '/h-axis/', // For repository pages
```
