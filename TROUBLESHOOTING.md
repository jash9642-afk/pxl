# 🆘 TROUBLESHOOTING GUIDE

## Common GitHub Pages Deployment Issues

### 🔴 Issue 1: Blank White Screen

**Symptoms:**
- Page loads but shows nothing
- Console shows 404 errors for assets

**Root Cause:**
- Incorrect `base` path in `vite.config.js`

**Fix:**
```javascript
// vite.config.js
export default defineConfig({
  plugins: [react()],
  base: '/pxl/',  // ← Must match repo name exactly
})
```

**Verify:**
1. Open browser DevTools (F12)
2. Check Network tab
3. All assets should load from `/pxl/assets/...`
4. If you see `/assets/...` (without /pxl/), the base path is wrong

---

### 🔴 Issue 2: 404 Page Not Found

**Symptoms:**
- `https://jash9642-afk.github.io/pxl/` shows GitHub 404 page

**Root Cause:**
- GitHub Actions didn't run successfully
- OR Pages is configured to wrong source

**Fix:**
1. Check GitHub Actions:
   - Go to: `https://github.com/jash9642-afk/pxl/actions`
   - Latest workflow should be green ✓
   - If red ✗, click it to see error logs

2. Check Pages Settings:
   - Go to: `https://github.com/jash9642-afk/pxl/settings/pages`
   - Source must be: **"GitHub Actions"** (NOT "Deploy from a branch")

---

### 🔴 Issue 3: Build Fails in GitHub Actions

**Symptoms:**
- GitHub Actions workflow shows red ✗
- Error in "Install dependencies" or "Build" step

**Common Errors & Fixes:**

#### Error: "Cannot find module 'react'"
```bash
# Fix: Ensure package.json has correct dependencies
npm install react react-dom recharts
```

#### Error: "Failed to resolve entry for package"
```bash
# Fix: Check that main.jsx exists and index.html points to it correctly
```

#### Error: "Module not found: Can't resolve './App.jsx'"
```bash
# Fix: Ensure App.jsx is in src/ directory
# Check import statement in main.jsx matches filename exactly
```

---

### 🔴 Issue 4: React Components Not Rendering

**Symptoms:**
- Page loads, no console errors
- But UI doesn't appear

**Root Cause:**
- Missing React DOM mounting
- Incorrect export in App.jsx

**Fix:**

Check `src/main.jsx`:
```javascript
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'

// Must create root and render
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
```

Check `src/App.jsx`:
```javascript
// Must have default export
export default function Pixll() {
  // ... component code ...
}
```

---

### 🔴 Issue 5: Styles Not Loading

**Symptoms:**
- Content shows but no styling
- Colors, fonts, layouts broken

**Root Cause:**
- External fonts not loading
- Inline styles missing

**Fix:**

Your App.jsx already has inline styles, but check the Google Fonts link:
```javascript
// In your component
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
```

---

### 🔴 Issue 6: "Permission denied" During Deployment

**Symptoms:**
- GitHub Actions fails with permission error

**Root Cause:**
- Workflow doesn't have required permissions

**Fix:**

Ensure `.github/workflows/deploy.yml` has:
```yaml
permissions:
  contents: read
  pages: write
  id-token: write
```

---

## 🔍 Debugging Checklist

Before asking for help, verify:

- [ ] `vite.config.js` exists with `base: '/pxl/'`
- [ ] `package.json` has all dependencies
- [ ] `index.html` exists in root
- [ ] `src/main.jsx` exists
- [ ] `src/App.jsx` exists (renamed from pixll (3).jsx)
- [ ] `.github/workflows/deploy.yml` exists
- [ ] GitHub Actions workflow ran successfully (green ✓)
- [ ] GitHub Pages source set to "GitHub Actions"
- [ ] Waited 1-2 minutes after successful deployment

---

## 🧪 Local Testing

Test locally before deploying:

```bash
# Development mode
npm run dev
# Visit: http://localhost:5173

# Production build test
npm run build
npm run preview
# Visit: http://localhost:4173
```

If it works locally but fails on GitHub Pages → Issue is with base path or deployment config

---

## 📊 Expected File Structure

```
pxl/
├── .github/
│   └── workflows/
│       └── deploy.yml       ✓
├── src/
│   ├── App.jsx              ✓ (your main component)
│   └── main.jsx             ✓
├── index.html               ✓
├── package.json             ✓
├── vite.config.js           ✓ (with base: '/pxl/')
├── .gitignore               ✓
└── README.md                ✓
```

---

## 🔗 Useful Links

- Your Repository: https://github.com/jash9642-afk/pxl
- GitHub Actions: https://github.com/jash9642-afk/pxl/actions
- Pages Settings: https://github.com/jash9642-afk/pxl/settings/pages
- Live Site: https://jash9642-afk.github.io/pxl/

---

## 💡 Still Stuck?

1. Check browser console (F12 → Console tab)
2. Check GitHub Actions logs
3. Compare your files with the provided templates
4. Ensure ALL config files are in place

Most issues are caused by:
- Wrong base path (90% of cases)
- Missing configuration file (5%)
- GitHub Pages not set to Actions source (5%)
