import ballerinax/java.jdbc;
import ballerina/sql;
import ballerina/log;

type Customer record {|
    readonly int customerId;
    string firstName;
    string lastName;
    string dob;
    string phoneNumber;
|};

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string URL = ?;

final jdbc:Client h2DbClient = check new (URL, USER, PASSWORD);

public function jdbcInit() returns sql:ExecutionResult|sql:Error {
    return check h2DbClient->execute(`CREATE TABLE IF NOT EXISTS Customer(customerId INT AUTO_INCREMENT PRIMARY KEY, firstName VARCHAR(25), lastName VARCHAR(25), dob VARCHAR(10), phoneNumber VARCHAR(15))`);
}

function saveCustomer(Customer customer) returns int|error {
    log:printDebug("Enter saveCustomer.");

    sql:ExecutionResult|sql:Error result = h2DbClient->execute(`
        INSERT INTO Customer ( firstName, lastName, dob, phoneNumber)
        VALUES (${customer.firstName}, ${customer.lastName},  
                ${customer.dob}, ${customer.phoneNumber});
    `);

    log:printDebug("Result: ", id = check result);
    if result is sql:ExecutionResult {
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            log:printDebug("lastInsertId: ", id = lastInsertId);
            return lastInsertId;
        } else {
            log:printError("Error: ", id = lastInsertId);
            return error("Unable to find last insertion id value");
        }
    }

    log:printDebug("Exit saveCustomer.");

    return result;

}

function updateCustomer(Customer customer) returns int|error {
    log:printDebug("Enter saveCustomer.");

    sql:ExecutionResult|sql:Error result = h2DbClient->execute(`
        Update Customer set 
        firstName = ${customer.firstName},
        lastName = ${customer.lastName},
        dob = ${customer.dob},
        phoneNumber = ${customer.phoneNumber}
        Where customerId = ${customer.customerId}
    `);

    log:printDebug("Result: ", id = check result);
    if result is sql:ExecutionResult {
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            log:printDebug("lastInsertId: ", id = lastInsertId);
            return lastInsertId;
        } else {
            log:printError("Error: ", id = lastInsertId);
            return error("Unable to find last insertion id value");
        }
    }

    log:printDebug("Exit saveCustomer.");

    return result;

}


function getAllCustomers() returns Customer[]|error {

    log:printDebug("Enter getAllCustomers.");

    Customer[] result = [];
    stream<Customer, error?> customerStream = h2DbClient->query(`Select * from Customer`);
    check from Customer customer in customerStream
        do {
            result.push(customer);
        };
    check customerStream.close();

    log:printDebug("Exit getAllCustomers.");

    return result;
}

function getCustomerById(int id) returns Customer|CustomerError|error {
    log:printDebug("Enter getCustomerById.");

    Customer customer = check h2DbClient->queryRow(`Select * from Customer where customerId = ${id}`);

    log:printDebug("Exit getCustomerById.");

    return customer;
}

function deleteCustomerById(int id) returns int|CustomerError|error {
    log:printDebug("Enter deleteCustomerById.");

    sql:ExecutionResult result = check h2DbClient->execute(`Delete from Customer where customerId = ${id}`);

    int? affectedRowCount = result.affectedRowCount;

    int|error value;
    if affectedRowCount is int {
        value = affectedRowCount;
    } else {
        value = error("unable to delete");
    }
    log:printDebug("Exit deleteCustomerById.");

    return value;
}
