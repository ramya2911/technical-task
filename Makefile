APP_IMAGE=:latest
APP_RUNNING_PORT=4000

start:
	docker run -d -p 4000:4000 --name sbg-tech-test-app ngr05/sbg-gaming-seit-tech-test

stop:
	docker stop sbg-tech-test-app
	docker rm sbg-tech-test-app

logs:
	docker logs -f sbg-tech-test-app

test: stop start
	-newman run Sbg_game.postman_collection.json -d datainvalidid.csv -n 5 --folder UnHappyPathQuery -r htmlextra --reporter-htmlextra-export ./test-reports/unHappyQuery.html
	-newman run Sbg_game.postman_collection.json -d dataGetGameHappyPath.csv -n 5 --folder HappyPathQuery -r htmlextra --reporter-htmlextra-export ./test-reports/HappyQuery.html	
	-newman run Sbg_game.postman_collection.json -d dataAddGameHappyPath.csv -n 3 --folder HappyPathMutation -r htmlextra --reporter-htmlextra-export ./test-reports/HappyMutation.html
	-newman run Sbg_game.postman_collection.json -d dataAddGameUnHappyPath.csv -n 3 --folder UnHappyPathMutation -r htmlextra --reporter-htmlextra-export ./test-reports/UnHappyMutation.html
	echo "Test Completed - Access report from ./test-reports/*.html" 
	