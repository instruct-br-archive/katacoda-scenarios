
export default {
  server: {
    host: '0.0.0.0',
  },
  mode: 'spa',
  head: {
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' }
    ]
  }
}
