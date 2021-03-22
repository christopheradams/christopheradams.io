const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: './_src/app.js',
  output: {
    filename: 'js/app.js',
    path: path.resolve(__dirname, 'assets', 'dist')
  },
  module: {
    rules: [
      {
        test: /\.(scss)$/,
        use: [{
          loader: MiniCssExtractPlugin.loader
        }, {
          loader: 'css-loader', // translates CSS into CommonJS modules
        }, {
          loader: 'postcss-loader', // Run post css actions
          options: {
            plugins: function () { // post css plugins, can be exported to postcss.config.js
              return [
                require('precss'),
                require('autoprefixer')
              ];
            }
          }
        }, {
          loader: 'sass-loader' // compiles Sass to CSS
        }]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: 'css/app.css' })
  ]
};
