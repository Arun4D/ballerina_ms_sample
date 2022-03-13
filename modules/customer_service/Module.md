# Customer Service Module

Modules to store customer details. 

## Services
Get all customers details

````
curl http://localhost:8090/rest/api/customer
````

Add new customer record
````
curl -X POST  http://localhost:8090/rest/api/customer -d '{"customerId":0,"firstName":"Arun", "lastName":"D","dob":"09-10-9185","phoneNumber":"9048143014"}'
````
Get customer details by customer id 
````
curl -X GET  http://localhost:8090/rest/api/customer/1
````

Update customer details
````
curl -X PUT  http://localhost:8090/rest/api/customer -d '{"customerId":3,"firstName":"Arun", "lastName":"Duraisamy","dob":"09-10-9185","phoneNumber":"9048143014"}'5'
````
Remove customer
````
curl -X DELETE -X PUT  http://localhost:8090/rest/api/customer/1
````
## Reference
Provides an overview about the module when generating the API documentations.
For example, refer to https://lib.ballerina.io/ballerina/io/latest

