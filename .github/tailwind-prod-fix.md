# Tailwind Production Styles Fix

**Date:** November 27, 2025

## Problem

Styles were not appearing in the application after running `assets:precompile`. The Tailwind CSS bundle was being generated but was missing color utilities like `bg-gray-900` and `text-white` that were used in `app/views/layouts/application.html.erb`.

### Symptoms
- Tailwind CSS file generated: `public/assets/tailwind-bed2f6dcd27b69a486e48fdc6a9fda4cd43aa83f433ea3a753a44f476debcf66.css`
- File contained only base layer and minimal utilities (no color utilities)
- Layout HTML includes: `class="bg-gray-900 text-white"` but styles were purged from CSS

## Root Cause

Tailwind's content purging was too aggressive. The original `content` glob patterns in `config/tailwind.config.js` may not have been matching all files where Tailwind classes were used, causing those utilities to be removed during the build process.

Original content configuration:
```javascript
content: [
  './public/*.html',
  './app/helpers/**/*.rb',
  './app/javascript/**/*.js',
  './app/views/**/*.{erb,haml,html,slim}'
]
```

## Solutions Applied

### 1. Updated Content Globs (config/tailwind.config.js)

Expanded the `content` array to be more comprehensive and catch all potential class definitions:

```javascript
content: [
  "./app/views/**/*.html.erb",
  "./app/helpers/**/*.rb",
  "./app/assets/stylesheets/**/*.css",
  "./app/javascript/**/*.js",
  "./app/components/**/*.{rb,erb}",  // if using ViewComponents
  "./app/**/*.html.erb",             // catches everything reliably
]
```

**Why this helps:**
- More explicit `.html.erb` patterns
- Includes stylesheets directory (CSS can contain Tailwind directives)
- Covers ViewComponents usage
- Catch-all `./app/**/*.html.erb` pattern ensures nothing is missed

### 2. Added Safelist (config/tailwind.config.js)

Added a safelist pattern to force Tailwind to preserve common color utilities even if content scanning misses them:

```javascript
safelist: [
  // preserve commonly used color utilities that may be generated dynamically
  { pattern: /^(bg|text|border)-(?:darkBg|darkAccent|gray|blue|white|red|green)(?:-(?:50|100|200|300|400|500|600|700|800|900))?$/ },
]
```

**Why this helps:**
- Acts as a safety net for utilities that might be dynamically generated
- Ensures core color utilities are never purged
- Covers standard color scales (50–900) for bg, text, and border utilities
- Includes custom colors (darkBg, darkAccent) used in the project

## Implementation Steps

### Step 1: Update Tailwind Config
Modified `config/tailwind.config.js` with expanded content globs and safelist.

### Step 2: Rebuild Assets
```bash
SECRET_KEY_BASE=$(bin/rails secret) RAILS_ENV=production bin/rails assets:precompile
```

**Note:** Using `SECRET_KEY_BASE` environment variable to avoid Rails credential errors during precompile.

### Step 3: Commit Changes
```bash
git add .
git commit -m "Add tailwind safelist and rebuilt assets"
```

## Verification

After applying the fix:
- Tailwind CSS bundle now includes color utilities
- File size increased due to preserved utilities
- Classes like `bg-gray-900`, `text-white`, `text-gray-500`, etc. are now present in the compiled CSS

### Current config/tailwind.config.js
```javascript
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./app/components/**/*.{rb,erb}",
    "./app/**/*.html.erb",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  safelist: [
    { pattern: /^(bg|text|border)-(?:darkBg|darkAccent|gray|blue|white|red|green)(?:-(?:50|100|200|300|400|500|600|700|800|900))?$/ },
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
```

## Additional Context

### Layout Include Tags
The application layout at `app/views/layouts/application.html.erb` includes:
```erb
<%= stylesheet_link_tag "tailwind", "data-turbo-track": "reload" %>
<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
```

**Note:** The `stylesheet_link_tag "application"` may be redundant depending on how stylesheets are organized. The primary Tailwind output comes from the `tailwind` asset.

### Asset Files Structure
Generated assets in `public/assets/`:
- `tailwind-*.css` – Main Tailwind-compiled CSS file
- `application-*.css` – Rails asset pipeline CSS (includes Tailwind directives)
- `application.tailwind-*.css` – Processed Tailwind utilities

## Future Improvements

1. **Consider removing redundant stylesheet include** if only Tailwind-compiled CSS is needed
2. **Monitor asset file sizes** – If safelist patterns grow too broad, consider more targeted patterns
3. **Test with ViewComponents** – If added to the project, verify content globs still catch classes
4. **Consider moving Tailwind config patterns to separate file** for easier maintenance

## References

- [Tailwind CSS Content Configuration](https://tailwindcss.com/docs/content-configuration)
- [Tailwind CSS Safelist](https://tailwindcss.com/docs/content-configuration#safelisting-classes)
- [Rails Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)

