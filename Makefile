
# Variables
containerName = "portainer"

# https://docs.portainer.io/start/install-ce/server/docker/linux
# Run the program
run:
	docker volume create portainer_data
	docker run -d -p 8000:8000 -p 9443:9443 --name $(containerName) --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.4

# Clean up build
clean:
	docker stop $(containerName)
	docker container rm -f $(containerName)
	docker rmi $(containerName)/portainer-ce:2.21.4
	docker volume rm portainer_data
	docker image prune -a -f



# Help target to display usage
help:
	@echo "Available targets:"
	@echo "  run     - Run the program"
	@echo "  clean   - Remove build"
	@echo "  help    - Show this help message"

# Phony targets
.PHONY: run help

#LOGGING in : https://localhost:9443