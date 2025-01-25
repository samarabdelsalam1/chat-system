# chat-system
Chat-System is an application that allows users to create applications, manage chats, send messages and search for messages in a specific chat.

## Environment
* Ruby: 3.2.6
* Database: MySQL 8.0
* Cache: Redis 7.0.12
* Search: Elasticsearch 7.17.27
* Containerization: Docker
* Testing: RSpec 7.1.0
 
 ## Prerequisites

Before getting started, ensure that you have the following installed:

- Docker
- Docker Compose

If you haven't already, you can install [Docker](https://www.docker.com/get-started) and [Docker Compose](https://docs.docker.com/compose/install/) on your machine.

## Set up and Installation

1. **Create the Docker network**:  
   The application requires a specific Docker network for communication between services. Create it by running:
   
 ```sh
    docker network create chat-system_private_network
  ```
2. **Build and start the containers**: 

```sh
   docker-compose up
```
3. **Access the application**:
  Once the services are up and running, the web server will be available at:
  - http://localhost:3000   

## Running Tests
 To run the tests with RSpec, execute the following command:
  ```sh
  docker compose exec app rspec
  ```
## Background Jobs and Cron Jobs  

### Scheduled Jobs
 - **ChatsCounterUpdaterJob**:
  A job runs evey one hour to update the chats count for each application
 - **MessagesCountUpdaterJobs**:
  A job runs evey one hour to update the messages count for each chat
## Backgroud Jobs
  - **MessageCreationJob**:
    A job for creating messages in the background
  - **ChatCreationJob**:
    A job for creating chats in the background


## API Documentation
 The application's API is documented using Swagger and can be accessed at:
  - http://localhost:3000/api-docs/index.html
  
