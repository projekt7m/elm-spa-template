const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require("path");

module.exports = {
  entry: {
    index: "./src/index.js",
  },
  optimization: {
    minimizer: [
      `...`,
      new CssMinimizerPlugin()
    ]
  },
  output: {
    path: path.resolve(__dirname, "dist")
  },
  module: {
    rules: [{
      test: /\.m?js$/,
      exclude: /(node_modules|bower_components)/,
      use: {
        loader: 'babel-loader',
        options: {
          presets: ['@babel/preset-env']
        }
      }
    },
    {
      test: /\.css$/,
      use: [MiniCssExtractPlugin.loader,
            { loader: 'css-loader', options: { importLoaders: 1 } },
            'postcss-loader']
    },
    {
      test: /\.html$/,
      exclude: /node_modules/,
      loader: 'file-loader'
    },
    {
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: [
        {
          loader: "babel-loader",
          options: {
            plugins: ["module:babel-elm-assets-plugin"]
          }
        },
        {
          loader: 'elm-hot-webpack-loader'
        },
        {
          loader: require.resolve('elm-webpack-loader')
        }
      ]
    }]
  },
  plugins: [
    new HtmlWebpackPlugin({
      chunks: ['index'],
      inject: false,
      template: 'src/index.ejs',
      xhtml: true
    }),
    new CleanWebpackPlugin()
  ]
}
