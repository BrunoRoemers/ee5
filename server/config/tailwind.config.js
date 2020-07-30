module.exports = {
  theme: {
    screens: {
      'xs': '430px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
    },
    fontFamily: {
      heading: ['montserrat',
        'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI',
        'Roboto', 'Helvetica Neue', 'Arial', 'Noto Sans', 'sans-serif',
        'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol',
        'Noto Color Emoji'
      ],
      body: ['system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI',
        'Roboto', 'Helvetica Neue', 'Arial', 'Noto Sans', 'sans-serif',
        'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol',
        'Noto Color Emoji'
      ],
    },
    extend: {
      spacing: {
        '7': '1.75rem',
        '9': '2.25rem',
        '11': '2.75rem',
        '96': '24rem',
        '128': '32rem',
      },
      inset: {
        'icon': '0.25rem',
      },
      colors: {
        'page': '#eeeeee',
        'card': '#ffffff',
        'primary': '#81a2ac',
      },
    },
  },
  variants: {
    borderColor: ['responsive', 'hover', 'focus'],
    // borderWidth: ['responsive', 'hover', 'focus'],
  },
  plugins: [],
}
