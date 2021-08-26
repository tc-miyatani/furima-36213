#! /bin/bash
# `chmod +x heroku.sh`する必要あり

if [ $# -eq 0 ]; then
  echo '1個の引数が必要です'
elif [ $# -eq 1 ]; then
  if [ $1 = 'reset' ]; then
    # heroku run DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:drop db:create db:migrate
    heroku run DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:migrate:reset db:seed
  elif [ $1 = 'deploy' ]; then
    git push heroku master
  elif [ $1 = 'deploy!' ]; then
    git commit --allow-empty -m "空のcommit" 
    git push heroku master
  else
    echo '引数の指定が間違っています' $#
  fi
elif [ $# -eq 3 ]; then
  if [ $1 = 'basic' ]; then
    heroku config:set BASIC_AUTH_USER=$2
    heroku config:set BASIC_AUTH_PASSWORD=$3
    echo 'セットした環境変数はデプロイを実行しないと反映されません'
  else
    echo '引数の指定が間違っています' $#
  fi
else
  echo '引数の数が間違っています' $#
fi
