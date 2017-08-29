elm-app start &
http-proxy --hostname 0.0.0.0 --port 8081 3000 &
java -jar recipevault_api.jar