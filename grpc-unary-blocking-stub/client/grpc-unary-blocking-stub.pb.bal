package client;
import ballerina.net.grpc;

public connector helloWorldBlockingStub (string host, int port) {
    endpoint<grpc:GRPCConnector> ep {
        create grpc:GRPCConnector(host, port, "blocking", descriptorKey, descriptorMap);
    }

    action hello (string req) (string, error) {
        var res, err1 = ep.blockingExecute("helloWorld/hello", req);
        if (err1 != null && err1.message != null) {
            error e = {message:err1.message};
            return null, e;
        }
        var response, err2 = (string)res;
        if (err2 != null && err2.message != null) {
            error e = {message:err2.message};
            return null, e;
        }
        return response, null;
    }
}

public connector helloWorldNonBlockingStub (string host, int port) {
    endpoint<grpc:GRPCConnector> ep {
        create grpc:GRPCConnector(host, port, "non-blocking", descriptorKey, descriptorMap);
    }

    action hello (string req, string serviceName) (error) {
        var err1 = ep.nonBlockingExecute("helloWorld/hello", req, serviceName);
        if (err1 != null && err1.message != null) {
            error e = {message:err1.message};
            return e;
        }
        return null;
    }
}


const string descriptorKey = ".helloWorld.proto";
map descriptorMap = {
                        ".helloWorld.proto":"0A1068656C6C6F576F726C642E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F32530A0A68656C6C6F576F726C6412450A0568656C6C6F121B676F6F676C652E70726F746F6275662E537472696E6756616C75651A1B676F6F676C652E70726F746F6275662E537472696E6756616C756528003000620670726F746F33",
                        "google.protobuf.google/protobuf/wrappers.proto":"0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F627566221C0A0B446F75626C6556616C7565120D0A0576616C7565180120012801221B0A0A466C6F617456616C7565120D0A0576616C7565180120012802221B0A0A496E74363456616C7565120D0A0576616C7565180120012803221C0A0B55496E74363456616C7565120D0A0576616C7565180120012804221B0A0A496E74333256616C7565120D0A0576616C7565180120012805221C0A0B55496E74333256616C7565120D0A0576616C756518012001280D221A0A09426F6F6C56616C7565120D0A0576616C7565180120012808221C0A0B537472696E6756616C7565120D0A0576616C7565180120012809221B0A0A427974657356616C7565120D0A0576616C756518012001280C427C0A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A2A6769746875622E636F6D2F676F6C616E672F70726F746F6275662F7074797065732F7772617070657273F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
                    };