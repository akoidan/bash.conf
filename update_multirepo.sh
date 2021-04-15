# use source update_multirepo.sh

# this code allows to update microservice repositories
update_code_db() {
  update_service $1 && 
  echo "migrate db $1" &&
  yarn run db:run:migrate &&
  serv_sucess $1 ||
  serv_failed $1
}

update_code () {
  update_service $1 && 
  serv_sucess $1 ||
  serv_failed $1
}


update_service() {
  nvm use 14.15.3 &&
  cd /home/andrew/WebstormProjects/services/$1 &&
  export USER=native &&
  echo "git fetch  $1" &&
  git checkout develop &&
  git pull &&
  echo "yarn install $1" &&
  yarn install &&
  echo "yarn compile $1" &&
  yarn run tsc
}

serv_sucess() {
  echo -e "\033[32m $1 done\033[0m"
  echo -e "\033[32m $1 done\033[0m" >> ../r2d2_status.txt
}
serv_failed() {
  echo -e "\033[31m $1 failed\033[0m" 
  echo -e "\033[31m $1 failed\033[0m" >> ../r2d2_status.txt
}
nvm use v14.15.3
update_code_db service_a &
update_code_db service_b &
update_code federation-gateway &
wait
cat ./r2d2_status.txt
rm -v ./r2d2_status.txt
