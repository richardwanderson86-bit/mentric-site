/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"scandia-web"', '"Inter"', "system-ui", "sans-serif"],
        display: ['"scandia-web"', '"Inter"', "system-ui", "sans-serif"],
      },
      colors: {
        primary: {
          DEFAULT: "#862369",
          dark: "#2e0025",
          light: "#fdf2fa",
          50: "#fdf2fa",
          100: "#fce7f6",
          200: "#facaed",
          300: "#f7a1db",
          400: "#f06ec1",
          500: "#c03793",
          600: "#862369",
          700: "#6b1c54",
          800: "#4a1339",
          900: "#2e0025",
        },
        glow: "#c03793",
        accent: {
          DEFAULT: "#fcba17",
          light: "#fde68a",
          dark: "#d49a00",
        },
        ink: "#2e0025",
        muted: "#64748b",
        foreground: "#0f172a",
        background: "#f8fafc",
        card: "#ffffff",
        border: "#e8e8eb",
      },
      borderRadius: {
        xl: "1.25rem",
        "2xl": "1.5rem",
        "3xl": "2rem",
      },
      letterSpacing: {
        editorial: "-0.03em",
        tight: "-0.025em",
      },
      lineHeight: {
        relaxed: "1.7",
        editorial: "1.15",
      },
      boxShadow: {
        glow: "0 0 24px rgba(192, 55, 147, 0.25)",
        "glow-lg": "0 0 48px rgba(192, 55, 147, 0.3)",
        editorial: "0 1px 3px rgba(46, 0, 37, 0.06), 0 1px 2px rgba(46, 0, 37, 0.04)",
        "editorial-lg": "0 10px 40px rgba(46, 0, 37, 0.08)",
      },
      animation: {
        "fade-in": "fadeIn 0.5s ease-out",
        "slide-up": "slideUp 0.5s ease-out",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideUp: {
          "0%": { opacity: "0", transform: "translateY(12px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
