import ballerina_ms_sample.customer_service;
import ballerina/sql;
import ballerina/log;

public function main() returns error? {
    sql:ExecutionResult|sql:Error initValue = customer_service:jdbcInit();
    log:printDebug("DB init: ", id = check initValue);
    if initValue is sql:Error|error {
        log:printDebug("Error: ",'error = initValue);
        panic initValue;
    }
}
