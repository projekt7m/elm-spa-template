const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common, {
  mode: 'production',
  output: {
    filename: '[name].[contenthash].js'
  },
  module: {
    rules: [
    {
      test: /\.(png|jpg|jpeg|svg)$/,
      use: [
        {
          loader: 'url-loader',
          options: {
            limit: 8192,
            name: '[name].[contenthash].[ext]'
          }
        }
      ]
    },
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: '[name].[contenthash].css'
    })
  ]
});
