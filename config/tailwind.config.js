const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./app/components/**/*.{rb,erb}",  // якщо використовуєте ViewComponents
    "./app/**/*.html.erb",             // це найнадійніше — ловить усе
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  safelist: [
    // preserve commonly used color utilities that may be generated dynamically
    { pattern: /^(bg|text|border)-(?:darkBg|darkAccent|gray|blue|white|red|green)(?:-(?:50|100|200|300|400|500|600|700|800|900))?$/ },
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
