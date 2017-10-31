# Setup VueJS Demo

**Contents**

- [Requirements](#requirements)
- [Setup](#setup)
    - [Other useful make commands](#other-useful-make-commands)

### Requirements

For usage with Docker:

- Docker CE  
  [HowTo for Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository)   
  [HowTo for MacOS](https://docs.docker.com/docker-for-mac/install/) 
- docker-compose  
  [HowTo for Ubuntu](https://docs.docker.com/compose/install/)   
  [HowTo for MacOS](https://docs.docker.com/docker-for-mac/install/) 

## Setup

- Clone repository
  ```
  git clone https://github.com/coding-berlin/vuejs-demo/
  cd vuejs-demo
  ```
  
- Run setup 
  ```bash
  make setup
  ```
    
To verify your installation, open a browser tab:

[http://localhost:8181/](http://localhost:8181/)

### Other useful make commands

- Start container
  ```bash
  make start
  ```

- Stop container
  ```bash
  make stop
  ```
  
- Open shell in container
  ```bash
  make cli
  ```
  
- Show all commands
  ```bash
  make help
  ```
