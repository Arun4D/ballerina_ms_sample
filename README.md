# Ballerina Sample Microservice

Sample micro service implementation using ballerina. 

## Why Ballerina
* cloud native
* Programs have both a textual syntax and an equivalent graphical form based on sequence diagrams.
* SQL like syntax to process data and events
* Explicit error handling
* Good for Integration services.  

## Step followed

Create ballerina project

````
$ bal new ballerina_ms_sample
$ cd ballerina_ms_sample
$ bal add customer_service
$ cd ../
````
## Local Build & Run 

Run the code
````
$ bal run ./ballerina_ms_sample
````

Build the code
````
$ bal build ./ballerina_ms_sample
````

## Adding dependency

Refer Ballerina.toml to add dependency like H2 and we can specify H2 for specific module.

## Adding property / env specific config

Refer Config.toml to add configs like database url, user, password, server port etc..

## Database init
In the main.bal added database init.

## Modules

Refer [customer service module](./modules/customer_service/Module.md).


## Reference

* https://ballerina.io/learn/