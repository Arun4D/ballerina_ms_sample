import ballerina/http;

public type CustomerError record {|
    *http:NotFound;
    ErrorMsg body;
|};



public type ErrorMsg record {|
   string errmsg;
|};
