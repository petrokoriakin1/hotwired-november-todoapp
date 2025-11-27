# E2E Tests: Stylesheet Rendering Verification

This directory contains Playwright-based end-to-end tests to verify that Tailwind CSS stylesheets are correctly loaded and styles are properly applied to the application.

## Overview

The `stylesheets.spec.js` test suite validates:

- ✅ Stylesheet links are present in the HTML head
- ✅ Tailwind CSS is loaded correctly
- ✅ Application CSS is loaded correctly
- ✅ Body element has correct Tailwind classes (`bg-gray-900`, `text-white`)
- ✅ Computed styles match Tailwind utility expectations
- ✅ Container styling (margins, padding) is applied
- ✅ Custom element styling (turbo-frame, alerts) is correct
- ✅ No stylesheet loading errors occur
- ✅ All stylesheet links resolve with HTTP 200

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Ensure Rails Server is Running

The test suite expects a Rails development or test server at `http://localhost:3000`.

You can run the dev server with:
```bash
./bin/dev
```

Or run the Rails server directly:
```bash
rails server
```

## Running Tests

### Run All Tests
```bash
npm test
```

### Run Tests in UI Mode (Interactive)
```bash
npm run test:ui
```

This opens Playwright's interactive UI where you can run tests step-by-step, inspect elements, and view detailed reports.

### Run Tests in Headed Mode (See Browser)
```bash
npm run test:headed
```

This runs tests with visible browser windows.

### Debug Tests
```bash
npm run test:debug
```

This opens the Playwright Inspector for step-by-step debugging.

### Run a Specific Test
```bash
npx playwright test test/e2e/stylesheets.spec.js -g "should load tailwind stylesheet"
```

### Run Tests for a Specific Browser
```bash
npx playwright test --project=chromium
npx playwright test --project=firefox
npx playwright test --project=webkit
```

## Test Report

After tests complete, an HTML report is generated:
```bash
npx playwright show-report
```

This opens the detailed test report in your browser, including screenshots and videos of test runs.

## Test Structure

### stylesheets.spec.js

**Stylesheet Loading Tests:**
- `should load tailwind stylesheet` – Verifies Tailwind link tag is present
- `should load application stylesheet` – Verifies app CSS link tag is present
- `should verify all stylesheet links resolve correctly` – Validates HTTP 200 responses

**CSS Class Application Tests:**
- `should apply bg-gray-900 and text-white to body` – Checks classes are on the element
- `should have container with mx-auto and px-5 classes` – Validates main element classes
- `should verify notice alert styles` – Checks alert element styling if present
- `should verify error alert styles` – Checks error element styling if present

**Computed Style Tests:**
- `should compute correct background color from bg-gray-900 class` – Validates bg color is rgb(17, 24, 39)
- `should compute correct text color from text-white class` – Validates text color is rgb(255, 255, 255)
- `should have padding from px-5 class` – Validates padding is 20px
- `should have mt-28 (margin-top) on main` – Validates margin-top is 112px
- `should have margin from mx-auto class` – Validates margins are auto

**Additional Tests:**
- `should verify turbo-frame display styling` – Checks turbo-frame CSS
- `should have no stylesheet loading errors` – Monitors console and network errors

## CI/CD Integration

### GitHub Actions Example

Add to `.github/workflows/e2e.yml`:

```yaml
name: E2E Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      sqlite:
        image: ubuntu:latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.4.7
          bundler-cache: true

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Set up database
        run: bundle exec rails db:setup

      - name: Build assets
        run: bundle exec rails assets:precompile

      - name: Run E2E tests
        run: npm test
        env:
          CI: true

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/
```

## Troubleshooting

### Tests timeout waiting for server
- Ensure the Rails server is running on port 3000
- Check `baseURL` in `playwright.config.js`
- Increase timeout in test:
  ```javascript
  test.setTimeout(60 * 1000);
  ```

### Stylesheet links return 404
- Verify assets are precompiled:
  ```bash
  RAILS_ENV=development rails assets:precompile
  ```
- Check that asset filenames match what's in the manifest

### Computed styles don't match expectations
- Inspect the page in browser DevTools to verify actual styles
- Check if CSS is being overridden by other rules
- Verify `config/tailwind.config.js` safelist includes necessary colors

### Tests pass locally but fail in CI
- Ensure Rails server starts before tests run
- Use `reuseExistingServer: false` in CI environment
- Check for timing issues with `waitForLoadState('networkidle')`

## Additional Resources

- [Playwright Documentation](https://playwright.dev)
- [Tailwind CSS Documentation](https://tailwindcss.com)
- [Rails Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)

## Related Files

- `config/tailwind.config.js` – Tailwind configuration with content globs and safelist
- `app/views/layouts/application.html.erb` – Layout with stylesheet links and Tailwind classes
- `.github/tailwind-prod-fix.md` – Documentation of stylesheet debugging and fixes
