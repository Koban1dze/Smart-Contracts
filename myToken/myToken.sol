pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract myToken {
    struct tokenCar {
        string carName;    
        string carColor;
        uint speed;   
    } 

    tokenCar[] tokenArray;
    mapping (uint=>uint) TokenID;
    mapping (uint=>uint) Price;
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    modifier OwnerSell(uint valueIndex ) {
        require(TokenID[valueIndex] == msg.pubkey(), 101); 
        _;
    }

    function createToken(string valueName,string valueColor, uint valueSpeed) public  {
        for (uint256 index = 0; index < tokenArray.length; index++) {
        require(valueName != tokenArray[index].carName, 101);
        }
        tokenArray.push(tokenCar(valueName,valueColor,valueSpeed));
        uint key = tokenArray.length-1;
        TokenID[key]=msg.pubkey();
        tvm.accept();
    }

    function getTokenInfo (uint valueIndex) public returns(string carName, string carColor, uint speed, optional(uint) price) {
        carName = tokenArray[valueIndex].carName;
        carColor = tokenArray[valueIndex].carColor;
        speed = tokenArray[valueIndex].speed;
        if (Price[valueIndex]>0)
            price = Price[valueIndex];

        tvm.accept();
    }
    function sell(uint valueIndex,uint valuePrice) public OwnerSell(valueIndex) {
        Price[valueIndex] = valuePrice;
        tvm.accept();
    }

}
