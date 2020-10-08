module.exports = {
  devServer: {
    proxy: {
      "^/api": {
        target: "http://nfl-rushing-backend:4000",
        ws: true,
        changeOrigin: true,
      },
    },
  },
};
