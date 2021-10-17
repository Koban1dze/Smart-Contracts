pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {

    string[] public namesArray;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


   modifier checkOwnerAndAccept{
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function add(string valueAdd) public  checkOwnerAndAccept{
        namesArray.push(valueAdd);
    }
    function next() public checkOwnerAndAccept{
        require(namesArray.length >0,101,"Empty queue");
        delete namesArray[0];
        for (uint i=0;i<namesArray.length-1;i++){
            namesArray[i]=namesArray[i+1];
        }
        namesArray.pop();
    }
}