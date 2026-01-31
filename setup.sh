#!/bin/bash

# PIXLL GitHub Pages Deployment Fix
# Run this script in your local repository directory

echo "🔧 Setting up PIXLL for GitHub Pages deployment..."
echo ""

# Check if we're in the right directory
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository. Please cd into your pxl directory first."
    exit 1
fi

echo "✅ Step 1: Creating project structure..."

# Create directories
mkdir -p src
mkdir -p .github/workflows

echo "✅ Step 2: Moving and renaming files..."

# If the old file exists, rename it
if [ -f "pixll (3).jsx" ]; then
    echo "   Moving 'pixll (3).jsx' to 'src/App.jsx'"
    mv "pixll (3).jsx" src/App.jsx
elif [ -f "pixll__3_.jsx" ]; then
    echo "   Moving 'pixll__3_.jsx' to 'src/App.jsx'"
    mv "pixll__3_.jsx" src/App.jsx
else
    echo "   ⚠️  Original JSX file not found. Make sure App.jsx is in src/"
fi

echo "✅ Step 3: Configuration files are ready"
echo "   (Assuming you've copied the provided config files)"

echo ""
echo "✅ Step 4: Installing dependencies..."
npm install

echo ""
echo "✅ Step 5: Testing local build..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed. Check error messages above."
    exit 1
fi

echo ""
echo "✅ Step 6: Preview production build (optional)..."
echo "   Run 'npm run preview' to test locally"
echo ""

echo "📝 Step 7: Commit and push changes"
echo ""
echo "Run these commands:"
echo ""
echo "  git add ."
echo "  git commit -m 'Fix: Configure Vite for GitHub Pages deployment'"
echo "  git push origin main"
echo ""
echo "🔧 Step 8: Configure GitHub Pages"
echo ""
echo "1. Go to: https://github.com/jash9642-afk/pxl/settings/pages"
echo "2. Under 'Source', select: GitHub Actions"
echo "3. Save"
echo ""
echo "✨ Your site will be live at: https://jash9642-afk.github.io/pxl/"
echo ""
echo "⏱️  Deployment takes ~1-2 minutes after pushing"
echo ""
