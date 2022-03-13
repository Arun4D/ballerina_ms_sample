import ballerina/http;

type Config record {|

    int port;
|};

configurable Config server = ?;

service /rest/api/customer on new http:Listener(server.port) {

    resource function get .() returns Customer[]|CustomerError {
        Customer[]|error allCustomers = getAllCustomers();
        if allCustomers is Customer[] {
            return allCustomers;
        }

        return <CustomerError>{
            body: {
                errmsg: "Customer Not Found"
            }
        };
    }

    resource function post .(@http:Payload Customer customer) returns int|CustomerError {
        int|error saveCustomerResult = saveCustomer(customer);
        if saveCustomerResult is int {
            return saveCustomerResult;
        }
        return <CustomerError>{
            body: {
                errmsg: "Unable to add customer"
            }

        };
    }

    resource function get [int customerId]() returns Customer|CustomerError {
        Customer|CustomerError|error customer = getCustomerById(customerId);
        if customer is Customer|CustomerError {

            return customer;
        } else {
            return <CustomerError>{
                body: {
                    errmsg: "Unable to find customer by id"
                }
            };
        }

    }

    resource function delete [int customerId]() returns int|CustomerError {

        int|CustomerError|error result = deleteCustomerById(customerId);
        if result is int|CustomerError {

            return result;
        } else {
            return <CustomerError>{
                body: {
                    errmsg: "Unable to find customer by id"
                }
            };
        }

    }

    resource function put .(@http:Payload Customer customer) returns int|CustomerError {

        int|error saveCustomerResult = updateCustomer(customer);
        if saveCustomerResult is int {
            return saveCustomerResult;
        }
        return <CustomerError>{
            body: {
                errmsg: "Unable to update customer"
            }

        };
    }
}
