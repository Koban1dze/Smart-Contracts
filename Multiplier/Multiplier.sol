pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplier {


     uint public multi = 1;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

    modifier checkOwnerAndAccept{
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function result(uint value) public checkOwnerAndAccept {
        require(value <=  10 && value > 0,101,"The value is in range [1,10]"); 
    multi*=value;
    }
}
