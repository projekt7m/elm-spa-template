const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    index: "./src/index.js",
  },
  output: {
    filename: process.env.production ? '[name].[contenthash].css' : '[name].js'
  },
  optimization: {
    minimizer: [
      `...`,
      new CssMinimizerPlugin()
    ]
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
      test: /\.(png|jpg|jpeg|svg)$/,
      use: [
        {
          loader: 'url-loader',
          options: {
            limit: 8192,
            name: process.env.production ? '[name].[contenthash].[ext]' : '[name].[ext]'
          }
        }
      ]
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
    new CleanWebpackPlugin(),
    new MiniCssExtractPlugin({
      filename: process.env.production ? '[name].[contenthash].css' : '[name].css'
    })
  ]
}
