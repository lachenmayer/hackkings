# Require.js config
require
  urlArgs: "b=#{(new Date()).getTime()}"
  paths:
    jquery: 'vendor/jquery/jquery'
  , ['app/main'], (main) -> main()